//
//  OAuth10aAuthentication.h
//  oauth
//
//  Created by Marco Palladino on 10/4/12.
//  Copyright (c) 2012 Marco Palladino. All rights reserved.
//

#import "OAuthAuthentication.h"

@interface OAuth10aAuthentication : OAuthAuthentication

- (Authentication*) initWithCredentials: (NSString*)consumerKey consumerSecret: (NSString*)consumerSecret callbackUrl:(NSString*) callbackUrl;

@end
