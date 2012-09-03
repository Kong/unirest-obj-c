#import "MashapeAuthentication.h"
#import "Utils/Base64.h"
#import <CommonCrypto/CommonHMAC.h>

@interface MashapeAuthentication()
// Private methods
+ (NSString*) hmacSha1:(NSString*) value key:(NSString*) key;
@end

@implementation MashapeAuthentication

- (Authentication*) initWithMashapeKeys: (NSString*)publicKey privateKey: (NSString*)privateKey {
    [super init];
    
	NSString* hash = [MashapeAuthentication hmacSha1:publicKey key:privateKey];
	NSString* headerValue = [NSString stringWithFormat:@"%@:%@", publicKey, hash];
	NSString* encodedHeaderValue = [Base64 encode:[headerValue dataUsingEncoding:NSUTF8StringEncoding]];
	
    [headers setObject:encodedHeaderValue forKey:@"X-Mashape-Authorization"];
   
    return self;
}

+ (NSString*) hmacSha1:(NSString*) value key:(NSString*) key {
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [value cStringUsingEncoding:NSASCIIStringEncoding];
    
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
	
	CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    
    NSString* hash = [[HMAC description] stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    return hash;
}

@end
