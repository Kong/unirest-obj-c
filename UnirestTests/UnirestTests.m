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
    
    NSAssert(200 == response.code, @"Invalid code");
    NSAssert(1 == [args count], @"Invalid arguments size");
    NSAssert([@"Mark" isEqualToString:[args valueForKey:@"name"]], @"Invalid argument value");
}

- (void)testPost
{
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"Mark", @"name", @"thefosk", @"nick", nil];
    
    UNIHTTPJsonResponse* response = [[UNIRest post:^(UNIMultipartRequest * request) {
        [request setUrl:@"http://httpbin.org/post"];
        [request setParameters:parameters];
    }] asJson];
    
    NSDictionary* args = [response.body.object valueForKey:@"form"];
    
    NSAssert(200 == response.code, @"Invalid code");
    NSAssert(2 == [args count], @"Invalid arguments size");
    NSAssert([@"Mark" isEqualToString:[args valueForKey:@"name"]], @"Invalid argument value");
    NSAssert([@"thefosk" isEqualToString:[args valueForKey:@"nick"]], @"Invalid argument value");
}

- (void)testDeleteNoBody
{
    UNIHTTPJsonResponse* response = [[UNIRest delete:^(UNIMultipartRequest * request) {
     [request setUrl:@"http://httpbin.org/delete"];
    }] asJson];
    
    NSDictionary* args = [response.body.object valueForKey:@"form"];
    
    NSAssert(200 == response.code, @"Invalid code");
    NSAssert(0 == [args count], @"Invalid arguments size");
}

- (void)testDelete
{
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"Mark", @"name", nil];
    
    UNIHTTPJsonResponse* response = [[UNIRest delete:^(UNIMultipartRequest * request) {
        [request setUrl:@"http://httpbin.org/delete"];
        [request setParameters:parameters];
    }] asJson];
    
    NSAssert(200 == response.code, @"Invalid code");
    NSAssert([@"name=Mark" isEqualToString:[response.body.object valueForKey:@"data"]], @"invalid argument value");
}

@end
