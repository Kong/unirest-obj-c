/*
 * Mashape Objective-C Client library.
 *
 * Copyright (C) 2011 Mashape, Inc.
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

#import "HttpClient.h"
#import "UrlUtils.h"
#import "AuthUtil.h"
#import "../Exceptions/MashapeClientException.h"
#import "../Parser/ParserFactory.h"


@interface HttpClient()
// Private methods
+ (NSString*) execRequest:(NSString*)httpMethod url:(NSString*)url parameters:(NSMutableDictionary*) parameters mashapeAuthentication:(BOOL) mashapeAuthentication publicKey:(NSString*) publicKey privateKey:(NSString*)privateKey;
+ (id) makeRequest: (HttpMethod)httpMethod url:(NSString*)url parameters:(NSMutableDictionary*) parameters mashapeAuthentication:(BOOL) mashapeAuthentication publicKey:(NSString*) publicKey privateKey:(NSString*)privateKey encodeJson:(BOOL) encodeJson callback:(id<MashapeDelegate>) callback;
@end

@implementation HttpClient

+ (NSOperationQueue*) doRequest: (HttpMethod)httpMethod url:(NSString*)url parameters:(NSMutableDictionary*) parameters mashapeAuthentication:(BOOL) mashapeAuthentication publicKey:(NSString*) publicKey privateKey:(NSString*)privateKey encodeJson:(BOOL) encodeJson callback:(id<MashapeDelegate>) callback {

	NSOperationQueue* queue = [NSOperationQueue new];
	
	SEL methodSelector = @selector(makeRequest:url:parameters:mashapeAuthentication:publicKey:privateKey:encodeJson:callback:);
	NSMethodSignature * methodSignature = [self methodSignatureForSelector:methodSelector];
	NSInvocation * invocation = [NSInvocation 
									invocationWithMethodSignature:methodSignature];
	[invocation setTarget:self];
	[invocation setSelector:methodSelector];
	
	[invocation setArgument:&httpMethod atIndex:2];
	[invocation setArgument:&url atIndex:3];
	[invocation setArgument:&parameters atIndex:4];
	[invocation setArgument:&mashapeAuthentication atIndex:5];
    [invocation setArgument:&publicKey atIndex:6];
    [invocation setArgument:&privateKey atIndex:7];
   	[invocation setArgument:&encodeJson atIndex:8];
	[invocation setArgument:&callback atIndex:9];
	[invocation retainArguments]; 
	
	/* Create our NSInvocationOperation to call loadDataWithOperation, passing in nil */
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithInvocation:invocation];
	/* Add the operation to the queue */
    [queue addOperation:operation];
    [operation release];
	return [queue autorelease];
}

+ (id) doRequest: (HttpMethod)httpMethod url:(NSString*)url parameters:(NSMutableDictionary*) parameters mashapeAuthentication:(BOOL) mashapeAuthentication publicKey:(NSString*) publicKey privateKey:(NSString*)privateKey encodeJson:(BOOL) encodeJson {
    return [self makeRequest:httpMethod url:url parameters:parameters mashapeAuthentication:mashapeAuthentication publicKey:publicKey privateKey:privateKey encodeJson:encodeJson callback:nil];
}

+ (id) makeRequest: (HttpMethod)httpMethod url:(NSString*)url parameters:(NSMutableDictionary*) parameters mashapeAuthentication:(BOOL) mashapeAuthentication publicKey:(NSString*) publicKey privateKey:(NSString*)privateKey encodeJson:(BOOL) encodeJson callback:(id<MashapeDelegate>) callback {
	
	[UrlUtils prepareRequest:&url parameters:&parameters addRegularQueryStringParameters:(httpMethod == GET ? NO : YES)];
	
	NSString* response = nil;
	
	switch (httpMethod) {
		case GET:
			response = [self execRequest:@"GET" url:url parameters:parameters mashapeAuthentication:mashapeAuthentication publicKey:publicKey privateKey:privateKey];
			break;
		case POST:
			response = [self execRequest:@"POST" url:url parameters:parameters mashapeAuthentication:mashapeAuthentication publicKey:publicKey privateKey:privateKey];
			break;
		case PUT:
			response = [self execRequest:@"PUT" url:url parameters:parameters mashapeAuthentication:mashapeAuthentication publicKey:publicKey privateKey:privateKey];
			break;
		case DELETE:
			response = [self execRequest:@"DELETE" url:url parameters:parameters mashapeAuthentication:mashapeAuthentication publicKey:publicKey privateKey:privateKey];
			break;
	}
    
    id jsonObject = response;
	
    if (encodeJson) {
        SBJsonParser * parser = [ParserFactory getInstance];
        jsonObject = [parser objectWithString:response];

        if (jsonObject == nil) {
            MashapeClientException* jsonException = [[[MashapeClientException alloc] initWithCodeAndMessage:EXCEPTION_SYSTEM_ERROR_CODE message:[NSString stringWithFormat:EXCEPTION_INVALID_REQUEST, response]] autorelease];
            if (callback == nil) {
                [jsonException raise];
            } else {
                [callback errorOccurred:jsonException];
            }
        }
    }
    
	if (callback == nil) {
		return jsonObject;
	} else {
		[callback requestCompleted:jsonObject];
		return nil;
	}
	
}

+ (NSString*) execRequest:(NSString*)httpMethod url:(NSString*)url parameters:(NSMutableDictionary*) parameters mashapeAuthentication:(BOOL) mashapeAuthentication publicKey:(NSString*) publicKey privateKey:(NSString*)privateKey {

	NSURL* uri = [NSURL URLWithString:url];
	NSMutableURLRequest *request = nil;
	
    if ([httpMethod isEqualToString:@"GET"]) {
		request = [NSMutableURLRequest requestWithURL:uri];
	} else {
        
        NSArray *urlParts = [url componentsSeparatedByString:@"?"];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[urlParts objectAtIndex:0]]];
        [request setHTTPMethod:httpMethod];
        
        NSString* formParameters = @"";
        BOOL firstParameter = YES;
        
        for(id key in parameters) {
            id value = [parameters objectForKey:key];
            NSString* parameter = [NSString stringWithFormat:@"%@%@%@", [UrlUtils encodeURI:key], @"=", [UrlUtils encodeURI:value]];
            
            if (firstParameter) {
                formParameters = [NSString stringWithFormat:@"%@%@", formParameters, parameter];
            } else {
                formParameters = [NSString stringWithFormat:@"%@&%@", formParameters, parameter];
            }
            firstParameter = NO;
        }
        
        [request setHTTPBody:[formParameters dataUsingEncoding:NSUTF8StringEncoding]];
	}

    [UrlUtils generateClientHeaders:&request];
    
    if (mashapeAuthentication) {
        [AuthUtil generateAuthenticationHeader:&request publicKey:publicKey privateKey:privateKey];
    }
	
	NSURLResponse * response = nil;
	NSError * error = nil;
	NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

	return [result autorelease];

}

@end
