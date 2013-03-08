#import "HttpRequest.h"

@interface HttpRequestWithBody : HttpRequest {
    
    NSData* _body;
    NSDictionary* _parameters;
    
}

@property(readwrite) NSData* body;
@property(readwrite) NSDictionary* parameters;

-(HttpRequestWithBody*) initWithMultipartRequest:(HttpMethod) httpMethod url:(NSString*) url headers:(NSDictionary*) headers parameters:(NSDictionary*) parameters;

-(HttpRequestWithBody*) initWithBodyRequest:(HttpMethod) httpMethod url:(NSString*) url headers:(NSDictionary*) headers body:(NSData*) body;

@end