/*
 * Mashape Objective-C Client library.
 *
 * Copyright (C) 2012 Mashape, Inc.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 *
 * The author of this software is Mashape, Inc.
 * For any question or feedback please contact us at: support@mashape.com
 *
 */

#import "MashapeAuthentication.h"
#import "Utils/Base64.h"
#import <CommonCrypto/CommonHMAC.h>

@interface MashapeAuthentication()
// Private methods
+ (NSString*) hmacSha1:(NSString*) value key:(NSString*) key;
@end

@implementation MashapeAuthentication

- (Authentication*) initWithMashapeKeys: (NSString*)publicKey privateKey: (NSString*)privateKey {
    self = [super init];
    
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
