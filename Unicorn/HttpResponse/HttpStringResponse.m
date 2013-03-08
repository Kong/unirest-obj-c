#import "HttpStringResponse.h"

@implementation HttpStringResponse

@synthesize body = _body;

-(HttpStringResponse*) initWithSimpleResponse:(HttpResponse*) httpResponse {
    self = [super init];
    [self setCode:[httpResponse code]];
    [self setHeaders:[httpResponse headers]];
    [self setRawBody:[httpResponse rawBody]];
    NSString* body = [[NSString alloc] initWithData:[httpResponse rawBody] encoding:NSUTF8StringEncoding];
    [self setBody:body];
    return self;
}

@end
