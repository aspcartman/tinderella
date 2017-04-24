//
// Created by ASPCartman on 23/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "TNDPromise.h"
#import "TNDFacebookToken.h"

@interface TNDFacebookAPI : NSObject
- (TNDPromise<TNDFacebookToken *> *) authenticate;
@end