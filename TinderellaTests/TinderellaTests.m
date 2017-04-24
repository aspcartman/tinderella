//
//  TinderellaTests.m
//  TinderellaTests
//
//  Created by ASPCartman on 23/04/2017.
//  Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TNDFacebookAPI.h"

@interface TinderellaTests : XCTestCase
@end

@implementation TinderellaTests

- (void) setUp
{
	[super setUp];
	// Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void) tearDown
{
	// Put teardown code here. This method is called after the invocation of each test method in the class.
	[super tearDown];
}

- (void) testExample
{
	[[TNDFacebookAPI new] authenticate];
}

- (void) testPerformanceExample
{
	// This is an example of a performance test case.
	[self measureBlock:^{
		// Put the code you want to measure the time of here.
	}];
}
@end
