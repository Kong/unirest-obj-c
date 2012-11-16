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

#import "OAuthAuthentication.h"

@implementation OAuthAuthentication

- (Authentication*) initWithCredentials: (NSString*)consumerKey consumerSecret: (NSString*)consumerSecret callbackUrl:(NSString*) callbackUrl {
    self = [super init];
    
    [parameters setObject:consumerKey forKey:CONSUMER_KEY];
    [parameters setObject:consumerSecret forKey:CONSUMER_SECRET];
    [parameters setObject:callbackUrl forKey:CALLBACK_URL];
    
    return self;
}

@end
