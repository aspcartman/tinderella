//
// Created by ASPCartman on 25/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "TNDUser.h"

@class TNDBadooAPI;

@interface TNDBadooUser : TNDUser
- (instancetype) initWithApi:(TNDBadooAPI *)api data:(NSDictionary *)data;
+ (instancetype) userWithApi:(TNDBadooAPI *)api data:(NSDictionary *)data;
@end