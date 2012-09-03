//
//  MashapeResponse.h
//  test
//
//  Created by Marco Palladino on 9/3/12.
//  Copyright (c) 2012 Marco Palladino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MashapeResponse : NSObject {
    NSData* raw_body;
    NSDictionary* headers;
    int code;
    id body;
}

@property(nonatomic, retain) NSData *raw_body;
@property(nonatomic, retain) NSDictionary *headers;
@property(nonatomic, assign) int code;
@property(nonatomic, assign) id body;

@end
