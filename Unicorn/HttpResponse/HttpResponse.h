@interface HttpResponse : NSObject {
    
    int _code;
    NSDictionary* _headers;
    NSData* _rawBody;
    
}

@property(readwrite) int code;
@property(readwrite) NSDictionary* headers;
@property(readwrite) NSData* rawBody;

@end
