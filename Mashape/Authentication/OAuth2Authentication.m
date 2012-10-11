//
//  OAuth2Authentication.m
//  oauth
//
//  Created by Marco Palladino on 10/4/12.
//  Copyright (c) 2012 Marco Palladino. All rights reserved.
//

#import "OAuth2Authentication.h"

@implementation OAuth2Authentication

- (Authentication*) initWithCredentials: (NSString*)consumerKey consumerSecret: (NSString*)consumerSecret callbackUrl:(NSString*) callbackUrl {
    
    return [super initWithCredentials:consumerKey consumerSecret:consumerSecret callbackUrl:callbackUrl];
    
}

@end
