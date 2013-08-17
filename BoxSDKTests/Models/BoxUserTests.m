//
//  BoxUserTests.m
//  BoxSDK
//
//  Created on 8/14/13.
//  Copyright (c) 2013 Box. All rights reserved.
//

#import "BoxUserTests.h"
#import "BoxSDKTestsHelpers.h"
#import "BoxSDKConstants.h"

#import "BoxUser.h"

@implementation BoxUserTests

-(void)setUp
{
    JSONDictionaryFull = @{
        BoxAPIObjectKeyType : BoxAPIItemTypeUser,
        BoxAPIObjectKeyID : @"6000000000", // 6 billion > 2**32
        BoxAPIObjectKeyName : @"Rick Astley",
        BoxAPIObjectKeyLogin : @"rick@astley.com",
        BoxAPIObjectKeyCreatedAt : @"2009-03-04T01:02:03Z", // 1236128523
        BoxAPIObjectKeyModifiedAt : @"2009-03-05T01:02:03Z", // 1236214923
        BoxAPIObjectKeyRole : @"admin",
        BoxAPIObjectKeyLanguage : @"en",
        BoxAPIObjectKeySpaceAmount : @"10737418240", // 10 GB
        BoxAPIObjectKeySpaceUsed : @"5368709120", // 5 GB
        BoxAPIObjectKeyMaxUploadSize: @"1073741824", // 1 GB
        BoxAPIObjectKeyTrackingCodes: @{
            @"never" : @"gonna",
            @"give" : @"you",
        },
        BoxAPIObjectKeyCanSeeManagedUsers: @YES,
        BoxAPIObjectKeyIsSyncEnabled: @NO,
        BoxAPIObjectKeyStatus: @"active",
        BoxAPIObjectKeyJobTitle: @"Singer",
        BoxAPIObjectKeyPhone: @"1234567890",
        BoxAPIObjectKeyAddress: @"Never Gonna Let You Down Blvd",
        BoxAPIObjectKeyIsExemptFromDeviceLimits: @YES,
        BoxAPIObjectKeyIsExemptFromLoginVerification: @NO,
        BoxAPIObjectKeyAvatarURL : @"https://www.box.com/avatar.jpg",
    };
    JSONDictionaryMini = @{
        BoxAPIObjectKeyType : BoxAPIItemTypeUser,
        BoxAPIObjectKeyID : @"6000000000", // 6 billion > 2**32
    };
    
    user = [[BoxUser alloc] initWithResponseJSON:JSONDictionaryFull mini:NO];
    miniUser = [[BoxUser alloc] initWithResponseJSON:JSONDictionaryMini mini:YES];
}

- (void)testThatNameIsReturnedFromFullFormat
{
    STAssertEqualObjects(@"Rick Astley", user.name, @"expected name did not match actual");
}

- (void)testThatNameIsReturnedAsNilIfUnsetFromMiniFormat
{
    STAssertNil(miniUser.name, @"expected status should be nil");
}

- (void)testThatLoginIsReturnedFromFullFormat
{
    STAssertEqualObjects(@"rick@astley.com", user.login, @"expected login did not match actual");
}

- (void)testThatLoginIsReturnedAsNilIfUnsetFromMiniFormat
{
    STAssertNil(miniUser.login, @"expected status should be nil");
}

- (void)testThatCreatedAtIsParsedCorrectlyIntoADateFromFullFormat
{
    NSDate *expectedDate = [NSDate dateWithTimeIntervalSince1970:1236128523];
    STAssertEqualObjects(expectedDate, user.createdAt, @"expected created_at did not match actual");
}

- (void)testThatCreatedAtIsReturnedAsNilIfUnsetFromMiniFormat
{
    STAssertNil(miniUser.createdAt, @"created_at should be nil");
}

- (void)testThatCreatedAtIsReturnedAsNilIfSetToAGarbageValue
{
    BoxUser *garbageUser = [[BoxUser alloc] initWithResponseJSON:@{BoxAPIObjectKeyCreatedAt : @"foobar is not a timestamp"} mini:YES];
    STAssertNil(garbageUser.createdAt, @"created_at should be nil when user is initalized with a garbage value");
}

- (void)testThatModifiedAtIsParsedCorrectlyIntoADateFromFullFormat
{
    NSDate *expectedDate = [NSDate dateWithTimeIntervalSince1970:1236214923];
    STAssertEqualObjects(expectedDate, user.modifiedAt, @"expected modified at did not match actual");
}

- (void)testThatModifiedAtIsReturnedAsNilIfUnsetFromMiniFormat
{
    STAssertNil(miniUser.modifiedAt, @"modified at should be nil");
}

- (void)testThatModifiedAtIsReturnedAsNilIfSetToAGarbageValue
{
    BoxUser *garbageUser = [[BoxUser alloc] initWithResponseJSON:@{BoxAPIObjectKeyModifiedAt : @"foobar is not a timestamp"} mini:YES];
    STAssertNil(garbageUser.modifiedAt, @"modified at should be nil when user is initalized with a garbage value");
}

- (void)testThatRoleIsReturnedFromFullFormat
{
    STAssertEqualObjects(@"admin", user.role, @"expected role did not match actual");
}

- (void)testThatRoleIsReturnedAsNilIfUnsetFromMiniFormat
{
    STAssertNil(miniUser.role, @"expected role should be nil");
}

- (void)testThatStatusIsReturnedFromFullFormat
{
    STAssertEqualObjects(@"active", user.status, @"expected status did not match actual");
}

- (void)testThatStatusIsReturnedAsNilIfUnsetFromMiniFormat
{
    STAssertNil(miniUser.status, @"expected status should be nil");
}

- (void)testThatTrackingCodesIsReturnedFromFullFormat
{
    NSDictionary *expectedTrackingCodes = @{
        @"never" : @"gonna",
        @"give" : @"you",
    };
    STAssertEqualObjects(expectedTrackingCodes, user.trackingCodes, @"expected tracking_codes did not match actual");
}

- (void)testThatTrackingCodesisReturnedAsNilIfUnsetFromMiniFormat
{
    STAssertNil(miniUser.trackingCodes, @"expected trackingCodes should be nil");
}

- (void)testThatCanSeeManagedUsersIsParsedCorrectlyIntoABooleanFromFullFormat
{
    STAssertEquals(@YES, user.canSeeManagedUsers, @"expected can_see_managed_users should be set to True");
}

- (void)testThatCanSeeManagedUsersIsSetAsNilIfUnsetFromMiniFormat
{
    STAssertNil(miniUser.canSeeManagedUsers, @"expected can_see_managed_users should be nil");
}

- (void)testThatIsSyncEnabledIsParsedCorrectlyIntoABooleanFromFullFormat
{
    STAssertEquals(@NO, user.isSyncEnabled, @"expected is_sync_enabled should be set to False");
}

- (void)testThatIsSyncEnabledIsSetAsNilIfUnsetFromMiniFormat
{
    STAssertNil(miniUser.isSyncEnabled, @"expected is_sync_enabled should be nil");
}

@end
