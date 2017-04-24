//
// Created by ASPCartman on 25/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "TNDPromise.h"

@class TNDUser;
@class TNDFacebookAPI;

@interface TNDBadooAPI : NSObject
+ (instancetype) apiWithFacebook:(TNDFacebookAPI *)facebook;
- (instancetype) initWithFacebook:(TNDFacebookAPI *)facebook;
- (TNDPromise<NSArray<TNDUser *> *> *) recommendations;
- (TNDPromise *) like:(TNDUser *)user;
- (TNDPromise *) dislike:(TNDUser *)user;
@end