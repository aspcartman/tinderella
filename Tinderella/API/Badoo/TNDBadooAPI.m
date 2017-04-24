//
// Created by ASPCartman on 25/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import "TNDBadooAPI.h"
#import "TNDUser.h"
#import <AFNetworking/AFNetworking.h>
#import <BlocksKit/NSArray+BlocksKit.h>
#import "TNDFacebookAPI.h"
#import "TNDBadooUser.h"
#import "NSError+TNDError.h"
#import "TNDRemoteImage.h"

@implementation TNDBadooAPI
{
	TNDFacebookAPI       *_facebook;
	AFHTTPSessionManager *_http;
}

+ (instancetype) apiWithFacebook:(TNDFacebookAPI *)facebook
{
	return [[self alloc] initWithFacebook:facebook];
}

- (instancetype) initWithFacebook:(TNDFacebookAPI *)facebook
{
	self = [super init];
	if (self) {
		_facebook = facebook;

		AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer new];
		[requestSerializer setValue:@"json" forHTTPHeaderField:@"Content-Type"];
		[requestSerializer setValue:@"https://badoo.com/encounters" forHTTPHeaderField:@"Referer"];
		[requestSerializer setValue:@"https://badoo.com" forHTTPHeaderField:@"Origin"];
		[requestSerializer setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/602.4.8 (KHTML, like Gecko) Version/10.0.3 Safari/602.4.8" forHTTPHeaderField:@"User-Agent"];
		[requestSerializer setValue:@"jec7bbcff021b499a847b727edb6ae93a" forHTTPHeaderField:@"X-Session-id"];
		[requestSerializer setValue:@"81" forHTTPHeaderField:@"X-Message-type"];
		[requestSerializer setValue:@"495993586" forHTTPHeaderField:@"X-User-id"];

		AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer new];
		responseSerializer.removesKeysWithNullValues = YES;

		AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[[NSURL alloc] initWithString:@"https://api.gotinder.com/"]];
		manager.requestSerializer  = requestSerializer;
		manager.responseSerializer = responseSerializer;
		_http = manager;
	}
	return self;
}


- (TNDPromise<NSArray<TNDUser *> *> *) recommendations
{
	return [self request:@"POST" path:@"https://badoo.com/api.phtml?SERVER_GET_ENCOUNTERS" parameters:@{
			@"version": @1,
			@"message_type": @81,
			@"message_id": @4,
			@"body": @[
					@{
							@"message_type": @81,
							@"server_get_encounters": @{
							@"number": @20,
							@"context": @1,
							@"user_field_filter": @{
									@"projection": @[
											@200,
											@230,
											@210,
											@301,
											@302,
											@680,
											@303,
											@304,
											@290,
											@291,
											@490,
											@800,
											@330,
											@331,
											@460,
											@732,
											@370,
											@410,
											@870,
											@740,
											@742,
											@311,
											@10005
									],
									@"request_albums": @[
											@{
													@"album_type": @7
											}
									],
									@"united_friends_filter": @[
											@{
													@"count": @5,
													@"section_type": @3
											},
											@{
													@"count": @5,
													@"section_type": @1
											},
											@{
													@"count": @5,
													@"section_type": @2
											}
									]
							}
					}
					}
			]
	}].then(^id(NSDictionary *res) {
		NSArray *results = [[res[@"body"] firstObject][@"client_encounters"][@"results"] bk_map:^id(NSDictionary *obj) {
			return [TNDBadooUser userWithApi:self data:obj[@"user"]];
		}];
		if (results.count == 0) {
			return [NSError error:@"Badoo recommendations returned some garbage: %@", res];
		}
		return results;
	});
}

- (TNDPromise *) like:(TNDUser *)user
{
	return [self request:@"POST" path:@"https://badoo.com/api.phtml?SERVER_ENCOUNTERS_VOTE" parameters:@{
			@"version": @1,
			@"message_type": @80,
			@"message_id": @14,
			@"body": @[ @{
					@"message_type": @80,
					@"server_encounters_vote": @{
							@"person_id": user.id,
							@"vote": @2,
							@"photo_id": user.photos.firstObject.id,
							@"vote_source": @1
					}
			} ]
	}].then(^(NSDictionary *result) {
		NSLog(@"%@", result);
	});
}

- (TNDPromise *) dislike:(TNDUser *)user
{
	return [self request:@"POST" path:@"https://badoo.com/api.phtml?SERVER_ENCOUNTERS_VOTE" parameters:@{
			@"version": @1,
			@"message_type": @80,
			@"message_id": @14,
			@"body": @[ @{
					@"message_type": @80,
					@"server_encounters_vote": @{
							@"person_id": user.id,
							@"vote": @3,
							@"photo_id": user.photos.firstObject.id,
							@"vote_source": @1
					}
			} ]
	}].then(^(NSDictionary *result) {
		NSLog(@"%@", result);
	});
}


- (TNDPromise *) request:(NSString *)HTTP path:(NSString *)path parameters:(id)parameters
{
	return [TNDPromise promiseWithAdapterBlock:^(PMKAdapter adapter) {
		void (^success)(NSURLSessionDataTask *, id)=^(NSURLSessionDataTask *task, id responseObject) {
			adapter(responseObject, nil);
		};
		void (^failure)(NSURLSessionDataTask *, NSError *)=^(NSURLSessionDataTask *task, NSError *error) {
			adapter(task, error);
		};

		if ([HTTP isEqual:@"GET"]) {
			[_http GET:path parameters:parameters progress:nil success:success failure:failure];
		} else if ([HTTP isEqual:@"POST"]) {
			[_http POST:path parameters:parameters progress:nil success:success failure:failure];
		} else {
			@throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"I don't know that type of request" userInfo:@{}];
		}
	}];
}
@end