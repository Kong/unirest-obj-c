#import "Authentication/Authentication.h"
#import "Authentication/HeaderAuthentication.h"
#import "Authentication/BasicAuthentication.h"
#import "Authentication/QueryAuthentication.h"
#import "Authentication/MashapeAuthentication.h"
#import "HttpClient.h"
#import "HttpUtils.h"

@interface HttpClient()
+ (NSString*) encodeURI:(NSString*)value;
+ (NSString*) dictionaryToQuerystring:(NSDictionary*) parameters;
@end

@implementation HttpClient

+(MashapeResponse*) doRequest:(HttpMethod)httpMethod url:(NSString*)url parameters:(NSMutableDictionary*) parameters contentType:(ContentType)contentType responseType:(ResponseType) responseType authenticationHandlers:(NSArray*) authenticationHandlers {
    
    if (parameters == nil) {
        parameters = [[NSMutableDictionary alloc]init];
    }
    NSMutableDictionary *headers = [[NSMutableDictionary alloc]init];
    
    for (Authentication *authentication in authenticationHandlers) {
        if ([authentication isKindOfClass:[QueryAuthentication class]]) {
            [parameters addEntriesFromDictionary: authentication.parameters];
        } else if ([authentication isKindOfClass:[HeaderAuthentication class]]) {
            [headers addEntriesFromDictionary: authentication.headers];
        }
    }
    
    [HttpUtils setRequestHeaders:contentType responseType:responseType headers:&headers];
    
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
    
    NSHTTPURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    MashapeResponse* mashapeResponse = [[MashapeResponse alloc] init];
    mashapeResponse.headers = [response allHeaderFields];
    mashapeResponse.code = response.statusCode;
    mashapeResponse.raw_body = data;
    
    [HttpUtils setResponse:responseType data:data outputResponse:&mashapeResponse];
    
    return mashapeResponse;
}

+ (NSString*) dictionaryToQuerystring:(NSDictionary*) parameters {
    NSString* result = @"";
    
    BOOL firstParameter = YES;
    for(id key in parameters) {
        id value = [parameters objectForKey:key];
        if ([value class] != [NSURL class] && value != nil) { // Don't encode files
            NSString* parameter = [NSString stringWithFormat:@"%@%@%@", [HttpClient encodeURI:key], @"=", [HttpClient encodeURI:value]];
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

+ (NSString*) encodeURI:(NSString*)value {
	NSString* result = (NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                    NULL,
                                                                                    (CFStringRef)value,
                                                                                    NULL,
                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                    kCFStringEncodingUTF8);
	return result;
}

@end