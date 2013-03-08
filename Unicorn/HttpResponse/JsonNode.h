@interface JsonNode : NSObject {
    NSDictionary* _object;
    NSArray* _array;
    
}

-(BOOL) isArray;

@property(readwrite) NSDictionary* object;
@property(readwrite) NSArray* array;

-(NSDictionary*) JSONObject;

-(NSArray*) JSONArray;

@end
