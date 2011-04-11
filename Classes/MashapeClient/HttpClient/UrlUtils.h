//
//  urlUtils.h
//  newClient
//
//  Created by Augusto Marietti on 4/5/11.
//  Copyright 2011 Mashape, Inc. All rights reserved.
//

@interface UrlUtils : NSObject {

}

+ (NSString*) addRouteParameter: (NSString*) url parameterName:(NSString*) parameterName;
+ (NSString*) addClientParameters: (NSString*) url;
+ (NSString*) getCleanUrl: (NSString*) url parameters:(NSMutableDictionary*) parameters;
+ (BOOL) isPlaceholder: (NSString*) value;

@end
