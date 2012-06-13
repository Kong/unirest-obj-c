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

#import "UrlUtils.h"

@interface UrlUtils()
// Private methods
+ (void) addRegularQueryStringParameters: (NSString*) url parameters:(NSMutableDictionary**) parameters;
+ (BOOL) isPlaceholder: (NSString*) value;
@end

@implementation UrlUtils

+(void) prepareRequest: (NSString**) url parameters:(NSMutableDictionary**) parameters addRegularQueryStringParameters:(BOOL) addRegularQueryStringParameters {
	
	if (*parameters == nil) {
		*parameters = [NSMutableDictionary dictionary];
	}
	
	for (id key in *parameters) {
		id value = [*parameters objectForKey:key];
		if (value == nil) {
			[*parameters removeObjectForKey:key];
		}
	}
	
	if (addRegularQueryStringParameters) {
		[self addRegularQueryStringParameters:*url parameters:parameters];
	}

	NSString* finalUrl = *url;
    NSString* ref = [[NSString alloc] initWithString:finalUrl];

    NSError* error = nil;
    NSRegularExpression* findPlaceholders = [NSRegularExpression regularExpressionWithPattern:@"\\{([\\w\\.]+)\\}" options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray* matches = [findPlaceholders matchesInString:ref options:0 range:NSMakeRange(0, [ref length])];
					
	for (NSTextCheckingResult* match in matches) {
		NSString* key = [ref substringWithRange:[match rangeAtIndex:1]];
		NSString* value = [*parameters objectForKey:key];
		if (value == nil) {
            NSRegularExpression* replacePlaceholders = [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"&?[\\w]*=?\\{%@\\}", key] options:NSRegularExpressionCaseInsensitive error:&error];
            finalUrl = [replacePlaceholders stringByReplacingMatchesInString:finalUrl options:0 range:NSMakeRange(0, [finalUrl length]) withTemplate:@""];
		} else {
            NSRegularExpression* replacePlaceholdersWithValue = [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"(\\?.+)\\{%@\\}", key] options:NSRegularExpressionCaseInsensitive error:&error];
            finalUrl = [replacePlaceholdersWithValue stringByReplacingMatchesInString:finalUrl options:0 range:NSMakeRange(0, [finalUrl length]) withTemplate:[NSString stringWithFormat:@"$1%@", [self encodeURI:value]]];
            
            NSRegularExpression* replaceURIPlaceholdersWithValue = [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"\\{%@\\}", key] options:NSRegularExpressionCaseInsensitive error:&error];
            finalUrl = [replaceURIPlaceholdersWithValue stringByReplacingMatchesInString:finalUrl options:0 range:NSMakeRange(0, [finalUrl length]) withTemplate:[self encodeURI:value]];
		}
	}

    finalUrl = [[NSRegularExpression regularExpressionWithPattern:@"\\?&" options:NSRegularExpressionCaseInsensitive error:&error] stringByReplacingMatchesInString:finalUrl options:0 range:NSMakeRange(0, [finalUrl length]) withTemplate:@"?"];
    finalUrl = [[NSRegularExpression regularExpressionWithPattern:@"\\?$" options:NSRegularExpressionCaseInsensitive error:&error] stringByReplacingMatchesInString:finalUrl options:0 range:NSMakeRange(0, [finalUrl length]) withTemplate:@""];
    
	*url = finalUrl;
}

+ (NSString*) encodeURI:(NSString*)value {
	NSString* result = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
															   NULL,
															   (__bridge CFStringRef)value,
															   NULL,
															   (CFStringRef)@"!*'();:@&=+$,/?%#[]",
															   kCFStringEncodingUTF8);
	return result;
}

+(void) addRegularQueryStringParameters: (NSString*) url parameters:(NSMutableDictionary**) parameters {
	NSArray* urlParts = [url componentsSeparatedByString:@"?"];
	if ([urlParts count] > 1) {
		
		NSString* queryString = [urlParts objectAtIndex:1];
		
		NSArray* queryStringParameters = [queryString componentsSeparatedByString:@"&"];
		
		for (int i = 0; i < [queryStringParameters count]; i++) {
			NSString* parameter = [queryStringParameters objectAtIndex:i];
		   	NSArray* parameterParts = [parameter componentsSeparatedByString:@"="];
			if ([parameterParts count] > 1) {
				if (![self isPlaceholder:[parameterParts objectAtIndex:1]]) {
					[*parameters setObject:[parameterParts objectAtIndex:1] forKey:[parameterParts objectAtIndex:0]];
				}
			}
		}
	}	
}

+ (BOOL) isPlaceholder: (NSString*) value {
	if ([[value substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"{"]) {
		if ([[value substringFromIndex:[value length]-1] isEqualToString:@"}"]) {
			return YES;
		}	
	}
	return NO;
}

+(void) generateClientHeaders: (NSMutableURLRequest**) request {
    
    [*request addValue:@"mashape-objectivec/1.0" forHTTPHeaderField:@"User-Agent"];
    
}

@end


