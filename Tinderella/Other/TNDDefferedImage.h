//
// Created by ASPCartman on 24/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import <AppKit/AppKit.h>

#import "TNDPromise.h"

@interface TNDDefferedImage : NSObject
@property (nonatomic, readonly) TNDPromise<NSImage *> *image;
- (instancetype) initWithUrl:(NSString *)imageURL;
+ (instancetype) imageWithUrl:(NSString *)imageURL;
@end