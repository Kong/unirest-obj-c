//
//  OAuth10aAuthentication.m
//  oauth
//
//  Created by Marco Palladino on 10/4/12.
//  Copyright (c) 2012 Marco Palladino. All rights reserved.
//

#import "OAuth10aAuthentication.h"

@implementation OAuth10aAuthentication

- (Authentication*) initWithCredentials: (NSString*)consumerKey consumerSecret: (NSString*)consumerSecret callbackUrl:(NSString*) callbackUrl {
    
    return [super initWithCredentials:consumerKey consumerSecret:consumerSecret callbackUrl:callbackUrl];
    
}

@end
