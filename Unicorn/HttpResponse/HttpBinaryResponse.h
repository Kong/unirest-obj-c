#import "HttpResponse.h"

@interface HttpBinaryResponse : HttpResponse {
    
    NSData* _body;
    
}

@property(readwrite) NSData* body;

-(HttpBinaryResponse*) initWithSimpleResponse:(HttpResponse*) httpResponse;

@end
