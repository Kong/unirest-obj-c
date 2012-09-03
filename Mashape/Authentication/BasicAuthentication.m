#import "BasicAuthentication.h"
#import "Utils/Base64.h"

@implementation BasicAuthentication

- (Authentication*) initWithUsernameAndPassword: (NSString*)username password: (NSString*)password {
    [super init];

	NSString *headerValue = [NSString stringWithFormat:@"%@:%@", username, password];
    NSString *encodedHeaderValue = [Base64 encode:[headerValue dataUsingEncoding:NSUTF8StringEncoding]];

    [headers setObject:[NSString stringWithFormat:@"Basic %@", encodedHeaderValue] forKey:@"Authorization"];
    return self;
}

@end
