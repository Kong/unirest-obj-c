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

#import "UnirestTests.h"
#import "UNIRest.h"

@implementation UnirestTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testGet
{
    UNIHTTPJsonResponse* response = [[UNIRest get:^(UNISimpleRequest * request) {
        [request setUrl:@"http://httpbin.org/get?name=Mark"];
    }] asJson];
    
    NSDictionary* args = [response.body.object valueForKey:@"args"];
    
    NSAssert(200 == response.code, @"Invalid code %d", response.code);
    NSAssert(1 == [args count], @"Invalid arguments size");
    NSAssert([@"Mark" isEqualToString:[args valueForKey:@"name"]], @"Invalid argument value");
}

- (void)testGetWithParameters
{
    NSDictionary* parameters = @{@"nick" : @"thefosk"};
    UNIHTTPJsonResponse* response = [[UNIRest get:^(UNISimpleRequest * request) {
        [request setUrl:@"http://httpbin.org/get"];
        [request setParameters:parameters];
    }] asJson];
    
    NSDictionary* args = [response.body.object valueForKey:@"args"];
    
    NSAssert(200 == response.code, @"Invalid code %d", response.code);
    NSAssert(1 == [args count], @"Invalid arguments size");
    NSAssert([@"thefosk" isEqualToString:[args valueForKey:@"nick"]], @"Invalid argument value");
}

- (void)testGetWithParametersMix
{
    NSDictionary* parameters = @{@"nick" : @"thefosk"};
    UNIHTTPJsonResponse* response = [[UNIRest get:^(UNISimpleRequest * request) {
        [request setUrl:@"http://httpbin.org/get?name=Mark"];
        [request setParameters:parameters];
    }] asJson];
    
    NSDictionary* args = [response.body.object valueForKey:@"args"];
    
    NSAssert(200 == response.code, @"Invalid code %d", response.code);
    NSAssert(2 == [args count], @"Invalid arguments size");
    NSAssert([@"Mark" isEqualToString:[args valueForKey:@"name"]], @"Invalid argument value");
    NSAssert([@"thefosk" isEqualToString:[args valueForKey:@"nick"]], @"Invalid argument value");
}

- (void)testPost
{
    NSDictionary* parameters = @{@"name" : @"Mark", @"nick" : @"thefosk"};
    
    UNIHTTPJsonResponse* response = [[UNIRest post:^(UNISimpleRequest * request) {
        [request setUrl:@"http://httpbin.org/post"];
        [request setParameters:parameters];
    }] asJson];
    
    NSDictionary* args = [response.body.object valueForKey:@"form"];
    
    NSAssert(200 == response.code, @"Invalid code %d", response.code);
    NSAssert(2 == [args count], @"Invalid arguments size");
    NSAssert([@"Mark" isEqualToString:[args valueForKey:@"name"]], @"Invalid argument value");
    NSAssert([@"thefosk" isEqualToString:[args valueForKey:@"nick"]], @"Invalid argument value");
}

- (void)testPostEntity
{
    NSData* data = [@"helloworld" dataUsingEncoding:NSUTF8StringEncoding];
    UNIHTTPJsonResponse* response = [[UNIRest postEntity:^(UNIBodyRequest *request) {
        [request setUrl:@"http://httpbin.org/post"];
        [request setBody:data];
    }] asJson];
    
    NSAssert(200 == response.code, @"Invalid code %d", response.code);
    NSAssert([@"helloworld" isEqualToString:[response.body.object valueForKey:@"data"]], @"invalid argument value");
}

- (void)testPatch
{
    NSDictionary* parameters = @{@"name" : @"Mark", @"nick" : @"thefosk"};
    
    UNIHTTPJsonResponse* response = [[UNIRest patch:^(UNISimpleRequest * request) {
        [request setUrl:@"http://httpbin.org/patch"];
        [request setParameters:parameters];
    }] asJson];
    
    NSDictionary* args = [response.body.object valueForKey:@"form"];
    
    NSAssert(200 == response.code, @"Invalid code %d", response.code);
    NSAssert(2 == [args count], @"Invalid arguments size");
    NSAssert([@"Mark" isEqualToString:[args valueForKey:@"name"]], @"Invalid argument value");
    NSAssert([@"thefosk" isEqualToString:[args valueForKey:@"nick"]], @"Invalid argument value");
}

