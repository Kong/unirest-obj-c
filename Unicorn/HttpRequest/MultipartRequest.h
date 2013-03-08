#import "SimpleRequest.h"

@interface MultipartRequest : SimpleRequest {
    
    NSDictionary* parameters;
    
}

@property(readwrite) NSDictionary* parameters;

@end
