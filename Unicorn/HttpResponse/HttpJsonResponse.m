#import "HttpJsonResponse.h"

@implementation HttpJsonResponse

@synthesize body = _body;

-(HttpJsonResponse*) initWithSimpleResponse:(HttpResponse*) httpResponse {
    self = [super init];
    [self setCode:[httpResponse code]];
    [self setHeaders:[httpResponse headers]];
    [self setRawBody:[httpResponse rawBody]];
    
    JsonNode* body = [[JsonNode alloc] init];
    
    NSError * error = nil;
    id json = [NSJSONSerialization JSONObjectWithData:[httpResponse rawBody] options:NSJSONReadingMutableLeaves error:&error];
    
    if ([json isKindOfClass:[NSArray class]]) {
        [body setArray:json];
    } else {
        [body setObject:json];
    }
    
    [self setBody:body];
    return self;
}

@end
