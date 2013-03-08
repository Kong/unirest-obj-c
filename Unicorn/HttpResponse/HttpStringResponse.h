#import "HttpResponse.h"

@interface HttpStringResponse : HttpResponse {
    
    NSString* _body;
    
}

@property(readwrite) NSString* body;

-(HttpStringResponse*) initWithSimpleResponse:(HttpResponse*) httpResponse;

@end
