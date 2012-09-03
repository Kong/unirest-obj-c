#import "Authentication.h"

@interface HeaderAuthentication : Authentication

- (Authentication*) initWithKey: (NSString*)headerName value: (NSString*)headerValue;

@end
