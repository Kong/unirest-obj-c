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

#import "HttpRequestWithBody.h"

@implementation HttpRequestWithBody

@synthesize body = _body;
@synthesize parameters = _parameters;
@synthesize parametersOrder = _parametersOrder;


-(HttpRequestWithBody*) initWithMultipartRequest:(HttpMethod) httpMethod url:(NSString*) url headers:(NSDictionary*) headers parameters:(NSDictionary*) parameters {
    self = [self initWithMultipartRequest:httpMethod url:url headers:headers parameters:parameters order:nil];
    return self;
}

-(HttpRequestWithBody*) initWithMultipartRequest:(HttpMethod) httpMethod url:(NSString*) url headers:(NSDictionary*) headers parameters:(NSDictionary*) parameters order:(NSArray *)parametersOrder{
    self = [super initWithSimpleRequest:httpMethod url:url headers:headers];
    if (parameters == nil) {
        parameters = [[NSDictionary alloc] init];
    }
    [self setParameters:[parameters mutableCopy]];
    if (parametersOrder != nil) {
        [self setParametersOrder:[parametersOrder mutableCopy]];
    }
    return self;
}

-(HttpRequestWithBody*) initWithBodyRequest:(HttpMethod) httpMethod url:(NSString*) url headers:(NSDictionary*) headers body:(NSData*) body {
    self = [super initWithSimpleRequest:httpMethod url:url headers:headers];
    [self setBody:body];
    return self;
}

@end
