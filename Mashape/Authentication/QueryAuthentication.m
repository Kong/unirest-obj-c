#import "QueryAuthentication.h"

@implementation QueryAuthentication

- (Authentication*) initWithParam: (NSString*)paramName value: (NSString*)paramValue {
    [super init];
    [parameters setObject:paramValue forKey:paramName];
    return self;
}

@end
