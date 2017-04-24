//
// Created by ASPCartman on 23/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "TNDController.h"

@class TNDFacebookAuthController;
@class TNDFacebookToken;

@protocol TNDFacebookAuthControllerDelegate
- (void) facebookAuthController:(TNDFacebookAuthController *)contoller didAuthenticate:(TNDFacebookToken *)token;
@end

@interface TNDFacebookAuthController : TNDController
@property (nonatomic, weak) id <TNDFacebookAuthControllerDelegate> delegate;
@end