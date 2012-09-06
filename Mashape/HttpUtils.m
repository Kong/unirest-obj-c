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

#import "HttpClient.h"
#import "HttpUtils.h"
#import "Response/MashapeBinaryResponse.h"
#import "Response/MashapeStringResponse.h"
#import "Response/MashapeJsonObjectResponse.h"
#import "Response/MashapeJsonArrayResponse.h"
#import "JSON/SBJson.h"

@implementation HttpUtils

+(void) setRequestHeaders:(ContentType) contentType responseType:(ResponseType)responseType headers:(NSMutableDictionary**)headers {
    [*headers setObject:@"mashape-objectivec/2.0" forKey:@"User-Agent"];
    
    NSString* contentTypeHeader = nil;
    
    switch (contentType) {
        case C_JSON:
            contentTypeHeader = @"application/json";
            break;
        case C_FORM:
            contentTypeHeader = @"application/x-www-form-urlencoded";
            break;
        case C_BINARY:
            contentTypeHeader = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BOUNDARY];
            break;
    }
    
    [*headers setObject:contentTypeHeader forKey:@"Content-Type"];
    
     NSString* responseTypeHeader = nil;
    
    switch (responseType) {
        case R_JSON:
            responseTypeHeader = @"application/json";
            break;
        case R_STRING:
            responseTypeHeader = @"text/plain";
            break;
        case R_BINARY:
            break;
    }
    
    if ([responseTypeHeader length] != 0) {
        [*headers setObject:responseTypeHeader forKey:@"Accept"];
    }
    
}

+(MashapeResponse*) getResponse:(ResponseType) responseType httpResponse:(NSHTTPURLResponse*) httpResponse data:(NSData*) data {

    MashapeResponse* response;
    
    id json;
    switch(responseType) {
        case R_JSON:
            json = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] JSONValue];
            if ([json class] == [NSArray class]) {
                response = [[MashapeJsonArrayResponse alloc] initWithResponse:[httpResponse statusCode] headers:[httpResponse allHeaderFields] rawBody:data];
            } else {
                response = [[MashapeJsonObjectResponse alloc] initWithResponse:[httpResponse statusCode] headers:[httpResponse allHeaderFields] rawBody:data];
            }
            [response setBody:json];
            break;
        case R_STRING:
            response = [[MashapeStringResponse alloc] initWithResponse:[httpResponse statusCode] headers:[httpResponse allHeaderFields] rawBody:data];
            [response setBody:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
            break;
        case R_BINARY:
            response = [[MashapeBinaryResponse alloc] initWithResponse:[httpResponse statusCode] headers:[httpResponse allHeaderFields] rawBody:data];
            [response setBody:data];
            break;
    }
    
    return response;
}

@end
