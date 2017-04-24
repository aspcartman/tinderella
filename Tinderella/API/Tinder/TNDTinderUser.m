//
// Created by ASPCartman on 23/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import <BlocksKit/NSOrderedSet+BlocksKit.h>
#import <NSDate_Helper/NSDate+Helper.h>
#import "TNDTinderUser.h"
#import "TNDTinderAPI.h"
#import "TNDRemoteImage.h"

@implementation TNDTinderUser
{
	__weak TNDTinderAPI *_api;
	NSDictionary        *_data;
}

@synthesize id = _id;
@synthesize name = _name;
@synthesize bio = _bio;
@synthesize photos = _photos;
@synthesize age = _age;
@synthesize distance = _distance;
@synthesize matchState = _matchState;
@synthesize birthdate = _birthdate;

+ (instancetype) userWithApi:(TNDTinderAPI *)api data:(NSDictionary *)data
{
	return [[self alloc] initWithApi:api data:data];
}

- (instancetype) initWithApi:(TNDTinderAPI *)api data:(NSDictionary *)data
{
	self = [super init];
	if (self) {
		_api  = api;
		_data = data;

		_id             = _data[@"_id"];
		_name           = _data[@"name"];
		_bio            = _data[@"bio"];
		_birthdate      = _data[@"birth_date"] ? [NSDate dateFromString:_data[@"birth_date"] withFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"] : nil;
		if (_birthdate) {
			NSTimeInterval seconds = [[NSDate date] timeIntervalSinceDate:_birthdate];
			_age                   = @((NSInteger) (seconds / (60 * 60 * 24 * 365)));
		}
		NSNumber *miles = _data[@"distance_mi"];
		_distance = miles ? @((NSInteger) (miles.floatValue * 1.6)) : nil;
		_photos   = [_data[@"photos"] bk_map:^id(NSDictionary *obj) {
			return [TNDRemoteImage imageWithUrl:obj[@"url"] id:nil];
		}];
	}

	return self;
}

- (NSString *) description
{
	return [NSString stringWithFormat:@"TinderUser %@:%@", self.id, self.name];
}

#pragma mark Actions

- (TNDPromise<NSNumber *> *) like
{
	return [_api like:self].then(^(NSNumber *res) {
		_matchState = (TNDUserMatchState) res.integerValue;
	});
}

- (TNDPromise<NSNumber *> *) dislike
{
	return [_api dislike:self].then(^{
		_matchState = TNDUserMatchStateDisliked;
	});
}
@end