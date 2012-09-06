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

#import "MashapeResponse.h"
#import "MashapeDelegate.h"

typedef enum HttpMethod
{
	GET,
	POST,
	PUT,
	DELETE,
    PATCH
} HttpMethod;

typedef enum ContentType
{
	C_FORM,
	C_JSON,
	C_BINARY
} ContentType;

typedef enum ResponseType
{
	R_JSON,
	R_BINARY,
    R_STRING
} ResponseType;

@interface HttpClient : NSObject

+(MashapeResponse*) doRequest:(HttpMethod)httpMethod url:(NSString*)url parameters:(NSMutableDictionary*) parameters contentType:(ContentType)contentType responseType:(ResponseType) responseType authenticationHandlers:(NSArray*) authenticationHandlers callback:(id<MashapeDelegate>) callback;

@end