- (void)testPatchEntity
{
    NSData* data = [@"helloworld" dataUsingEncoding:NSUTF8StringEncoding];
    UNIHTTPJsonResponse* response = [[UNIRest patchEntity:^(UNIBodyRequest *request) {
        [request setUrl:@"http://httpbin.org/patch"];
        [request setBody:data];
    }] asJson];
    
    NSAssert(200 == response.code, @"Invalid code %d", response.code);
    NSAssert([@"helloworld" isEqualToString:[response.body.object valueForKey:@"data"]], @"invalid argument value");
}

- (void)testPut
{
    NSDictionary* parameters = @{@"name" : @"Mark", @"nick" : @"thefosk"};
    
    UNIHTTPJsonResponse* response = [[UNIRest put:^(UNISimpleRequest * request) {
        [request setUrl:@"http://httpbin.org/put"];
        [request setParameters:parameters];
    }] asJson];
    
    NSDictionary* args = [response.body.object valueForKey:@"form"];
    
    NSAssert(200 == response.code, @"Invalid code %d", response.code);
    NSAssert(2 == [args count], @"Invalid arguments size");
    NSAssert([@"Mark" isEqualToString:[args valueForKey:@"name"]], @"Invalid argument value");
    NSAssert([@"thefosk" isEqualToString:[args valueForKey:@"nick"]], @"Invalid argument value");
}

- (void)testPutEntity
{
    NSData* data = [@"helloworld" dataUsingEncoding:NSUTF8StringEncoding];
    UNIHTTPJsonResponse* response = [[UNIRest putEntity:^(UNIBodyRequest *request) {
        [request setUrl:@"http://httpbin.org/put"];
        [request setBody:data];
    }] asJson];
    
    NSAssert(200 == response.code, @"Invalid code %d", response.code);
    NSAssert([@"helloworld" isEqualToString:[response.body.object valueForKey:@"data"]], @"invalid argument value");
}

- (void)testDeleteEntity
{
    NSData* data = [@"helloworld" dataUsingEncoding:NSUTF8StringEncoding];
    UNIHTTPJsonResponse* response = [[UNIRest deleteEntity:^(UNIBodyRequest *request) {
        [request setUrl:@"http://httpbin.org/delete"];
        [request setBody:data];
    }] asJson];
    
    NSAssert(200 == response.code, @"Invalid code %d", response.code);
    NSAssert([@"helloworld" isEqualToString:[response.body.object valueForKey:@"data"]], @"invalid argument value");
}

- (void)testDeleteNoBody
{
    UNIHTTPJsonResponse* response = [[UNIRest delete:^(UNISimpleRequest * request) {
     [request setUrl:@"http://httpbin.org/delete"];
    }] asJson];
    
    NSDictionary* args = [response.body.object valueForKey:@"form"];
    
    NSAssert(200 == response.code, @"Invalid code %d", response.code);
    NSAssert(0 == [args count], @"Invalid arguments size");
}

- (void)testDelete
{
    NSDictionary* parameters = @{@"name" : @"Mark"};
    
    UNIHTTPJsonResponse* response = [[UNIRest delete:^(UNISimpleRequest * request) {
        [request setUrl:@"http://httpbin.org/delete"];
        [request setParameters:parameters];
    }] asJson];
    
    NSAssert(200 == response.code, @"Invalid code %d", response.code);
    NSAssert([@"name=Mark" isEqualToString:[response.body.object valueForKey:@"data"]], @"invalid argument value");
}

- (void)testError
{
    NSError* error = nil;
    
    UNIHTTPJsonResponse* response = [[UNIRest get:^(UNISimpleRequest * request) {
        [request setUrl:@"http://gzippedhttpbin.org/gzip"];
    }] asJson:&error];
    
    NSAssert(error != nil, @"Expecting an error");
    NSAssert(response == nil, @"Expecting null response");
}

- (void)testGzip
{
    NSError* error = nil;
    
    UNIHTTPJsonResponse* response = [[UNIRest get:^(UNISimpleRequest * request) {
        [request setUrl:@"http://httpbin.org/gzip"];
    }] asJson:&error];
    
    NSAssert(200 == response.code, @"Invalid code %d", response.code);
    
    NSInteger gzipped = [[response.body.object valueForKey:@"gzipped"] integerValue];
    NSAssert(gzipped == 1, @"Expecting gzipped=true");
}

- (void)testAsyncError
{
    __block BOOL hasCalledBack = NO;
    
    [[UNIRest get:^(UNISimpleRequest * request) {
        [request setUrl:@"http://gzipeedhttpbin.org/get?name=Mark"];
    }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
        NSAssert(response == nil, @"Response should be nil");
        NSAssert(error != nil, @"Error should be not nil");
        hasCalledBack = YES;
    }];

    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:5];
    while (hasCalledBack == NO && [loopUntil timeIntervalSinceNow] > 0) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:loopUntil];
    }
    
    if (!hasCalledBack) {
        STFail(@"I know this will fail, thanks");
    }
    
}

