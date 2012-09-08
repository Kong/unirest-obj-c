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

#define BOUNDARY @"---------------------------17237809831461299884346131229"

#import "Response/MashapeResponse.h"

@interface HttpUtils : NSObject

+(void) setRequestHeaders:(ContentType) contentType responseType:(ResponseType)responseType headers:(NSMutableDictionary**)headers;
+(MashapeResponse*) getResponse:(ResponseType) responseType httpResponse:(NSHTTPURLResponse*) httpResponse data:(NSData*) data;
+ (NSString*) encodeURI:(NSString*)value;

@end
