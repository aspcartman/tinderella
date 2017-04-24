//
// Created by ASPCartman on 23/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import <AFNetworking/AFHTTPSessionManager.h>
#import <BlocksKit/NSArray+BlocksKit.h>
#import "TNDTinderAPI.h"
#import "TNDFacebookAPI.h"
#import "NSError+TNDError.h"
#import "TNDTinderUser.h"
#import "TNDUser.h"

@implementation TNDTinderAPI
{
	TNDFacebookAPI         *_facebook;
	TNDPromise<NSString *> *_authPromise;

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
		[requestSerializer setValue:@"6.9.4" forHTTPHeaderField:@"app_version"];
		[requestSerializer setValue:@"ios" forHTTPHeaderField:@"platform"];
		[requestSerializer setValue:@"application/json" forHTTPHeaderField:@"content-type"];
		[requestSerializer setValue:@"Tinder/4.7.1 (iPhone; iOS 9.2; Scale/2.00)" forHTTPHeaderField:@"User-agent"];

		AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer new];
		responseSerializer.removesKeysWithNullValues = YES;

		AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[[NSURL alloc] initWithString:@"https://api.gotinder.com/"]];
		manager.requestSerializer  = requestSerializer;
		manager.responseSerializer = responseSerializer;
		_http = manager;
	}
	return self;
}

- (TNDPromise<NSString *> *) authenticate
{
	return _authPromise ? : (_authPromise = [_facebook authenticate].then(^id(TNDFacebookToken *token) {
		return [self request:@"POST" path:@"/auth" parameters:@{ @"facebook_id": token.userID, @"facebook_token": token.accessToken }];
	}).then(^id(NSDictionary *responce) {
		NSString *token = responce[@"token"];
		if (token.length == 0) {
			return [NSError error:@"Failed acquiring token from tinder: %@", responce];
		}
		[_http.requestSerializer setValue:token forHTTPHeaderField:@"X-Auth-Token"];
		return token;
	}));
}

- (TNDPromise<NSArray *> *) recommendations
{
	return [self authenticate].then(^{
		return [self request:@"GET" path:@"/user/recs" parameters:nil];
	}).then(^(NSDictionary *data) {
		return [data[@"results"] bk_map:^id(id obj) {
			return [TNDTinderUser userWithApi:self data:obj];
		}];
	});
}

- (TNDPromise<TNDUser *> *) userByID:(NSString *)id
{
	return [self authenticate].then(^{
		return [self request:@"GET" path:[NSString stringWithFormat:@"/user/%@", id] parameters:nil];
	}).then(^(NSDictionary *res) {
		return [TNDTinderUser userWithApi:self data:res];
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