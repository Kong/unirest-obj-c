#import "SimpleRequest.h"

@interface BodyRequest : SimpleRequest {
    
    NSData* body;
    
}

@property(readwrite) NSData* body;

@end
