//
//  urlUtils.m
//  newClient
//
//  Created by Augusto Marietti on 4/5/11.
//  Copyright 2011 Mashape, Inc. All rights reserved.
//

#import "UrlUtils.h"

@implementation UrlUtils


+ (NSString*) addRouteParameter: (NSString*) url parameterName:(NSString*) parameterName {
	NSString * result = [NSString stringWithString:url];
	
	if ([result rangeOfString:@"?"].location == NSNotFound) {
		result = [result stringByAppendingString:@"?"];
	}
	if([result characterAtIndex:[result length] - 1] != '?') {
		result = [result stringByAppendingString:@"&"];	
	}
	result = [result stringByAppendingFormat:@"%@={%@}", parameterName, parameterName];	
	
	return result;
}
+ (NSString*) addClientParameters: (NSString*) url {
	NSString* result = [self addRouteParameter:url parameterName:@"_token"];
	result = [self addRouteParameter:result parameterName:@"_language"];	
	result = [self addRouteParameter:result parameterName:@"_version"];
	return result;
}

+ (NSString*) getCleanUrl: (NSString*) url parameters:(NSMutableDictionary*) parameters {
	if (parameters == NULL) {
		parameters = [NSMutableDictionary dictionary];
	}
	
	NSString * finalUrl = @"";
	
	unsigned int len = [url length];
	unichar buffer[len + 1];
	
	[url getCharacters:buffer];
	for (int i = 0; i < len;++i) {
		char curchar = buffer[i];
		
		if (curchar == '{') {
			int offset = i;

			NSRange result = [url rangeOfString:@"}" options:NSCaseInsensitiveSearch range:NSMakeRange(offset, len - offset)];
			if (result.location != NSNotFound) {
				// It's a placeholder

				// Get the placeholder name without {..}
				NSString* placeHolder = [url substringWithRange:NSMakeRange(i + 1, result.location - i - 1)]; 
				if ([parameters objectForKey:placeHolder] == nil) {

					// If it doesn't exist in the array, remove it
					if ([[url substringWithRange:NSMakeRange(i - 1, 1)] isEqualToString:@"="]) {
						// It's a query string placeholder, remove also its name
						
						unsigned int finalLen = [finalUrl length];
						unichar finalBuffer[finalLen + 1];
						[finalUrl getCharacters:finalBuffer];
						for (int t = finalLen - 1; t >= 0; t--) {
							char backChar = finalBuffer[t];
							if (backChar == '?' || backChar == '&') {
								int length;
								if (backChar == '?') {
									length = t + 1;
								} else {
									length = t;
								}
								finalUrl = [finalUrl substringWithRange:NSMakeRange(0, length)];
								break;
							}
						}
					}

					i = result.location;
					continue;
				}
			}	
		}

		finalUrl = [finalUrl stringByAppendingFormat:@"%C", curchar];
	}
	
	return [finalUrl stringByReplacingOccurrencesOfString:@"?&" withString:@"?"];
}
/*
+ (NSMutableDictionary*) getQueryStringParameters: (NSString*) url {
	NSMutableDictionary *result = [NSMutableDictionary dictionary];

	NSArray* urlParts = [url componentsSeparatedByString:@"?"];
	if ([urlParts count] > 1) {
	
		NSString* queryString = [urlParts objectAtIndex:1];
		
		NSArray* parameters = [queryString componentsSeparatedByString:@"&"];
		
		for (int i = 0; i < [parameters count]; i++) {
			NSString* parameter = [parameters objectAtIndex:i];
		   	NSArray* parameterParts = [parameter componentsSeparatedByString:@"="];
			if ([parameterParts count] > 1) {
				if (![self isPlaceholder:[parameterParts objectAtIndex:1]]) {
					[result setObject:[parameterParts objectAtIndex:1] forKey:[parameterParts objectAtIndex:0]];
				}
			}
		}

		
	}	

	return result;
}
*/
+ (BOOL) isPlaceholder: (NSString*) value {
	if ([[value substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"{"]) {
		if ([[value substringFromIndex:[value length]-1] isEqualToString:@"}"]) {
			return YES;
		}	
	}
	return NO;
}

@end

