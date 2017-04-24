//
// Created by ASPCartman on 23/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import "TNDMainListController.h"
#import "TNDMainListView.h"
#import "TNDFacebookAPI.h"
#import "TNDTinderAPI.h"

@interface TNDMainListController () <TNDMainListViewDelegate, TNDMainListViewDataSource>
VIEW_PROPERTY(TNDMainListView*);
@end

@implementation TNDMainListController
{
	TNDTinderAPI   *_tinderAPI;
	TNDFacebookAPI *_facebookAPI;
	NSArray        *_feed;
}

- (instancetype) init
{
	self = [super init];
	if (self) {
		_facebookAPI = [TNDFacebookAPI new];
		_tinderAPI   = [TNDTinderAPI apiWithFacebook:_facebookAPI];
	}

	return self;
}

- (void) loadView
{
	TNDMainListView *listView = [TNDMainListView new];
	listView.frame      = NSMakeRect(0, 0, 1024, 500);
	listView.delegate   = self;
	listView.dataSource = self;
	self.view           = listView;
}


- (void) viewDidAppear
{
	[super viewDidAppear];

	self.view.loading = YES;
	[_tinderAPI recommendations].then(^(NSArray *recommendations) {
		_feed = _feed ? [_feed arrayByAddingObjectsFromArray:recommendations] : recommendations;
	}).catch(^(NSError *error) {
		NSLog(@"Failed getting recommendations: %@", error);
	}).always(^{
		self.view.loading = NO;
		[self.view reload];
	});
}

- (NSUInteger) mainListViewNumberOfUsers:(TNDMainListView *)view
{
	return _feed.count;
}

- (TNDUser *) mainListView:(TNDMainListView *)view userAtRow:(NSUInteger)row
{
	return _feed[row];
}

- (void) mainListView:(TNDMainListView *)view didSelectUser:(TNDUser *)user
{
}
@end