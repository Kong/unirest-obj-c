/*
 * Mashape Objective-C Client library.
 *
 * Copyright (C) 2012 Mashape, Inc.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 *
 * The author of this software is Mashape, Inc.
 * For any question or feedback please contact us at: support@mashape.com
 *
 */

#import "Authentication/Authentication.h"
#import "Authentication/HeaderAuthentication.h"
#import "Authentication/BasicAuthentication.h"
#import "Authentication/QueryAuthentication.h"
#import "Authentication/MashapeAuthentication.h"
#import "Authentication/OAuthAuthentication.h"
#import "Authentication/OAuth10aAuthentication.h"
#import "Authentication/OAuth2Authentication.h"
#import "HttpClient.h"
#import "HttpUtils.h"
#import "Response/MashapeResponse.h"

// Delegate to handle ansync http requests
@interface HttpConnectionDelegate : NSObject <NSURLConnectionDataDelegate> {
    NSMutableData* _receivedData;
    id<MashapeDelegate> _callback;
    ResponseType _responseType;
}

@property (strong, nonatomic, readonly) NSHTTPURLResponse* response;
@property (nonatomic, readonly) BOOL finished;

+(HttpConnectionDelegate*)delegateWithResponseType:(ResponseType)responseType callback:(id<MashapeDelegate>)callback;

-(id)initWithResponseType:(ResponseType)responseType callback:(id<MashapeDelegate>)callback;
-(MashapeResponse*)generateResponse;

@end

@implementation HttpConnectionDelegate

@synthesize response = _response;
@synthesize finished = _finished;

+(HttpConnectionDelegate*)delegateWithResponseType:(ResponseType)responseType callback:(id<MashapeDelegate>)callback {
    return [[HttpConnectionDelegate alloc] initWithResponseType:responseType callback:callback];
}

