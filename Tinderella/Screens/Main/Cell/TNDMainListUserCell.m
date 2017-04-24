//
// Created by ASPCartman on 23/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import <KeepLayout/KeepLayout.h>
#import "TNDMainListUserCell.h"
#import "TNDUser.h"
#import "NSLabel.h"
#import "TNDDefferedImageView.h"
#import "NSFont+TNDFont.h"

@implementation TNDMainListUserCell
{
	NSLabel              *_nameLabel;
	NSLabel              *_bioLabel;
	TNDDefferedImageView *_photo;
	TNDDefferedImageView *_photoSmall1;
	TNDDefferedImageView *_photoSmall2;
	TNDDefferedImageView *_photoSmall3;
	TNDDefferedImageView *_photoSmall4;
	NSLabel              *_ageLabel;
	NSLabel              *_distanceLabel;
}
- (instancetype) init
{
	self = [super init];
	if (self) {
		self.wantsLayer = YES;

		TNDDefferedImageView *photo = [TNDDefferedImageView new];
		[self addSubview:photo];
		_photo = photo;

		TNDDefferedImageView *photoSmall1 = [TNDDefferedImageView new];
		[self addSubview:photoSmall1];
		_photoSmall1 = photoSmall1;

		TNDDefferedImageView *photoSmall2 = [TNDDefferedImageView new];
		[self addSubview:photoSmall2];
		_photoSmall2 = photoSmall2;

		TNDDefferedImageView *photoSmall3 = [TNDDefferedImageView new];
		[self addSubview:photoSmall3];
		_photoSmall3 = photoSmall3;

		TNDDefferedImageView *photoSmall4 = [TNDDefferedImageView new];
		[self addSubview:photoSmall4];
		_photoSmall4 = photoSmall4;

		NSLabel *nameLabel = [NSLabel new];
		nameLabel.font = [NSFont tnd_fontWithScale:1.2 weight:NSFontWeightMedium];
		[self addSubview:nameLabel];
		_nameLabel = nameLabel;

		NSLabel *ageLabel = [NSLabel new];
		ageLabel.font = [NSFont tnd_fontWithScale:1.2 weight:NSFontWeightLight];
		[self addSubview:ageLabel];
		_ageLabel = ageLabel;

		NSLabel *distanceLabel = [NSLabel new];
		distanceLabel.font = [NSFont tnd_fontWithScale:1.2 weight:NSFontWeightLight];
		[self addSubview:distanceLabel];
		_distanceLabel = distanceLabel;

		NSLabel *bioLabel = [NSLabel new];
		bioLabel.cell.wraps         = YES;
		bioLabel.lineBreakMode      = NSLineBreakByWordWrapping;
		bioLabel.usesSingleLineMode = NO;
		[self addSubview:bioLabel];
		_bioLabel = bioLabel;

		[self setNeedsUpdateConstraints:YES];
	}

	return self;
}

- (void) updateConstraints
{
	_photo.keepTopInset.equal    = 0;
	_photo.keepLeftInset.equal   = 0;
	_photo.keepBottomInset.equal = 0;
	_photo.keepAspectRatio.equal = 1;

	_photoSmall1.keepTopInset.equal             = 0;
	_photoSmall1.keepLeftOffsetTo(_photo).equal = 0;
	_photoSmall1.keepAspectRatio.equal          = 1;
	_photoSmall1.keepHeightTo(_photo).equal     = 0.5;

	_photoSmall2.keepLeftOffsetTo(_photo).equal = 0;
	_photoSmall2.keepHeightTo(_photo).equal     = 0.5;
	_photoSmall2.keepAspectRatio.equal          = 1;
	_photoSmall2.keepBottomInset.equal          = 0;

	_photoSmall3.keepTopInset.equal                   = 0;
	_photoSmall3.keepLeftOffsetTo(_photoSmall1).equal = 0;
	_photoSmall3.keepHeightTo(_photo).equal           = 0.5;
	_photoSmall3.keepAspectRatio.equal                = 1;

	_photoSmall4.keepLeftOffsetTo(_photoSmall1).equal = 0;
	_photoSmall4.keepHeightTo(_photo).equal           = 0.5;
	_photoSmall4.keepAspectRatio.equal                = 1;
	_photoSmall4.keepBottomInset.equal                = 0;

	_nameLabel.keepTopMarginInset.equal             = 0;
	_nameLabel.keepLeftOffsetTo(_photoSmall3).equal = 10;

	_ageLabel.keepFirstBaselineAlignTo(_nameLabel).equal = 0;
	_ageLabel.keepLeftOffsetTo(_nameLabel).equal         = 10;

	_distanceLabel.keepFirstBaselineAlignTo(_nameLabel).equal = 0;
	_distanceLabel.keepRightMarginInset.equal                 = 20;

	_bioLabel.keepTopOffsetTo(_nameLabel).equal = 0;
	_bioLabel.keepLeftAlignTo(_nameLabel).equal = 0;
	_bioLabel.keepRightMarginInset.equal        = 0;

	[super updateConstraints];
}

- (void) setUser:(TNDUser *)user
{
	if ([_user isEqual:user]) {
		return;
	}

	_user = user;
	_nameLabel.text     = user.name;
	_ageLabel.text      = user.age.stringValue;
	_bioLabel.text      = user.bio;
	_distanceLabel.text = user.distance ? [NSString stringWithFormat:@"%@ km", user.distance] : nil;

	NSArray<TNDRemoteImage *> *photos = user.photos;
	_photo.defferedImage       = [photos firstObject];
	_photoSmall1.defferedImage = photos.count > 1 ? photos[1] : nil;
	_photoSmall2.defferedImage = photos.count > 2 ? photos[2] : nil;
	_photoSmall3.defferedImage = photos.count > 3 ? photos[3] : nil;
	_photoSmall4.defferedImage = photos.count > 4 ? photos[4] : nil;

	switch (user.matchState) {
		case TNDUserMatchStateNone:
			self.layer.backgroundColor = nil;
			break;
		case TNDUserMatchStateDisliked:
			self.layer.backgroundColor = [[NSColor redColor] colorWithAlphaComponent:0.1].CGColor;
			break;
		case TNDUserMatchStateLiked:
			self.layer.backgroundColor = [[NSColor blueColor] colorWithAlphaComponent:0.1].CGColor;
			break;
		case TNDUserMatchStateMatched:
			self.layer.backgroundColor = [[NSColor greenColor] colorWithAlphaComponent:0.1].CGColor;
			break;
	}
}


- (void) prepareForReuse
{
	self.user       = nil;
	_ageLabel.font  = [NSFont tnd_fontWithScale:1.2 weight:NSFontWeightLight];
	_nameLabel.font = [NSFont tnd_fontWithScale:1.2 weight:NSFontWeightMedium];
}
@end