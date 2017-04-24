//
// Created by ASPCartman on 23/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import "TNDFacebookAuthController.h"
#import "TNDFacebookToken.h"
#import <WebKit/WebKit.h>

@interface TNDFacebookAuthController () <WebFrameLoadDelegate>
VIEW_PROPERTY(WebView*);
@end

@implementation TNDFacebookAuthController
{
	NSString *_userAgent;
	NSString *_authLink;
}
- (instancetype) init
{
	self = [super init];
	if (self) {
		_userAgent = @"Mozilla/5.0 (Linux; U; en-gb; KFTHWI Build/JDQ39) AppleWebKit/535.19 (KHTML, like Gecko) Silk/3.16 Safari/535.19";
		_authLink  = @"https://www.facebook.com/v2.6/dialog/oauth?redirect_uri=fb464891386855067%3A%2F%2Fauthorize%2F&display=touch&state=%7B%22challenge%22%3A%22IUUkEUqIGud332lfu%252BMJhxL4Wlc%253D%22%2C%220_auth_logger_id%22%3A%2230F06532-A1B9-4B10-BB28-B29956C71AB1%22%2C%22com.facebook.sdk_client_state%22%3Atrue%2C%223_method%22%3A%22sfvc_auth%22%7D&scope=user_birthday%2Cuser_photos%2Cuser_education_history%2Cemail%2Cuser_relationship_details%2Cuser_friends%2Cuser_work_history%2Cuser_likes&response_type=token%2Csigned_request&default_audience=friends&return_scopes=true&auth_type=rerequest&client_id=464891386855067&ret=login&sdk=ios&logger_id=30F06532-A1B9-4B10-BB28-B29956C71AB1&ext=1470840777&hash=AeZqkIcf-NEW6vBd";
	}

	return self;
}

- (void) loadView
{
	WebView *webView = [[WebView alloc] initWithFrame:CGRectMake(0, 0, 350, 500)];
	webView.frameLoadDelegate = self;
	webView.customUserAgent   = _userAgent;
	self.view                 = webView;
}

- (void) viewDidAppear
{
	[self.view setMainFrameURL:_authLink];
	[super viewDidAppear];
}

- (void) viewWillDisappear
{
	self.view.frameLoadDelegate = nil;
	[self.view stopLoading:self];
	[super viewWillDisappear];
}

- (void) webView:(WebView *)sender willPerformClientRedirectToURL:(NSURL *)URL delay:(NSTimeInterval)seconds fireDate:(NSDate *)date forFrame:(WebFrame *)frame
{
	NSLog(@"Redirect: %@", URL);
	NSString *url            = URL.absoluteString;
	if (![url hasPrefix:@"fb464891386855067"]) {
		return;
	}
	NSError             *error;
	NSRegularExpression *exp = [NSRegularExpression regularExpressionWithPattern:@"access_token=([\\w\\d]+)" options:0 error:&error];
	if (error != nil) {
		NSLog(@"%@", error);
		return;
	}
	NSRange range = [exp rangeOfFirstMatchInString:url options:0 range:NSMakeRange(0, url.length)];
	if (range.location == NSNotFound) {
		NSLog(@"Didn't find a token in %@", url);
		return;
	}
	range.location += @"access_token=".length;
	range.length -= @"access_token=".length;

	[self didAcquireAccessToken:[url substringWithRange:range]];
}

- (void) didAcquireAccessToken:(NSString *)accessToken
{
	NSURL        *url    = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://graph.facebook.com/me?access_token=%@", accessToken]];
	NSData       *data   = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:nil];
	NSDictionary *answer = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
	if (![answer isKindOfClass:[NSDictionary class]] || answer[@"id"] == nil) {
		NSLog(@"Failed requesting userid %@", answer);
		return;
	}

	[self didAcquireAccessToken:accessToken andUserID:answer[@"id"]];
}

- (void) didAcquireAccessToken:(NSString *)accessToken andUserID:(NSString *)userID
{
	TNDFacebookToken *token = [TNDFacebookToken new];
	token.userID      = userID;
	token.accessToken = accessToken;

	[_delegate facebookAuthController:self didAuthenticate:token];
}

- (void) dealloc
{
	NSLog(@"Dealloced");
}
@end