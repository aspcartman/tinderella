//
// Created by ASPCartman on 23/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import <AppKit/AppKit.h>

@class TNDMainListView;
@class TNDUser;

@protocol TNDMainListViewDataSource
- (NSUInteger) mainListViewNumberOfUsers:(TNDMainListView *)view;
- (TNDUser *) mainListView:(TNDMainListView *)view userAtRow:(NSUInteger)row;
@end

@protocol TNDMainListViewDelegate
- (void) mainListView:(TNDMainListView *)view didSelectUser:(TNDUser *)user atRow:(NSUInteger)row;
- (void) mainListViewApproachingEndOfData:(TNDMainListView *)view;
@end

@interface TNDMainListView : NSView
@property (nonatomic, weak) id <TNDMainListViewDataSource> dataSource;
@property (nonatomic, weak) id <TNDMainListViewDelegate>   delegate;
@property (nonatomic) BOOL                                 loading;
- (void) updateForMoreUsers;
- (void) reloadUserAtRow:(NSUInteger)row;
@end