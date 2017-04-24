//
// Created by ASPCartman on 23/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import <AppKit/AppKit.h>

@class TNDDefferedImage;

@interface TNDUser : NSObject
@property (nonatomic, readonly) NSString                    *id;
@property (nonatomic, readonly) NSString                    *name;
@property (nonatomic, readonly) NSString                    *bio;
@property (nonatomic, readonly) NSDate                      *birthdate;
@property (nonatomic, readonly) NSNumber                    *age;
@property (nonatomic, readonly) NSNumber                    *distance;
@property (nonatomic, readonly) NSArray<NSString *>         *jobs;
@property (nonatomic, readonly) NSArray<NSString *>         *schools;
@property (nonatomic, readonly) NSArray<TNDDefferedImage *> *photos;
@end