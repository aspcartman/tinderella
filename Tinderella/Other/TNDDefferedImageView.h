//
// Created by ASPCartman on 24/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import <AppKit/AppKit.h>

@class TNDRemoteImage;

@interface TNDDefferedImageView : NSImageView
@property (nonatomic, strong) TNDRemoteImage *defferedImage;
@end