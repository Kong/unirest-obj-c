# Unirest for Objective-C  [![Build Status][travis-image]][travis-url] [![version][cocoapods-version]][cocoapods-url]

[![License][cocoapods-license]][license-url]
[![Code Climate][codeclimate-quality]][codeclimate-url]
[![Coverage Status][codeclimate-coverage]][codeclimate-url]
[![Gitter][gitter-image]][gitter-url]

Unirest is a set of lightweight HTTP libraries available in [multiple languages](http://unirest.io).

## Features

* Make `GET`, `POST`, `PUT`, `PATCH`, `DELETE` requests
* Both syncronous and asynchronous (non-blocking) requests
* It supports form parameters, file uploads and custom body entities
* Supports gzip
* Supports Basic Authentication natively
* Customizable timeout
* Customizable default headers for every request (DRY)
* Automatic JSON parsing into native object (`NSDictionary` or `NSArray`) for JSON responses

## Installing
<a href="https://github.com/Mashape/unirest-obj-c/archive/master.zip">Download</a> the Objective-C Unirest Library from <a href="https://github.com/Mashape/unirest-obj-c">GitHub</a> (or clone the repo) and import the folder into your project. You can also install Unirest-obj-c with [CocoaPods](http://cocoapods.org/).

### CocoaPods

If you decide to use CocoaPods, create a `Podfile` file in your project's folder:

```bash
$ edit Podfile
platform :ios, '5.0'
pod 'Unirest', '~> 1.1.3'
```

and then execute `pod install`. Make sure to always open the Xcode **workspace** instead of the project file when building your project:

```bash
$ open App.xcworkspace
```

Now you can import your dependencies:

```objective-c
#import <UNIRest.h>
```

### Requirements

The Unirest-Obj-C client library requires ARC (Automatic Reference Counting) to be enabled in your Xcode project. To enable ARC select your project or target and then go to Build Settings and under the section Apple LLVM compiler 3.0 - Language you will see the option Objective-C Automatic Reference Counting:

<img src="http://unirest.io/img/arc-enable.png" alt="Enable ARC in Xcode"/>

For existing projects, fortunately Xcode offers a tool to convert existing code to ARC, which is available at Edit -> Refactor  -> Convert to Objective-C ARC

## Creating Request
So you're probably wondering how using Unirest makes creating requests in Objective-C easier, let's look at a working example:

```objective-c
NSDictionary* headers = @{@"accept": @"application/json"};
NSDictionary* parameters = @{@"parameter": @"value", @"foo": @"bar"};

UNIHTTPJsonResponse *response = [[UNIRest post:^(UNISimpleRequest *request) {
  [request setUrl:@"http://httpbin.org/post"];
  [request setHeaders:headers];
  [request setParameters:parameters];
}] asJson];
```
    
Just like in the Unirest Java library the Objective-C library supports multiple response types given as the last parameter. In the example above we use `asJson` to get a JSON response, likewise there are `asBinary` and `asString` for responses of other nature such as file data and hypermedia responses.

## Asynchronous Requests
For non-blocking requests you will want to make an asychronous request to keep your application going while data is fetched or updated in the background, doing so with unirest is extremely easy with barely any code change from the previous example:

```objective-c
NSDictionary *headers = @{@"accept": @"application/json"};
NSDictionary *parameters = @{@"parameter": @"value", @"foo": @"bar"};

[[UNIRest post:^(UNISimpleRequest *request) {
  [request setUrl:@"http://httpbin.org/post"];
  [request setHeaders:headers];
  [request setParameters:parameters];
}] asJsonAsync:^(UNIHTTPJsonResponse* response, NSError *error) {
  // This is the asyncronous callback block
  NSInteger code = response.code;
  NSDictionary *responseHeaders = response.headers;
  UNIJsonNode *body = response.body;
  NSData *rawBody = response.rawBody;
}];
```

### Cancel Asynchronous Request

You can cancel an asyncronous request by invoking the `cancel` method on the `UNIUrlConnection` object:

```objective-c
UNIUrlConnection *asyncConnection = [[UNIRest get:^(UNISimpleRequest *simpleRequest) {
    [request setUrl:@"http://httpbin.org/get"];
}] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
    // Do something
}];

[asyncConnection cancel]; // Cancel request
```

## File Uploads
Transferring files through request with unirest in Objective-C can be done by creating a `NSURL` object and passing it along as a parameter value with a `UNISimpleRequest` like so:

```objective-c
NSDictionary* headers = @{@"accept": @"application/json"};
NSURL* file = nil;
NSDictionary* parameters = @{@"parameter": @"value", @"file": file};

UNIHTTPJsonResponse *response = [[UNIRest post:^(UNISimpleRequest *request) {
  [request setUrl:@"http://httpbin.org/post"];
  [request setHeaders:headers];
  [request setParameters:parameters];
}] asJson];
```
 
## Custom Entity Body
To send a custom body such as JSON simply serialize your data utilizing the `NSJSONSerialization` with a `BodyRequest` and `[method]Entity` instead of just `[method]` block like so:

```objective-c
NSDictionary *headers = @{@"accept": @"application/json"};
NSDictionary *parameters = @{@"parameter": @"value", @"foo": @"bar"};

UNIHTTPJsonResponse *response = [[UNIRest postEntity:^(UNIBodyRequest *request) {
  [request setUrl:@"http://httpbin.org/post"];
  [request setHeaders:headers];
  // Converting NSDictionary to JSON:
  [request setBody:[NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil]];
}] asJson];
```

## Basic Authentication

Authenticating the request with basic authentication can be done by setting the `username` and `password` properties in the builder:

```objective-c
UNIHTTPJsonResponse *response = [[UNIRest get:^(UNISimpleRequest *request) {
    [request setUrl:@"http://httpbin.org/get"];
    [request setUsername:@"user"];
    [request setPassword:@"password"];
}] asJson];
```

# Request
The Objective-C unirest library uses configuration blocks of type UNISimpleRequest and UNIBodyRequest to configure the URL, Headers, and Parameters / Body of the request.

```objective-c
+(UNIHTTPRequest*) get:(void (^)(UNISimpleRequestBlock*)) config;

+(UNIHTTPRequestWithBody*) post:(void (^)(UNISimpleRequestBlock*)) config;
+(UNIHTTPRequestWithBody*) postEntity:(void (^)(UNIBodyRequestBlock*)) config;

+(UNIHTTPRequestWithBody*) put:(void (^)(UNISimpleRequestBlock*)) config;
+(UNIHTTPRequestWithBody*) putEntity:(void (^)(UNIBodyRequestBlock*)) config;

+(UNIHTTPRequestWithBody*) patch:(void (^)(UNISimpleRequestBlock*)) config;
+(UNIHTTPRequestWithBody*) patchEntity:(void (^)(UNIBodyRequestBlock*)) config;

+(UNIHTTPRequestWithBody*) delete:(void (^)(UNISimpleRequestBlock*)) config;
+(UNIHTTPRequestWithBody*) deleteEntity:(void (^)(UNIBodyRequestBlock*)) config;
```

- `UNIHTTPRequest` `[UNIRest get:` `(void (^)(UNISimpleRequestBlock*))] config;`  
  
  Sends equivalent request with method type to given URL
- `UNIHTTPRequestWithBody` `[UNIRest (post|postEntity):` `(void (^)(UNISimpleRequestBlock|UNIBodyRequestBlock)(*))] config;`  
  
  Sends equivalent request with method type to given URL
- `UNIHTTPRequestWithBody` `[UNIRest (put|putEntity):` `(void (^)(UNISimpleRequestBlock|UNIBodyRequestBlock)(*))] config;`  
  
  Sends equivalent request with method type to given URL
- `UNIHTTPRequestWithBody` `[UNIRest (patch|patchEntity):` `(void (^)(UNISimpleRequestBlock|UNIBodyRequestBlock)(*))] config;`  
  
  Sends equivalent request with method type to given URL
- `UNIHTTPRequestWithBody` `[UNIRest (delete|deleteEntity):` `(void (^)(UNISimpleRequestBlock|UNIBodyRequestBlock)(*))] config;`
  
  Sends equivalent request with method type to given URL

# Response
The `UNIHTTPRequest` and `UNIHTTPRequestWithBody` can then be executed by calling one of:

```objective-c
-(UNIHTTPStringResponse*) asString;
-(UNIHTTPStringResponse*) asString:(NSError**) error;
-(UNIUrlConnection*) asStringAsync:(UNIHTTPStringResponseBlock) response;

-(UNIHTTPBinaryResponse*) asBinary;
-(UNIHTTPBinaryResponse*) asBinary:(NSError**) error;
-(UNIUrlConnection*) asBinaryAsync:(UNIHTTPBinaryResponseBlock) response;

-(UNIHTTPJsonResponse*) asJson;
-(UNIHTTPJsonResponse*) asJson:(NSError**) error;
-(UNIUrlConnection*) asJsonAsync:(UNIHTTPJsonResponseBlock) response;
```

- `-(UNIHTTPStringResponse*)` `asString;`  
  
  Blocking request call with response returned as string for Hypermedia APIs or other.
  
- `-(UNIHTTPStringResponse*) asString:(NSError**) error;`

  Blocking request call with response returned as string and error handling. 
  
- `-(UNIUrlConnection*) asStringAsync:(UNIHTTPStringResponseBlock) response;`  
  
  Asynchronous request call with response returned as string for Hypermedia APIs or other.
  
- `-(UNIHTTPBinaryResponse*)` `asBinary;`  

  Blocking request call with response returned as binary output for files and other media.
  
- `-(UNIHTTPBinaryResponse*) asBinary:(NSError**) error;`

  Blocking request call with response returned as binary output and error handling.    

- `-(UNIUrlConnection*) asBinaryAsync:(UNIHTTPBinaryResponseBlock) response;`  
  
  Asynchronous request call with response returned as binary output for files and other media.
  
- `-(UNIHTTPJsonResponse*)` `asJson;`  
  
  Blocking request call with response returned as JSON.  
  
- `-(UNIHTTPJsonResponse*) asString:(NSError**) error;`

  Blocking request call with response returned as JSON and error handling.  

- `-(UNIUrlConnection*) asJsonAsync:(UNIHTTPJsonResponseBlock) response;`  
  
  Asynchronous request call with response returned as JSON.

# Advanced Configuration

You can set some advanced configuration to tune Unirest-Obj-C:

### Timeout

You can set a custom timeout value (in **seconds**):

```objective-c
[UNIRest timeout:2];
```

By default the timeout is `60`.

### Default Request Headers

You can set default headers that will be sent on every request:

```objective-c
[UNIRest defaultHeader:@"Header1" value:@"Value1"];
[UNIRest defaultHeader:@"Header2" value:@"Value2"];
```

You can clear the default headers anytime with:

```objective-c
[UNIRest clearDefaultHeaders];
```

----

Made with &#9829; from the [Mashape](https://www.mashape.com/) team

[license-url]: https://github.com/Mashape/unirest-obj-c/blob/master/LICENSE

[gitter-url]: https://gitter.im/Mashape/unirest-obj-c
[gitter-image]: https://img.shields.io/badge/Gitter-Join%20Chat-blue.svg?style=flat

[travis-url]: https://travis-ci.org/Mashape/unirest-obj-c
[travis-image]: https://img.shields.io/travis/Mashape/unirest-obj-c.svg?style=flat

[cocoapods-url]: http://cocoadocs.org/docsets/Unirest
[cocoapods-license]: https://img.shields.io/cocoapods/l/Unirest.svg?style=flat
[cocoapods-version]: https://img.shields.io/cocoapods/v/Unirest.svg?style=flat

[codeclimate-url]: https://codeclimate.com/github/Mashape/unirest-obj-c
[codeclimate-quality]: https://img.shields.io/codeclimate/github/Mashape/unirest-obj-c.svg?style=flat
[codeclimate-coverage]: https://img.shields.io/codeclimate/coverage/github/Mashape/unirest-obj-c.svg?style=flat
