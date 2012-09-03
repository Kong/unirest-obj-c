#import "HeaderAuthentication.h"

@implementation HeaderAuthentication

- (Authentication*) initWithKey: (NSString*)headerName value: (NSString*)headerValue {
    [super init];
    [headers setObject:headerValue forKey:headerName];
    return self;
}

@end
