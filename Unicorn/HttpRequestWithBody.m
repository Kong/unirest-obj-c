#import "HttpRequestWithBody.h"

@implementation HttpRequestWithBody

@synthesize body = _body;
@synthesize parameters = _parameters;


-(HttpRequestWithBody*) initWithMultipartRequest:(HttpMethod) httpMethod url:(NSString*) url headers:(NSDictionary*) headers parameters:(NSDictionary*) parameters {
    self = [super initWithSimpleRequest:httpMethod url:url headers:headers];
    if (parameters == nil) {
        parameters = [[NSDictionary alloc] init];
    }
    [self setParameters:[parameters mutableCopy]];
    return self;
}

-(HttpRequestWithBody*) initWithBodyRequest:(HttpMethod) httpMethod url:(NSString*) url headers:(NSDictionary*) headers body:(NSData*) body {
    self = [super initWithSimpleRequest:httpMethod url:url headers:headers];
    [self setBody:body];
    return self;
}

@end
