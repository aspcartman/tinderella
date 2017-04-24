//
// Created by Ruslan Fedorov (Lazada Group) on 24/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import <AppKit/AppKit.h>

@protocol TNDTableViewDelegate
@end

@protocol TNDTableViewDataSource
@end

@interface TNDTableView : NSView
@property (nonatomic, weak) id <TNDTableViewDelegate>   delegate;
@property (nonatomic, weak) id <TNDTableViewDataSource> dataSource;

- (void) registerView:(Class)viewClass forIdentifier:(NSString *)identifier;
- (__kindof NSView *) dequeReusabeVliewWithIdentifier:(NSString *)identifier;
@end