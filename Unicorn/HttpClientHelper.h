#import "HttpResponse/HttpResponse.h"
#import "HttpRequest.h"
#import "HttpRequestWithBody.h"

#define BOUNDARY @"---------------------------17237809831461299884346131229"

@interface HttpClientHelper : NSObject

+(HttpResponse*) request:(HttpRequest*) request;

@end
