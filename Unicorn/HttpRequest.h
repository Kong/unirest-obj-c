#import "HttpResponse/HttpStringResponse.h"
#import "HttpResponse/HttpBinaryResponse.h"
#import "HttpResponse/HttpJsonResponse.h"

typedef enum HttpMethod
{
	GET,
	POST,
	PUT,
	DELETE,
    PATCH
} HttpMethod;

@interface HttpRequest : NSObject {
    
    NSDictionary* _headers;
    NSString* _url;
    HttpMethod _httpMethod;
    
}

@property(readwrite, retain) NSDictionary* headers;
@property(readwrite, retain) NSString* url;
@property(readwrite) HttpMethod httpMethod;

-(HttpRequest*) initWithSimpleRequest:(HttpMethod) httpMethod url:(NSString*) url headers:(NSDictionary*) headers;

-(HttpStringResponse*) asString;
-(void) asStringAsync:(void (^)(HttpStringResponse*)) response;

-(HttpBinaryResponse*) asBinary;
-(void) asBinaryAsync:(void (^)(HttpBinaryResponse*)) response;

-(HttpJsonResponse*) asJson;
-(void) asJsonAsync:(void (^)(HttpJsonResponse*)) response;

@end
