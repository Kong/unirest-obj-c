#import "HttpRequest.h"
#import "HttpRequestWithBody.h"
#import "HttpRequest/SimpleRequest.h"
#import "HttpRequest/MultipartRequest.h"
#import "HttpRequest/BodyRequest.h"

@interface HttpClient : NSObject 

+(HttpRequest*) get:(void (^)(SimpleRequest*)) config;

+(HttpRequestWithBody*) post:(void (^)(MultipartRequest*)) config;
+(HttpRequestWithBody*) postEntity:(void (^)(BodyRequest*)) config;

+(HttpRequestWithBody*) put:(void (^)(MultipartRequest*)) config;
+(HttpRequestWithBody*) putEntity:(void (^)(BodyRequest*)) config;

+(HttpRequestWithBody*) patch:(void (^)(MultipartRequest*)) config;
+(HttpRequestWithBody*) patchEntity:(void (^)(BodyRequest*)) config;

+(HttpRequestWithBody*) delete:(void (^)(MultipartRequest*)) config;
+(HttpRequestWithBody*) deleteEntity:(void (^)(BodyRequest*)) config;

@end
