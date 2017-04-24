//
//  TNDAppDelegate.m
//  Tinderella
//
//  Created by ASPCartman on 23/04/2017.
//  Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import "TNDAppDelegate.h"
#import "TNDMainListController.h"
#import "TNDFacebookAPI.h"

@interface TNDAppDelegate ()
@end

@implementation TNDAppDelegate
{
	NSWindow *_window;
}

- (void) applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application

	NSRect            frame     = NSMakeRect(100, 100, 200, 200);
	NSWindowStyleMask styleMask = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable;
	NSRect            rect      = [NSWindow contentRectForFrameRect:frame styleMask:styleMask];
	NSWindow          *window   = [[NSWindow alloc] initWithContentRect:rect styleMask:styleMask backing:NSBackingStoreBuffered defer:NO];
	window.contentViewController = [TNDMainListController new];
	window.showsResizeIndicator  = YES;
	[window makeKeyAndOrderFront:window];
	_window = window;
}

- (void) applicationWillTerminate:(NSNotification *)aNotification
{
	// Insert code here to tear down your application
}
@end