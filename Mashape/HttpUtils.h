#define BOUNDARY @"---------------------------17237809831461299884346131229"

#import "MashapeResponse.h"

@interface HttpUtils : NSObject

+(void) setRequestHeaders:(ContentType) contentType responseType:(ResponseType)responseType headers:(NSMutableDictionary**)headers;
+(void) setResponse:(ResponseType) responseType data:(NSData*) data outputResponse:(MashapeResponse**) outputResponse;

@end
