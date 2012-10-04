//
//  OAuth2Authentication.m
//  oauth
//
//  Created by Marco Palladino on 10/4/12.
//  Copyright (c) 2012 Marco Palladino. All rights reserved.
//

#import "OAuth2Authentication.h"

@implementation OAuth2Authentication

- (Authentication*) initWithCredentials: (NSString*)consumerKey consumerSecret: (NSString*)consumerSecret redirectUrl:(NSString*) redirectUrl {
    
    return [super initWithCredentials:consumerKey consumerSecret:consumerSecret redirectUrl:redirectUrl];
    
}

@end
