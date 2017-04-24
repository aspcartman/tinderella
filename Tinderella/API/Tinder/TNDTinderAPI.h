//
// Created by ASPCartman on 23/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "TNDPromise.h"

@class TNDFacebookAPI;

@interface TNDTinderAPI : NSObject
+ (instancetype) apiWithFacebook:(TNDFacebookAPI *)facebook;
- (instancetype) initWithFacebook:(TNDFacebookAPI *)facebook;

- (TNDPromise<NSString *> *) authenticate;
- (TNDPromise<NSArray *> *) recommendations;
@end