#import "HttpResponse.h"
#import "JsonNode.h"

@interface HttpJsonResponse : HttpResponse {
    
    JsonNode* _body;
    
}

@property(readwrite) JsonNode* body;

-(HttpJsonResponse*) initWithSimpleResponse:(HttpResponse*) httpResponse;

@end
