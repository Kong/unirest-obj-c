@interface Authentication : NSObject
{
    NSMutableDictionary* headers;
    NSMutableDictionary* parameters;
}

@property (readonly) NSMutableDictionary* headers;
@property (readonly) NSMutableDictionary* parameters;

@end
