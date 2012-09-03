#import "HttpClient.h"
#import "HttpUtils.h"
#import "JSON/SBJson.h"

@implementation HttpUtils

+(void) setRequestHeaders:(ContentType) contentType responseType:(ResponseType)responseType headers:(NSMutableDictionary**)headers {
    [*headers setObject:@"mashape-objectivec/2.0" forKey:@"User-Agent"];
    
    NSString* contentTypeHeader = nil;
    
    switch (contentType) {
        case C_JSON:
            contentTypeHeader = @"application/json";
            break;
        case C_FORM:
            contentTypeHeader = @"application/x-www-form-urlencoded";
            break;
        case C_BINARY:
            contentTypeHeader = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BOUNDARY];
            break;
    }
    
    [*headers setObject:contentTypeHeader forKey:@"Content-Type"];
    
     NSString* responseTypeHeader = nil;
    
    switch (responseType) {
        case R_JSON:
            responseTypeHeader = @"application/json";
            break;
        case R_BINARY:
            break;
    }
    
    [*headers setObject:responseTypeHeader forKey:@"Accept"];
    
}

+(void) setResponse:(ResponseType) responseType data:(NSData*) data outputResponse:(MashapeResponse**) outputResponse {

    switch(responseType) {
        case R_JSON:
            [*outputResponse setBody:[[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] JSONValue]];
            break;
        case R_BINARY:
            [*outputResponse setBody:data];
            break;
    }
    
}

@end
