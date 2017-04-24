//
// Created by ASPCartman on 23/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import "TNDMainListController.h"
#import "TNDMainListView.h"
#import "TNDFacebookAPI.h"
#import "TNDTinderAPI.h"
#import "TNDUser.h"

@interface TNDMainListController () <TNDMainListViewDelegate, TNDMainListViewDataSource>
VIEW_PROPERTY(TNDMainListView*);
@property (nonatomic, assign) BOOL loadingMore;
@end

@implementation TNDMainListController
{
	TNDTinderAPI   *_tinderAPI;
	TNDFacebookAPI *_facebookAPI;
	NSArray        *_feed;
	NSMutableSet   *_feedIDs;
}

- (instancetype) init
{
	self = [super init];
	if (self) {
		_facebookAPI = [TNDFacebookAPI new];
		_tinderAPI   = [TNDTinderAPI apiWithFacebook:_facebookAPI];
		_feedIDs     = [NSMutableSet new];
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

	[self loadMore];
}

- (void) loadMore
{
	if (self.loadingMore) {
		return;
	}

	self.loadingMore = YES;
	[_tinderAPI recommendations].then(^(NSArray *recommendations) {
		[self appendRecommendations:recommendations];
		[self.view updateForMoreUsers];
	}).catch(^(NSError *error) {
		NSLog(@"Failed getting recommendations: %@", error);
	}).always(^{
		self.loadingMore = NO;
	});
}

- (void) appendRecommendations:(NSArray *)recommendations
{
	if (_feed == nil) {
		_feed = recommendations;
		return;
	}
	NSArray *newGuys = [recommendations filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(TNDUser *obj, NSDictionary *bindings) {
		if (![_feedIDs containsObject:obj.id]) {
			[_feedIDs addObject:obj.id];
			return YES;
		}
		return NO;
	}]];
	_feed = [_feed arrayByAddingObjectsFromArray:newGuys];
}

- (void) setLoadingMore:(BOOL)loadingMore
{
	_loadingMore = loadingMore;
	self.view.loading = loadingMore;
}

- (NSUInteger) mainListViewNumberOfUsers:(TNDMainListView *)view
{
	return _feed.count;
}

- (TNDUser *) mainListView:(TNDMainListView *)view userAtRow:(NSUInteger)row
{
	return _feed[row];
}

- (void) mainListView:(TNDMainListView *)view didSelectUser:(TNDUser *)user atRow:(NSUInteger)row
{
	(user.matchState != TNDUserMatchStateLiked ? [user like] : [user dislike]).always(^() {
		[self.view reloadUserAtRow:row];
	});
}

- (void) mainListViewApproachingEndOfData:(TNDMainListView *)view
{
	[self loadMore];
}
@end