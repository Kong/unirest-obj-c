/*
 * Mashape Objective-C Client library.
 *
 * Copyright (C) 2011 Mashape, Inc.
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

#import "HttpClient.h"
#import "TokenUtil.h"
#import "../Parser/ParserFactory.h"
#import "../Exceptions/MashapeClientException.h"

NSString * const TOKEN_URL = @"https://api.mashape.com/requestToken?devkey={devkey}";

@implementation TokenUtil

+ (NSString*) getToken:(NSString*)developerKey {
	
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject: developerKey forKey:@"devkey"];
	
	NSString * response = [HttpClient doPost:TOKEN_URL parameters:params];
	SBJsonParser * parser = [ParserFactory parser];
	id jsonObject = [parser objectWithString:response];
	
	NSMutableArray * errors = [jsonObject valueForKey:@"errors"];
	
	if ([errors count] > 0) {
		NSMutableDictionary * error = [errors objectAtIndex:0];
		NSString * code = [error valueForKey:@"code"];
		NSString * message = [error valueForKey:@"message"];
	    [MashapeClientException raiseWithName:code reason:message];
	}
	
	return [jsonObject valueForKey:@"token"];
	
}

@end
