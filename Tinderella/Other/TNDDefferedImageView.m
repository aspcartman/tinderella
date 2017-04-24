//
// Created by ASPCartman on 24/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import <KeepLayout/KeepLayout.h>
#import "TNDDefferedImageView.h"
#import "TNDDefferedImage.h"

@interface TNDDefferedImageView ()
@property (nonatomic, assign) BOOL loading;
@end

@implementation TNDDefferedImageView
{
	NSProgressIndicator *_activityIndicator;
}

- (instancetype) init
{
	self = [super init];
	if (self) {
		NSProgressIndicator *indicator = [[NSProgressIndicator alloc] initWithFrame:NSMakeRect(20, 20, 30, 30)];
		indicator.style = NSProgressIndicatorSpinningStyle;
		[self addSubview:indicator];
		_activityIndicator = indicator;

		[self setNeedsUpdateConstraints:YES];
	}

	return self;
}

- (void) updateConstraints
{
	_activityIndicator.keepCenter.equal     = 0.5;
	_activityIndicator.keepMarginInsets.min = KeepLow(10);

	[super updateConstraints];
}

- (void) setDefferedImage:(TNDDefferedImage *)defferedImage
{
	_defferedImage = defferedImage;

	if (defferedImage == nil || defferedImage.image.resolved) {
		self.image   = defferedImage.image.value;
		self.loading = NO;
		return;
	}

	self.loading = YES;
	defferedImage.image.then(^(NSImage *image) {
		if (_defferedImage != defferedImage) {
			return;
		}
		self.image      = image;
		self.alphaValue = 0.0f;
		[NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
			[[self animator] setAlphaValue:1.0f];
		}                   completionHandler:nil];
	}).always(^{
		if (_defferedImage != defferedImage) {
			return;
		}
		self.loading = NO;
	});
}

- (void) setLoading:(BOOL)loading
{
	_loading = loading;
	if (loading) {
		_activityIndicator.hidden = NO;
		[_activityIndicator startAnimation:self];
	} else {
		_activityIndicator.hidden = YES;
		[_activityIndicator stopAnimation:self];
	}
}
@end