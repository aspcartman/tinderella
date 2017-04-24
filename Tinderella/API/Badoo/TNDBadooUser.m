//
// Created by ASPCartman on 25/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import "TNDBadooUser.h"
#import "TNDBadooAPI.h"
#import "TNDRemoteImage.h"

@implementation TNDBadooUser
{
	TNDBadooAPI  *_api;
	NSDictionary *_data;
}

@synthesize id = _id;
@synthesize name = _name;
@synthesize bio = _bio;
@synthesize photos = _photos;
@synthesize age = _age;
@synthesize matchState = _matchState;

+ (instancetype) userWithApi:(TNDBadooAPI *)api data:(NSDictionary *)data
{
	return [[self alloc] initWithApi:api data:data];
}

- (instancetype) initWithApi:(TNDBadooAPI *)api data:(NSDictionary *)data
{
	self = [super init];
	if (self) {
		_api  = api;
		_data = data;

		_id   = data[@"user_id"];
		_name = data[@"name"];
		_age  = data[@"age"];

		for (NSDictionary *field in data[@"profile_fields"]) {
			NSString *fid  = field[@"id"];
			id       value = field[@"display_value"];
			if ([fid isEqual:@"aboutme_text"]) {
				_bio = value;
			}
		}

		NSMutableArray    *photos = [NSMutableArray new];
		for (NSDictionary *album in data[@"albums"]) {
			for (NSDictionary *photo in album[@"photos"]) {
				[photos addObject:[TNDRemoteImage imageWithUrl:[NSString stringWithFormat:@"https:%@", photo[@"large_url"]] id:photo[@"id"]]];
			}
		}
		_photos = photos.count ? photos : nil;
	}

	return self;
}

- (TNDPromise<NSNumber *> *) like
{
	return [_api like:self].then(^{
		_matchState = TNDUserMatchStateLiked;
	});
}

- (TNDPromise<NSNumber *> *) dislike
{
	return [_api dislike:self].then(^{
		_matchState = TNDUserMatchStateDisliked;
	});
}
@end