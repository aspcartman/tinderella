//
// Created by ASPCartman on 24/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import "TNDRemoteImage.h"

@implementation TNDRemoteImage
{
	TNDPromise<NSImage *> *_promise;
	NSString              *_url;
}

+ (instancetype) imageWithUrl:(NSString *)imageURL id:(NSString *)id
{
	return [[self alloc] initWithUrl:imageURL id:id];
}

- (instancetype) initWithUrl:(NSString *)imageURL id:(NSString *)id
{
	self = [super init];
	if (self) {
		_url = imageURL;
		_id  = id;
	}

	return self;
}

- (TNDPromise *) image
{
	return _promise ? : (_promise = [TNDPromise promiseWithAdapterBlock:^(PMKAdapter adapter) {
		NSURL                *url     = [NSURL URLWithString:_url];
		NSURLRequest         *request = [NSURLRequest requestWithURL:url];
		NSURLSessionDataTask *task    = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
			adapter(data ? [[NSImage alloc] initWithData:data] : response, error);
		}];
		[task resume];
	}].catch(^(NSError *error) {
		_promise = nil;
		return error;
	}));
}
@end