//
// Created by ASPCartman on 23/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import <AppKit/AppKit.h>
#import <PromiseKit/AnyPromise.h>

@interface TNDPromise<T> : AnyPromise
+ (instancetype) promise:(id(^)())block;
@end