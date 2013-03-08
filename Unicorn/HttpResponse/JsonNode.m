#import "JsonNode.h"

@implementation JsonNode

@synthesize array = _array;
@synthesize object = _object;

-(BOOL) isArray {
    return _array != nil;
}

-(NSDictionary*) JSONObject {
    return [self object];
}

-(NSArray*) JSONArray {
    return [self array];
}

@end
