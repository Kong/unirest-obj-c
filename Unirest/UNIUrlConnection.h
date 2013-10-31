//
//  UNIUrlConnection.h
//  Unirest
//
//  Created by Marco on 10/31/13.
//  Copyright (c) 2013 Marco Palladino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UNIUrlConnection : NSObject<NSURLConnectionDelegate>

@property (nonatomic, strong) NSURLRequest *request;
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, copy) void(^completionHandler)(NSURLResponse *response, NSData *data, NSError *error);

+ (UNIUrlConnection *)sendAsynchronousRequest:(NSURLRequest *)request queue:(NSOperationQueue *)queue completionHandler:(void(^)(NSURLResponse *response, NSData *data, NSError *error))completionHandler;
- (void)start;
- (void)cancel;

@end
