//
// Created by ASPCartman on 23/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import "TNDUser.h"
#import "TNDDefferedImage.h"

@implementation TNDUser
{
}

- (BOOL) isEqual:(TNDUser *)object
{
	if ([super isEqual:object]) {
		return YES;
	}
	if (![object isKindOfClass:self.class]) {
		return NO;
	}
	return [self.id isEqual:object.id];
}

- (TNDPromise<NSNumber *> *) like
{
	NSAssert(0, @"Unimplemented");
	return nil;
}

- (TNDPromise<NSNumber *> *) dislike
{
	NSAssert(0, @"Unimplemented");
	return nil;
}
@end