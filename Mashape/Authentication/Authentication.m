#import "Authentication.h"

@interface Authentication ()
    @property (readwrite) NSMutableDictionary* headers;
    @property (readwrite) NSMutableDictionary* parameters;
@end

@implementation Authentication

@synthesize headers;
@synthesize parameters;

- (Authentication*) init {
    [super init];
    self.headers = [[NSMutableDictionary alloc]init];
    self.parameters = [[NSMutableDictionary alloc]init];
    return self;
}

@end
