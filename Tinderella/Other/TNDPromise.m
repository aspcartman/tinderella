//
// Created by ASPCartman on 23/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import "TNDPromise.h"

@implementation TNDPromise
{
}
+ (instancetype) promise:(id(^)())block
{
	return [TNDPromise promiseWithResolverBlock:^(void (^resolve)(id)) {
		resolve(block);
	}];
}
@end