- (void)testAsync
{

    __block BOOL hasCalledBack = NO;
    
    [[UNIRest get:^(UNISimpleRequest * request) {
        [request setUrl:@"http://httpbin.org/get?name=Mark"];
    }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
        NSAssert(response != nil, @"Response should be not nil");
        NSAssert(error == nil, @"Error should be nil");
        
        NSAssert(200 == response.code, @"Invalid code %d", response.code);
        hasCalledBack = YES;
    }];

    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:5];
    while (hasCalledBack == NO && [loopUntil timeIntervalSinceNow] > 0) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:loopUntil];
    }
    
    if (!hasCalledBack) {
        STFail(@"I know this will fail, thanks");
    }
}

- (void)testCancelAsync
{
    __block BOOL hasCalledBack = NO;
    
    UNIUrlConnection* connection = [[UNIRest get:^(UNISimpleRequest * request) {
        [request setUrl:@"http://httpbin.org/get?name=Mark"];
    }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
        NSAssert(response != nil, @"Response should be not nil");
        NSAssert(error == nil, @"Error should be nil");
        
        NSAssert(200 == response.code, @"Invalid code %d", response.code);
        hasCalledBack = YES;
    }];
    
    [connection cancel];
    
    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:5];
    while (hasCalledBack == NO && [loopUntil timeIntervalSinceNow] > 0) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:loopUntil];
    }
    
    if (hasCalledBack) {
        STFail(@"I know this will fail, thanks");
    }
}

- (void)testBasicAuth
{
    UNIHTTPJsonResponse* response = [[UNIRest get:^(UNISimpleRequest * request) {
        [request setUrl:@"http://httpbin.org/get"];
        [request setUsername:@"user"];
        [request setPassword:@"password"];
    }] asJson];
    
    NSAssert(200 == response.code, @"Invalid code %d", response.code);
    
    NSDictionary* headers = [response.body.object valueForKey:@"headers"];
    
    NSAssert([@"Basic dXNlcjpwYXNzd29yZA==" isEqualToString:[headers valueForKey:@"Authorization"]], @"Invalid header value %@", [headers valueForKey:@"Authorization"]);
}

- (void)testDefaultHeaders
{
    [UNIRest defaultHeader:@"Hello" value:@"custom"];
    
    UNIHTTPJsonResponse* response = [[UNIRest get:^(UNISimpleRequest * request) {
        [request setUrl:@"http://httpbin.org/get"];
    }] asJson];
    
    NSAssert(200 == response.code, @"Invalid code %d", response.code);
    NSDictionary* headers = [response.body.object valueForKey:@"headers"];
    NSAssert([@"custom" isEqualToString:[headers valueForKey:@"Hello"]], @"Invalid header value %@", [headers valueForKey:@"Hello"]);
    
    response = [[UNIRest get:^(UNISimpleRequest * request) {
        [request setUrl:@"http://httpbin.org/get"];
    }] asJson];
    headers = [response.body.object valueForKey:@"headers"];
    NSAssert([@"custom" isEqualToString:[headers valueForKey:@"Hello"]], @"Invalid header value %@", [headers valueForKey:@"Hello"]);
    
    [UNIRest clearDefaultHeaders];
    response = [[UNIRest get:^(UNISimpleRequest * request) {
        [request setUrl:@"http://httpbin.org/get"];
    }] asJson];
    headers = [response.body.object valueForKey:@"headers"];
    NSAssert([headers valueForKey:@"Hello"] == nil, @"Invalid header value %@", [headers valueForKey:@"Hello"]);
}

- (void)testTimeout
{
    [UNIRest timeout:1];
    
    NSError* error = nil;
    
    UNIHTTPJsonResponse* response = [[UNIRest get:^(UNISimpleRequest * request) {
        [request setUrl:@"http://httpbin.org/delay/3"];
    }] asJson:&error];
    
    NSAssert(error != nil, @"Error should be not nil");
    NSAssert(response == nil, @"Response should be nil");
    
    [UNIRest timeout:5];
    error = nil;
    response = [[UNIRest get:^(UNISimpleRequest * request) {
        [request setUrl:@"http://httpbin.org/delay/2"];
    }] asJson:&error];
    
    NSAssert(response != nil, @"Response should be not nil");
    NSAssert(error == nil, @"Error should be nil");
    
    NSAssert(200 == response.code, @"Invalid code %d", response.code);
}

@end
