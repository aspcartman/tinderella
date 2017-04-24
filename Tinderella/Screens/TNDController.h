//
// Created by ASPCartman on 23/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import <AppKit/AppKit.h>

#define VIEW_PROPERTY(VIEWCLASS) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wincompatible-property-type\"") \
_Pragma("clang diagnostic ignored \"-Wobjc-property-synthesis\"") \
_Pragma("ide diagnostic ignored \"covariant_properties\"") \
@property (nonatomic, strong) VIEWCLASS view; \
_Pragma("clang diagnostic pop")

@interface TNDController : NSViewController
@end