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

#import "Unirest.h"

@interface Unirest()
+ (id) getConfig:instance config:(void (^)(id)) config;
@end

@implementation Unirest

+ (id) getConfig:instance config:(void (^)(id)) config {
    if (config) {
        config(instance);
    }
    return instance;
}

+(HttpRequest*) get:(void (^)(SimpleRequest*)) config {
    SimpleRequest* _config = [self getConfig:[[SimpleRequest alloc] init] config:config];
    return [[HttpRequest alloc] initWithSimpleRequest:GET url:[_config url] headers:[_config headers]];
}

+(HttpRequestWithBody*) post:(void (^)(MultipartRequest*)) config {
    MultipartRequest* _config = [self getConfig:[[MultipartRequest alloc] init] config:config];
    
    return [[HttpRequestWithBody alloc] initWithMultipartRequest:POST url:[_config url] headers:[_config headers] parameters:[_config parameters]];
}

+(HttpRequestWithBody*) postEntity:(void (^)(BodyRequest*)) config {
    BodyRequest* _config = [self getConfig:[[BodyRequest alloc] init] config:config];
    
    return [[HttpRequestWithBody alloc] initWithBodyRequest:POST url:[_config url] headers:[_config headers] body:[_config body]];
}

+(HttpRequestWithBody*) put:(void (^)(MultipartRequest*)) config {
    MultipartRequest* _config = [self getConfig:[[MultipartRequest alloc] init] config:config];
    
    return [[HttpRequestWithBody alloc] initWithMultipartRequest:PUT url:[_config url] headers:[_config headers] parameters:[_config parameters]];
}

+(HttpRequestWithBody*) putEntity:(void (^)(BodyRequest*)) config {
    BodyRequest* _config = [self getConfig:[[BodyRequest alloc] init] config:config];
    
    return [[HttpRequestWithBody alloc] initWithBodyRequest:PUT url:[_config url] headers:[_config headers] body:[_config body]];
}

+(HttpRequestWithBody*) patch:(void (^)(MultipartRequest*)) config {
    MultipartRequest* _config = [self getConfig:[[MultipartRequest alloc] init] config:config];
    
    return [[HttpRequestWithBody alloc] initWithMultipartRequest:PATCH url:[_config url] headers:[_config headers] parameters:[_config parameters]];
}

+(HttpRequestWithBody*) patchEntity:(void (^)(BodyRequest*)) config {
    BodyRequest* _config = [self getConfig:[[BodyRequest alloc] init] config:config];
    
    return [[HttpRequestWithBody alloc] initWithBodyRequest:PATCH url:[_config url] headers:[_config headers] body:[_config body]];
}

+(HttpRequest*) delete:(void (^)(SimpleRequest*)) config {
    SimpleRequest* _config = [self getConfig:[[SimpleRequest alloc] init] config:config];
    return [[HttpRequest alloc] initWithSimpleRequest:DELETE url:[_config url] headers:[_config headers]];   
}

@end
