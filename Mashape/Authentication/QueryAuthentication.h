#import "Authentication.h"

@interface QueryAuthentication : Authentication

- (Authentication*) initWithParam: (NSString*)paramName value: (NSString*)paramValue;

@end
