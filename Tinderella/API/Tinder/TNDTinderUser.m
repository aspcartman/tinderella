//
// Created by ASPCartman on 23/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import <BlocksKit/NSOrderedSet+BlocksKit.h>
#import "TNDTinderUser.h"
#import "TNDTinderAPI.h"
#import "TNDDefferedImage.h"

@implementation TNDTinderUser
{
	__weak TNDTinderAPI *_api;
	NSDictionary        *_data;
}

@synthesize photos = _photos;

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
	return _data[@"_id"];
}

- (NSString *) name
{
	return _data[@"name"];
}

- (NSString *) bio
{
	return _data[@"bio"];
}

- (NSDate *) birthdate
{
	return _data[@"birth_date"];
}

- (NSNumber *) distance
{
	return _data[@"distance"];
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