-(id)initWithResponseType:(ResponseType)responseType callback:(id<MashapeDelegate>)callback {
    self = [super init];
    
    if (self) {
        
        _callback = callback;
        _responseType = responseType;
        _finished = FALSE;
        
        // Init data object
        _receivedData = [NSMutableData data];
    }
    
    return self;
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    // Save the last response and reset the data (in case of a redirect, for example)
    _response = (NSHTTPURLResponse*) response;
    [_receivedData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    // Add data to the already received
    [_receivedData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // Drop data
    [_receivedData setLength:0];
    [_callback requestCompleted:nil]; // Return nil when the request completes
    _finished = TRUE;
    
    NSLog(@"Connection failed to load: %@", [error localizedDescription]);
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // Complete, return with the response
    _finished = TRUE;
    
    // Don't parse the result when it doesn't needed
    if (_callback != nil)
        [_callback requestCompleted:[self generateResponse]];
}

-(MashapeResponse *)generateResponse {
    return [HttpUtils getResponse:_responseType httpResponse:_response data:_receivedData];
}

@end




@interface HttpClient()
+ (NSString*) dictionaryToQuerystring:(NSDictionary*) parameters;
@end

@implementation HttpClient

+(MashapeResponse*) doRequest:(HttpMethod)httpMethod url:(NSString*)url parameters:(NSMutableDictionary*) parameters contentType:(ContentType)contentType responseType:(ResponseType) responseType authenticationHandlers:(NSArray*) authenticationHandlers callback:(id<MashapeDelegate>)callback {
    
    if (parameters == nil) {
        parameters = [[NSMutableDictionary alloc]init];
    }
    NSMutableDictionary *headers = [[NSMutableDictionary alloc]init];
    
    for (Authentication *authentication in authenticationHandlers) {
        if ([authentication isKindOfClass:[QueryAuthentication class]]) {
            [parameters addEntriesFromDictionary: authentication.parameters];
        } else if ([authentication isKindOfClass:[HeaderAuthentication class]]) {
            [headers addEntriesFromDictionary: authentication.headers];
        } else if ([authentication isKindOfClass:[OAuth10aAuthentication class]]) {
            NSMutableDictionary* authenticationParameters = [authentication parameters];
            if ([url hasSuffix:@"/oauth_url"] == false && (((NSString*)[authenticationParameters objectForKey:ACCESS_TOKEN]).length == 0 ||
                ((NSString*)[authenticationParameters objectForKey:ACCESS_SECRET]).length == 0)) {
                @throw [NSException exceptionWithName:@"OAuthInvalidCredentials" reason:@"Before consuming OAuth endpoint, invoke [MashapeClient authorize:accessToken accessSecret:accessSecret] with not null values" userInfo:nil];
            }
            
            [headers setObject:[authenticationParameters objectForKey:CONSUMER_KEY] forKey:@"x-mashape-oauth-consumerkey"];
            [headers setObject:[authenticationParameters objectForKey:CONSUMER_SECRET] forKey:@"x-mashape-oauth-consumersecret"];
            NSString* accessToken = [authenticationParameters objectForKey:ACCESS_TOKEN];
            if ([accessToken length] > 0) {
                [headers setObject:accessToken forKey:@"x-mashape-oauth-accesstoken"];
            }
            NSString* accessSecret = [authenticationParameters objectForKey:ACCESS_SECRET];
            if ([accessSecret length] > 0) {
                [headers setObject:accessSecret forKey:@"x-mashape-oauth-accesssecret"];
            }
        } else if ([authentication isKindOfClass:[OAuth2Authentication class]]) {
            NSMutableDictionary* authenticationParameters = [authentication parameters];
            if ([url hasSuffix:@"/oauth_url"] == false && (((NSString*)[authenticationParameters objectForKey:ACCESS_TOKEN]).length == 0)) {
                @throw [NSException exceptionWithName:@"OAuthInvalidCredentials" reason:@"Before consuming OAuth endpoint, invoke [MashapeClient authorize:accessToken] with a not null value" userInfo:nil];
            }
         
            NSString* accessToken = [authenticationParameters objectForKey:ACCESS_TOKEN];
            if ([accessToken length] > 0) {
                [parameters setObject:accessToken forKey:ACCESS_TOKEN];
            }
        }
    }
    
    [HttpUtils setRequestHeaders:contentType responseType:responseType headers:&headers];

    // Add cookies to the headers
    [headers setValuesForKeysWithDictionary:[NSHTTPCookie requestHeaderFieldsWithCookies:[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:url]]]];
    
    NSString* querystring = [HttpClient dictionaryToQuerystring:parameters];
    
    if (httpMethod == GET) {
        url = [NSString stringWithFormat:@"%@?%@", url, querystring];
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    switch (httpMethod) {
        case GET:
            [request setHTTPMethod:@"GET"];
            break;
        case POST:
            [request setHTTPMethod:@"POST"];
            break;
        case PUT:
            [request setHTTPMethod:@"PUT"];
            break;
        case DELETE:
            [request setHTTPMethod:@"DELETE"];
            break;
        case PATCH:
            [request setHTTPMethod:@"PATCH"];
            break;
    }
    
    // Add headers
    for (NSString *key in headers) {
        NSString *value = [headers objectForKey:key];
        [request addValue:value forHTTPHeaderField:key];
    }
    
    NSMutableData* body = [[NSMutableData alloc] init];
    
    // Add body
    if (httpMethod != GET) {
        switch(contentType) {
            case C_FORM:
                body = [NSMutableData dataWithData:[querystring dataUsingEncoding:NSUTF8StringEncoding]];
                break;
            case C_BINARY:
                for(id key in parameters) {
                    id value = [parameters objectForKey:key];
                    if ([value class] == [NSURL class] && value != nil) { // Don't encode files
                        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
                        NSString* filename = [[value absoluteString] lastPathComponent];
                        
                        NSData* data = [NSData dataWithContentsOfURL:value];

                        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", key, filename] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithFormat:@"Content-Length: %d\r\n\r\n", data.length] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:data];
                    } else {
                        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithFormat:@"%@", value] dataUsingEncoding:NSUTF8StringEncoding]];
                    }
                }
                
                // Close
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
                break;
            case C_JSON:
                //TODO
                break;
        }
        
        [request setHTTPBody:body];
    }
    if (callback == nil) {
        
        // Start request
        HttpConnectionDelegate* delegate = [HttpConnectionDelegate delegateWithResponseType:responseType callback:nil];
        [NSURLConnection connectionWithRequest:request delegate:delegate];
        
        // Wait for it to complete
        while (![delegate finished]) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        
        return [delegate generateResponse];
        
    } else {
        
        // Make an async request - HttpConnectionDelegate will call the callback when the request finishes
        [NSURLConnection connectionWithRequest:request delegate:[HttpConnectionDelegate delegateWithResponseType:responseType callback:callback]];
        
     return nil;   
    }
}

+ (NSString*) dictionaryToQuerystring:(NSDictionary*) parameters {
    NSString* result = @"";
    
    BOOL firstParameter = YES;
    for(id key in parameters) {
        id value = [parameters objectForKey:key];
        if ([value class] != [NSURL class] && value != nil) { // Don't encode files
            NSString* parameter = [NSString stringWithFormat:@"%@%@%@", [HttpUtils encodeURI:key], @"=", [HttpUtils encodeURI:value]];
            if (firstParameter) {
                result = [NSString stringWithFormat:@"%@%@", result, parameter];
            } else {
                result = [NSString stringWithFormat:@"%@&%@", result, parameter];
            }
            firstParameter = NO;
        }
    }

    return result;
}

@end