#import "HttpRequest.h"
#import "HttpClientHelper.h"

@interface HttpRequest()

- (void)invokeAsync:(id (^)(void))asyncBlock resultBlock:(void (^)(id))resultBlock errorBlock:(void (^)(id))errorBlock;

@end

@implementation HttpRequest

@synthesize httpMethod = _httpMethod;
@synthesize headers = _headers;
@synthesize url = _url;


// invokeAsync snippet got from: https://gist.github.com/raulraja/1176022

- (void)invokeAsync:(id (^)(void))asyncBlock resultBlock:(void (^)(id))resultBlock errorBlock:(void (^)(id))errorBlock {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        id result = nil;
        id error = nil;
        @try {
            result = asyncBlock();
        } @catch (NSException *exception) {
            NSLog(@"caught exception: %@", exception);
            error = exception;
        }
        // tell the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error != nil) {
                errorBlock(error);
            } else {
                resultBlock(result);
            }
        });
    });
}

-(HttpRequest*) initWithSimpleRequest:(HttpMethod) httpMethod url:(NSString*) url headers:(NSDictionary*) headers {
    self = [super init];
    [self setHttpMethod:httpMethod];
    [self setUrl:url];
    NSMutableDictionary* lowerCaseHeaders = [[NSMutableDictionary alloc] init];
    if (headers != nil) {
        for(id key in headers) {
            id value = [headers objectForKey:key];
            [lowerCaseHeaders setObject:value forKey:[key lowercaseString]];
        }
    }
    [self setHeaders:lowerCaseHeaders];
    return self;
}

-(HttpStringResponse*) asString {
    HttpResponse* response = [HttpClientHelper request:self];
    return [[HttpStringResponse alloc] initWithSimpleResponse:response];
}

-(void) asStringAsync:(void (^)(HttpStringResponse*)) response {
    [self invokeAsync:^{
        return [self asString];
    }     resultBlock:response errorBlock:nil];
}

-(HttpBinaryResponse*) asBinary {
    HttpResponse* response = [HttpClientHelper request:self];
    return [[HttpBinaryResponse alloc] initWithSimpleResponse:response];
}

-(void) asBinaryAsync:(void (^)(HttpBinaryResponse*)) response {
    [self invokeAsync:^{
        return [self asBinary];
    }     resultBlock:response errorBlock:nil];
}

-(HttpJsonResponse*) asJson {
    HttpResponse* response = [HttpClientHelper request:self];
    return [[HttpJsonResponse alloc] initWithSimpleResponse:response];
}

-(void) asJsonAsync:(void (^)(HttpJsonResponse*)) response {
    [self invokeAsync:^{
        return [self asBinary];
    }     resultBlock:response errorBlock:nil];
}

@end
