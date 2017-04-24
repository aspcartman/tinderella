//
// Created by ASPCartman on 24/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import <AppKit/AppKit.h>

#import "TNDPromise.h"

@interface TNDRemoteImage : NSObject
@property (nonatomic, readonly) NSString              *id;
@property (nonatomic, readonly) TNDPromise<NSImage *> *image;
+ (instancetype) imageWithUrl:(NSString *)imageURL id:(NSString *)id;
- (instancetype) initWithUrl:(NSString *)imageURL id:(NSString *)id;
@end