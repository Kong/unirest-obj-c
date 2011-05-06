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
#import "UrlUtils.h"
#import "../Exceptions/MashapeClientException.h"
#import "../Parser/ParserFactory.h"

NSString * const VERSION = @"V02";
NSString * const LANGUAGE = @"OBJECTIVEC";

@interface HttpClient()
	// Private methods
    + (NSString*) doHttpRequest:(NSString*)httpMethod url:(NSString*)urlToCall parameters:(NSMutableDictionary*) params;
    + (NSString*) prepareParameters:(NSMutableString*)uri params:(NSMutableDictionary*) params;
	+ (NSString*) doGet:(NSString*)url parameters:(NSMutableDictionary*) params;
@end


@implementation HttpClient

+ (NSMutableDictionary*) makeRequest: (HttpMethod)httpMethod url:(NSString*)urlToCall token:(NSString*)tokenCode parameters:(NSMutableDictionary*) params {	
	if(params == nil) {
		params = [NSMutableDictionary dictionaryWithCapacity:2];
	} else {
		// Remove null parameters
		for (NSString* key in params) {
			if ([params objectForKey:key] == nil) {
				[params removeObjectForKey:key];
			}
		}
	}
	
	[params setObject:tokenCode forKey:@"_token"];
	[params setObject:VERSION forKey:@"_version"];
	[params setObject:LANGUAGE forKey:@"_language"];
	
	urlToCall = [UrlUtils addClientParameters:urlToCall];
	
	NSString * response = nil; 

	switch (httpMethod) {
		case GET:
			response = [self doGet:urlToCall parameters:params];
			break;
		case POST:
			response = [self doPost:urlToCall parameters:params];
			break;
		case PUT:
			response = [self doHttpRequest:@"PUT" url:urlToCall parameters:params];
			break;
		case DELETE:
			response = [self doHttpRequest:@"DELETE" url:urlToCall parameters:params];
			break;
		default:
			[MashapeClientException raiseWithName:EXCEPTION_NOTSUPPORTED_HTTPMETHOD_CODE reason:EXCEPTION_NOTSUPPORTED_HTTPMETHOD];
	}
	
	if ([response length] == 0) {
		[MashapeClientException raiseWithName:EXCEPTION_SYSTEM_ERROR_CODE reason:EXCEPTION_EMPTY_REQUEST];
	}
	
	SBJsonParser * parser = [ParserFactory parser];
	id jsonObject = [parser objectWithString:response];
	
	if (jsonObject == nil) {
		[MashapeClientException raiseWithName:EXCEPTION_SYSTEM_ERROR_CODE reason:EXCEPTION_INVALID_REQUEST];
	}
		
	return jsonObject;
}

+ (NSString*) doPost:(NSString*)url parameters:(NSMutableDictionary*) params {
    return [self doHttpRequest:@"POST" url:url parameters:params];
}

+ (NSString*) doGet:(NSString*)url parameters:(NSMutableDictionary*) params {
	
	NSString* uri = [self prepareParameters:[NSMutableString stringWithString:url] params:params];
	
	NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:uri]];
	NSURLResponse * response = nil;
	NSError * error = nil;
	NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
	
	NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

	return result;
}

+ (NSString*) doHttpRequest:(NSString*)httpMethod url:(NSString*)urlToCall parameters:(NSMutableDictionary*) params {
	
	NSString* uri = [self prepareParameters:[NSMutableString stringWithString:urlToCall] params:params];
	
	NSArray* uriParts = [uri componentsSeparatedByString:@"?"];
	NSString * queryString = @"";
	if ([uriParts count] > 1) {
		queryString = [uriParts objectAtIndex:1];
	}
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[uriParts objectAtIndex:0]]];
	[request setHTTPMethod:httpMethod];
	[request setHTTPBody:[queryString dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLResponse * response = nil;
	NSError * error = nil;
	NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	
	return result;
}

+ (NSString*) prepareParameters:(NSMutableString*) uri params:(NSMutableDictionary*) params {

	uri = [NSMutableString stringWithString:[UrlUtils getCleanUrl:uri parameters:params]];

	for (NSString* key in params) {
		
		NSString * value = (NSString*)[params objectForKey:key];
		NSString* placeHolder = [[NSString alloc] initWithFormat:@"{%@}", key];
		NSString* encodedValue = (NSString *)CFURLCreateStringByAddingPercentEscapes(
							    NULL,
							    (CFStringRef)value,
							    NULL,
							    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
							    kCFStringEncodingUTF8);
		[uri replaceOccurrencesOfString:placeHolder withString:encodedValue options:NSCaseInsensitiveSearch range:NSMakeRange(0, [uri length])];
	}
	
	return uri;
}

@end
