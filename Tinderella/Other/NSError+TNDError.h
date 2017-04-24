//
// Created by ASPCartman on 23/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface NSError (TNDError)
+ (instancetype) error:(NSString *)format, ... NS_FORMAT_FUNCTION(1, 2);
@end