@interface BaseRequest : NSObject {
    
    NSString* url;
    NSDictionary* headers;
    
}

@property(readwrite) NSString* url;
@property(readwrite) NSDictionary* headers;

@end
