#import "HeaderAuthentication.h"

@interface MashapeAuthentication : HeaderAuthentication

- (Authentication*) initWithMashapeKeys: (NSString*)publicKey privateKey: (NSString*)privateKey;

@end
