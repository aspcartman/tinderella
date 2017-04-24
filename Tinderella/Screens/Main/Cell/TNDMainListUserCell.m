//
// Created by ASPCartman on 23/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import <KeepLayout/KeepLayout.h>
#import "TNDMainListUserCell.h"
#import "TNDUser.h"
#import "NSLabel.h"
#import "TNDDefferedImageView.h"

@implementation TNDMainListUserCell
{
	NSLabel              *_nameLabel;
	NSLabel              *_bioLabel;
	TNDDefferedImageView *_photo;
	TNDDefferedImageView *_photoSmall1;
	TNDDefferedImageView *_photoSmall2;
	TNDDefferedImageView *_photoSmall3;
	TNDDefferedImageView *_photoSmall4;
}
- (instancetype) init
{
	self = [super init];
	if (self) {

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
		nameLabel.font = [NSFont boldSystemFontOfSize:nameLabel.font.pointSize];
		[self addSubview:nameLabel];
		_nameLabel = nameLabel;

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
	_nameLabel.text = user.name;
	_bioLabel.text  = user.bio;

	NSArray<TNDDefferedImage *> *photos = user.photos;
	_photo.defferedImage       = [photos firstObject];
	_photoSmall1.defferedImage = photos.count > 1 ? photos[1] : nil;
	_photoSmall2.defferedImage = photos.count > 2 ? photos[2] : nil;
	_photoSmall3.defferedImage = photos.count > 3 ? photos[3] : nil;
	_photoSmall4.defferedImage = photos.count > 4 ? photos[4] : nil;
}

- (void) prepareForReuse
{
	self.user       = nil;
	_nameLabel.font = [NSFont boldSystemFontOfSize:_nameLabel.font.pointSize];
}
@end