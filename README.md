Unicorn Objective-C
============================================

Unicorn is a set of lightweight HTTP libraries available in PHP, Ruby, Python, Java, Objective-C.

Documentation
-------------------

### Installing
Download the Objective-C Unicorn Library from Github and import the folder into your project to begin utilizing unicorns amazing powers today!

### Creating Request
So you're probably wondering how using Unicorn makes creating requests in Objective-C easier, let's look at a working example:

```objective-c
NSDictionary* headers = [NSDictionary dictionaryWithObjectsAndKeys:@"application/json", @"accept", nil];
NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"value", @"parameter", @"bar", @"foo", nil];

HttpJsonResponse* response = [[Unicorn post:^(MultipartRequest* request) {
  [request setUrl:@"http://httpbin.org/post"];
  [request setHeaders:headers];
  [request setParameters:parameters];
}] asJson];
```
    
Just like in the Unicorn Java library the Objective-C library supports multiple response types given as the last parameter. In the example above we use `asJson` to get a JSON response, likewise there are `asBinary` and `asString` for responses of other nature such as file data and hypermedia responses.

### Asynchronous Requests
For non-blocking requests you will want to make an asychronous request to keep your application going while data is fetched or updated in the background, doing so with Unicorn is extremely easy with barely any code change from the previous example:

```objective-c
NSDictionary* headers = [NSDictionary dictionaryWithObjectsAndKeys:@"application/json", @"accept", nil];
NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"value", @"parameter", @"bar", @"foo", nil];

[[Unicorn post:^(MultipartRequest* request) {
  [request setUrl:@"http://httpbin.org/post"];
  [request setHeaders:headers];
  [request setParameters:parameters];
}] asJsonAsync:^(HttpJsonResponse* response) {
  // This is the asyncronous callback block
  int code = [response code];
  NSDictionary* responseHeaders = [response headers];
  JsonNode* body = [response body];
  NSData* rawBody = [response rawBody];
}];
```
    
### File Uploads
Transferring files through request with Unicorn in Objective-C can be done by creating a `NSURL` object and passing it along as a parameter value with a `MultipartRequest` like so:

```objective-c
NSDictionary* headers = [NSDictionary dictionaryWithObjectsAndKeys:@"application/json", @"accept", nil];
NSURL file = nil;
NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"value", @"parameter", file, @"file", nil];

HttpJsonResponse* response = [[Unicorn post:^(MultipartRequest* request) {
  [request setUrl:@"http://httpbin.org/post"];
  [request setHeaders:headers];
  [request setParameters:parameters];
}] asJson];
```

 
### Custom Entity Body
To send a custom body such as JSON simply serialize your data utilizing the `NSJSONSerialization` with a `BodyRequest` and `[method]Entity` instead of just `[method]` block like so:

```objective-c
NSDictionary* headers = [NSDictionary dictionaryWithObjectsAndKeys:@"application/json", @"accept", nil];
NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"value", @"parameter", @"bar", @"foo", nil];

HttpJsonResponse* response = [[Unicorn postEntity:^(BodyRequest* request) {
  [request setUrl:@"http://httpbin.org/post"];
  [request setHeaders:headers];
  // Converting NSDictionary to JSON:
  [request setBody:[NSJSONSerialization dataWithJSONObject:headers options:0 error:nil]];
}] asJson];
```



### Request Reference
The Objective-C Unicorn library uses configuration blocks of type SimpleRequest, MultipartRequest and BodyRequest to configure the URL, Headers, and Parameters / Body of the request.

```objective-c
+(HttpRequest*) get:(void (^)(SimpleRequest*)) config;

+(HttpRequestWithBody*) post:(void (^)(MultipartRequest*)) config;
+(HttpRequestWithBody*) postEntity:(void (^)(BodyRequest*)) config;

+(HttpRequestWithBody*) put:(void (^)(MultipartRequest*)) config;
+(HttpRequestWithBody*) putEntity:(void (^)(BodyRequest*)) config;

+(HttpRequestWithBody*) patch:(void (^)(MultipartRequest*)) config;
+(HttpRequestWithBody*) patchEntity:(void (^)(BodyRequest*)) config;

+(HttpRequest*) delete:(void (^)(SimpleRequest*)) config;
```

`HttpRequest` `[Unicorn get:` `(void (^)(SimpleRequest*))] config;`  
Sends equivalent request with method type to given URL

`HttpRequestWithBody` `[Unicorn (post|postEntity):` `(void (^)(MultipartRequest|BodyRequest)(*))] config;`  
Sends equivalent request with method type to given URL

`HttpRequestWithBody` `[Unicorn (put|putEntity):` `(void (^)(MultipartRequest|BodyRequest)(*))] config;`  
Sends equivalent request with method type to given URL

`HttpRequestWithBody` `[Unicorn (patch|patchEntity):` `(void (^)(MultipartRequest|BodyRequest)(*))] config;`  
Sends equivalent request with method type to given URL

`HttpRequest` `[Unicorn delete:` `(void (^)(SimpleRequest*))] config;`  
Sends equivalent request with method type to given URL


### Response Reference
The `HttpRequest` and `HttpRequestWithBody` can then be executed by calling one of:

```objective-c
-(HttpStringResponse*) asString;
-(void) asStringAsync:(void (^)(HttpStringResponse*)) response;

-(HttpBinaryResponse*) asBinary;
-(void) asBinaryAsync:(void (^)(HttpBinaryResponse*)) response;

-(HttpJsonResponse*) asJson;
-(void) asJsonAsync:(void (^)(HttpJsonResponse*)) response;
```

`-(HttpStringResponse*)` `asString;`  
Blocking request call with response returned as string for Hypermedia APIs or other.

`-(void)` `asStringAsync:` `(void (^)(HttpBinaryResponse*)) response;`  
Asynchronous request call with response returned as string for Hypermedia APIs or other.

`-(HttpStringResponse*)` `asBinary;`  
Blocking request call with response returned as binary output for files and other media.

`-(void)` `asBinaryAsync:` `(void (^)(HttpBinaryResponse*)) response;`  
Asynchronous request call with response returned as binary output for files and other media.

`-(HttpStringResponse*)` `asJson;`  
Blocking request call with response returned as JSON.

`-(void)` `asJsonAsync:` `(void (^)(HttpBinaryResponse*)) response;`  
Asynchronous request call with response returned as JSON.


License
---------------

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
