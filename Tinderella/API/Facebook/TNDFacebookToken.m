//
// Created by ASPCartman on 23/04/2017.
// Copyright (c) 2017 ASPCartman. All rights reserved.
//

#import "TNDFacebookToken.h"

@implementation TNDFacebookToken
{
}
- (NSString *) description
{
	return [NSString stringWithFormat:@"FacebookToken: %@ %@", _userID, _accessToken];
}
@end