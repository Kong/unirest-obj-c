#import "HttpClient.h"

@interface HttpClient()
+ (id) getConfig:instance config:(void (^)(id)) config;
@end

@implementation HttpClient

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

+(HttpRequestWithBody*) delete:(void (^)(MultipartRequest*)) config {
    MultipartRequest* _config = [self getConfig:[[MultipartRequest alloc] init] config:config];
    
    return [[HttpRequestWithBody alloc] initWithMultipartRequest:DELETE url:[_config url] headers:[_config headers] parameters:[_config parameters]];
}

+(HttpRequestWithBody*) deleteEntity:(void (^)(BodyRequest*)) config {
    BodyRequest* _config = [self getConfig:[[BodyRequest alloc] init] config:config];
    
    return [[HttpRequestWithBody alloc] initWithBodyRequest:DELETE url:[_config url] headers:[_config headers] body:[_config body]];
}

@end
