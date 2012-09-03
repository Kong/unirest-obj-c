#import "MashapeResponse.h"
#import "MashapeDelegate.h"

typedef enum HttpMethod
{
	GET,
	POST,
	PUT,
	DELETE,
    PATCH
} HttpMethod;

typedef enum ContentType
{
	C_FORM,
	C_JSON,
	C_BINARY
} ContentType;

typedef enum ResponseType
{
	R_JSON,
	R_BINARY
} ResponseType;

@interface HttpClient : NSObject

+(MashapeResponse*) doRequest:(HttpMethod)httpMethod url:(NSString*)url parameters:(NSMutableDictionary*) parameters contentType:(ContentType)contentType responseType:(ResponseType) responseType authenticationHandlers:(NSArray*) authenticationHandlers callback:(id<MashapeDelegate>) callback;

@end
