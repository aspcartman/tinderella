//
// Created by Ruslan Fedorov (Lazada Group) on 24/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import "NSFont+TNDFont.h"

@implementation NSFont (TNDFont)
+ (NSFont *) tnd_fontWithScale:(CGFloat)scale weight:(CGFloat)weight
{
	return [NSFont systemFontOfSize:[NSFont systemFontSize] * scale weight:weight];
}
@end