//
// Created by ASPCartman on 23/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import <KeepLayout/KeepLayout.h>
#import "TNDMainListView.h"
#import "TNDMainListUserCell.h"

@interface TNDMainListView () <NSTableViewDelegate, NSTableViewDataSource>
@end

@implementation TNDMainListView
{
	NSTableView  *_tableView;
	NSScrollView *_scrollView;
	NSUInteger   _lastCount;
}

- (instancetype) init
{
	self = [super init];
	if (self) {
		NSTableView *tableView = [[NSTableView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
		tableView.delegate   = self;
		tableView.dataSource = self;
		tableView.rowHeight  = [self tableView:tableView heightOfRow:0];
		[tableView setHeaderView:nil];
		[tableView addTableColumn:[[NSTableColumn alloc] initWithIdentifier:@"ololo"]];
		_tableView = tableView;

		NSScrollView *scrollView = [[NSScrollView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
		scrollView.documentView                                = tableView;
		scrollView.hasVerticalScroller                         = YES;
		scrollView.contentView.postsBoundsChangedNotifications = YES;
		[self addSubview:scrollView];
		_scrollView = scrollView;

		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(boundsDidChange:) name:NSViewBoundsDidChangeNotification object:scrollView.contentView];
	}

	return self;
}

- (void) boundsDidChange:(id)boundsDidChange
{
	NSRect rect = _scrollView.contentView.bounds;
	if (_tableView.frame.size.height - (rect.origin.y + rect.size.height) > 500) {
		return;
	}
	[_delegate mainListViewApproachingEndOfData:self];
}

- (void) layout
{
	_scrollView.frame = self.bounds;
}

#pragma mark TableView

- (NSInteger) numberOfRowsInTableView:(NSTableView *)tableView
{
	return _lastCount = [_dataSource mainListViewNumberOfUsers:self];
}

- (nullable NSView *) tableView:(NSTableView *)tableView viewForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row
{
	TNDMainListUserCell *view = [tableView viewAtColumn:0 row:row makeIfNecessary:NO];
	if (!view) {
		view = [tableView makeViewWithIdentifier:@"cell" owner:self];
	}
	if (!view) {
		view = [TNDMainListUserCell new];
		view.identifier = @"cell";
	}

	view.user = [_dataSource mainListView:self userAtRow:(NSUInteger) row];
	return view;
}

- (CGFloat) tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
	return 200;
}

- (BOOL) tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row
{
	[_delegate mainListView:self didSelectUser:[_dataSource mainListView:self userAtRow:(NSUInteger) row]];
	return YES;
}

- (void) reload
{
	[_tableView noteNumberOfRowsChanged];
}
@end