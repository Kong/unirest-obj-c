#import "HeaderAuthentication.h"

@interface BasicAuthentication : HeaderAuthentication

- (Authentication*) initWithUsernameAndPassword: (NSString*)username password: (NSString*)password;

@end
