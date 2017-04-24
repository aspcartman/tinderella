//
// Created by ASPCartman on 23/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "TNDUser.h"

@class TNDTinderAPI;

@interface TNDTinderUser : TNDUser
- (instancetype) initWithApi:(TNDTinderAPI *)api data:(NSDictionary *)data;
+ (instancetype) userWithApi:(TNDTinderAPI *)api data:(NSDictionary *)data;
@end