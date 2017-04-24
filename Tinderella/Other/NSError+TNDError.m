//
// Created by ASPCartman on 23/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import "NSError+TNDError.h"

@implementation NSError (TNDError)
+ (instancetype) error:(NSString *)format, ...
{
	va_list args;
	va_start(args, format);
	NSString *msg = [[NSString alloc] initWithFormat:format arguments:args];
	va_end(args);

	return [NSError errorWithDomain:[NSBundle mainBundle].bundleIdentifier code:format.hash userInfo:@{ NSLocalizedDescriptionKey: msg }];
}
@end