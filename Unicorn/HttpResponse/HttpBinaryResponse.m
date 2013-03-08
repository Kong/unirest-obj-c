#import "HttpBinaryResponse.h"

@implementation HttpBinaryResponse

@synthesize body = _body;

-(HttpBinaryResponse*) initWithSimpleResponse:(HttpResponse*) httpResponse {
    self = [super init];
    [self setCode:[httpResponse code]];
    [self setHeaders:[httpResponse headers]];
    [self setRawBody:[httpResponse rawBody]];
    [self setBody:[httpResponse rawBody]];
    return self;
}

@end
