//
// Created by ASPCartman on 24/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import "NSLabel.h"

@implementation NSLabel
{
}
- (instancetype) init
{
	self = [super init];
	if (self) {
		self.bezeled         = NO;
		self.drawsBackground = NO;
		self.editable        = NO;
		self.selectable      = NO;
		self.cell.scrollable = NO;
	}

	return self;
}

- (void) setText:(NSString *)text
{
	self.stringValue = text ? : @"";
}

- (NSString *) text
{
	return self.stringValue;
}
@end