/*
The MIT License

Copyright (c) 2013 Mashape (http://mashape.com)

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 
*/

#import <Foundation/Foundation.h>
#import "UNIHTTPRequest.h"
#import "UNIHTTPRequestWithBody.h"
#import "UNISimpleRequest.h"
#import "UNIBodyRequest.h"
#import "UNIHTTPBinaryResponse.h"
#import "UNIHTTPJsonResponse.h"
#import "UNIHTTPStringResponse.h"

typedef void (^UNISimpleRequestBlock)(UNISimpleRequest* simpleRequest);
typedef void (^UNIBodyRequestBlock)(UNIBodyRequest* unibodyRequest);

@interface UNIRest : NSObject

+(void) timeout:(int) seconds;
+(int) timeout;

+(void) defaultHeader:(NSString*) name value:(NSString*) value;
+(void) clearDefaultHeaders;
+(NSMutableDictionary*) defaultHeaders;

+(UNIHTTPRequest*) get:(UNISimpleRequestBlock) config;

+(UNIHTTPRequestWithBody*) post:(UNISimpleRequestBlock) config;
+(UNIHTTPRequestWithBody*) postEntity:(UNIBodyRequestBlock) config;

+(UNIHTTPRequestWithBody*) put:(UNISimpleRequestBlock) config;
+(UNIHTTPRequestWithBody*) putEntity:(UNIBodyRequestBlock) config;

+(UNIHTTPRequestWithBody*) patch:(UNISimpleRequestBlock) config;
+(UNIHTTPRequestWithBody*) patchEntity:(UNIBodyRequestBlock) config;

+(UNIHTTPRequestWithBody*) delete:(UNISimpleRequestBlock) config;
+(UNIHTTPRequestWithBody*) deleteEntity:(UNIBodyRequestBlock) config;

@end
