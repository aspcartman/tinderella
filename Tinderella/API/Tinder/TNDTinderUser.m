//
// Created by ASPCartman on 23/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import <BlocksKit/NSOrderedSet+BlocksKit.h>
#import <NSDate_Helper/NSDate+Helper.h>
#import "TNDTinderUser.h"
#import "TNDTinderAPI.h"
#import "TNDDefferedImage.h"

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
	}

	return self;
}

- (NSString *) description
{
	return [NSString stringWithFormat:@"TinderUser %@:%@", self.id, self.name];
}

- (NSString *) id
{
	return _id ? : (_id = _data[@"_id"]);
}

- (NSString *) name
{
	return _name ? : (_name = _data[@"name"]);
}

- (NSString *) bio
{
	return _bio ? : (_bio = _data[@"bio"]);
}

- (NSDate *) birthdate
{
	NSString *dateString = _data[@"birth_date"];
	if (!dateString) {
		return nil;
	}
	return [NSDate dateFromString:dateString withFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
}

- (NSNumber *) age
{
	if (_age) {
		return _age;
	}

	NSDate *date = self.birthdate;
	if (date == nil) {
		return nil;
	}
	NSTimeInterval seconds = [[NSDate date] timeIntervalSinceDate:date];
	return _age = @((NSInteger) (seconds / (60 * 60 * 24 * 365)));
}

- (NSNumber *) distance
{
	NSNumber *miles = _data[@"distance_mi"];
	return _distance ? : (_distance = @((NSInteger) (miles.floatValue * 1.6)));
}

- (NSArray<NSString *> *) jobs
{
	return _data[@"jobs"];
}

- (NSArray<NSString *> *) schools
{
	return _data[@"schools"];
}

- (NSArray<TNDDefferedImage *> *) photos
{

	return _photos ? : (_photos = [_data[@"photos"] bk_map:^id(NSDictionary *obj) {
		return [TNDDefferedImage imageWithUrl:obj[@"url"]];
	}]);
}
@end