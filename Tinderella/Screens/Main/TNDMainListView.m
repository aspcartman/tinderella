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
}

- (instancetype) init
{
	self = [super init];
	if (self) {
		NSTableView *tableView = [[NSTableView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
		tableView.delegate   = self;
		tableView.dataSource = self;
		[tableView addTableColumn:[[NSTableColumn alloc] initWithIdentifier:@"ololo"]];
		_tableView = tableView;

		NSScrollView *scrollView = [[NSScrollView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
		scrollView.documentView = tableView;
		[self addSubview:scrollView];
		_scrollView = scrollView;

		[self setNeedsUpdateConstraints:YES];
	}

	return self;
}

- (void) updateConstraints
{
	_scrollView.keepInsets.equal = 0;

	[super updateConstraints];
}

#pragma mark TableView

- (NSInteger) numberOfRowsInTableView:(NSTableView *)tableView
{
	return [_dataSource mainListViewNumberOfUsers:self];
}

- (nullable NSView *) tableView:(NSTableView *)tableView viewForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row
{
	TNDMainListUserCell *view = [TNDMainListUserCell new];
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
	[_tableView reloadData];
}
@end