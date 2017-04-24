//
// Created by ASPCartman on 23/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import "TNDFacebookAPI.h"
#import "TNDMainListController.h"
#import "TNDFacebookAuthController.h"

@interface TNDFacebookAPI () <TNDFacebookAuthControllerDelegate>
@end

@implementation TNDFacebookAPI
{
	NSWindow               *_window;
	TNDFacebookToken       *_token;
	TNDPromise<NSString *> *_tokenPromise;
	void (^_tokenPromiseResolver)(id);
}
- (instancetype) init
{
	self = [super init];
	if (self) {
	}

	return self;
}

- (TNDPromise<NSString *> *) authenticate
{
	return _tokenPromise ? : (_tokenPromise = [TNDPromise promiseWithResolverBlock:^(void (^resolve)(id)) {
		_tokenPromiseResolver = resolve;
		[self showAuthWindow];
	}]);
}

- (void) showAuthWindow
{
	TNDFacebookAuthController *controller = [TNDFacebookAuthController new];
	controller.delegate = self;

	NSRect            frame     = NSMakeRect(100, 100, 200, 200);
	NSWindowStyleMask styleMask = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable;
	NSRect            rect      = [NSWindow contentRectForFrameRect:frame styleMask:styleMask];
	NSWindow          *window   = [[NSWindow alloc] initWithContentRect:rect styleMask:styleMask backing:NSBackingStoreBuffered defer:NO];
	window.contentViewController = controller;
	window.releasedWhenClosed    = NO;
	[window setBackgroundColor:[NSColor blueColor]];
	[window makeKeyAndOrderFront:window];
	_window = window;
}

- (void) facebookAuthController:(TNDFacebookAuthController *)contoller didAuthenticate:(TNDFacebookToken *)token
{
	_token = token;
	_tokenPromiseResolver(token);
	[_window close];

	_window               = nil;
	_tokenPromiseResolver = nil;
}
@end

