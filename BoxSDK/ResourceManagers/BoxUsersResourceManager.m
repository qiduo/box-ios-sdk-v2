//
//  BoxUsersResourceManager.m
//  BoxSDK
//
//  Created on 8/15/13.
//  Copyright (c) 2013 Box. All rights reserved.
//

#import "BoxUsersResourceManager.h"
#import "BoxUsersRequestBuilder.h"
#import "BoxOAuth2Session.h"
#import "BoxSDKConstants.h"

NSString *const BoxAPIUserIDMe = @"me";

@implementation BoxUsersResourceManager

- (BoxAPIJSONOperation *)userInfoWithID:(NSString *)userId requestBuilder:(BoxUsersRequestBuilder *)builder success:(BoxUserBlock)successBlock failure:(BoxAPIJSONFailureBlock)failureBlock
{
    NSURL *URL = [self URLWithResource:@"users" ID:userId subresource:nil subID:nil];
    BoxAPIJSONOperation *operation = [[BoxAPIJSONOperation alloc] initWithURL:URL HTTPMethod:BoxAPIHTTPMethodGET body:nil queryParams:builder.queryStringParameters OAuth2Session:self.OAuth2Session];
    
    operation.success = ^(NSURLRequest *request, NSHTTPURLResponse *response, NSDictionary *JSONDictionary)
    {
        if (successBlock != nil)
        {
            successBlock([[BoxUser alloc] initWithResponseJSON:JSONDictionary mini:NO]);
        }
    };
    if (failureBlock != nil)
    {
        operation.failure = failureBlock;
    }
    
    [self.queueManager enqueueOperation:operation];
    
    return operation;
}

- (BoxAPIJSONOperation *)userInfos:(NSString *)userID requestBuilder:(BoxUsersRequestBuilder *)builder success:(BoxCollectionBlock)successBlock failure:(BoxAPIJSONFailureBlock)failureBlock
{
    NSURL *URL = [self URLWithResource:@"users" ID:nil subresource:nil subID:nil];
    BoxAPIJSONOperation *operation = [[BoxAPIJSONOperation alloc] initWithURL:URL HTTPMethod:BoxAPIHTTPMethodGET body:builder.bodyParameters queryParams:builder.queryStringParameters OAuth2Session:self.OAuth2Session];
    
    operation.success = ^(NSURLRequest *request, NSHTTPURLResponse *response, NSDictionary *JSONDictionary)
    {
        if (successBlock != nil)
        {
            successBlock([[BoxCollection alloc] initWithResponseJSON:JSONDictionary mini:NO]);
        }
    };
    if (failureBlock != nil)
    {
        operation.failure = failureBlock;
    }
    
    [self.queueManager enqueueOperation:operation];
    
    return operation;
}

- (BoxAPIJSONOperation *)createUserWithRequestBuilder:(BoxUsersRequestBuilder *)builder success:(BoxUserBlock)successBlock failure:(BoxAPIJSONFailureBlock)failureBlock
{
    NSURL *URL = [self URLWithResource:@"users" ID:nil subresource:nil subID:nil];
    BoxAPIJSONOperation *operation = [[BoxAPIJSONOperation alloc] initWithURL:URL HTTPMethod:BoxAPIHTTPMethodPOST body:builder.bodyParameters queryParams:builder.queryStringParameters OAuth2Session:self.OAuth2Session];
    
    operation.success = ^(NSURLRequest *request, NSHTTPURLResponse *response, NSDictionary *JSONDictionary)
    {
        if (successBlock != nil)
        {
            successBlock([[BoxUser alloc] initWithResponseJSON:JSONDictionary mini:NO]);
        }
    };
    if (failureBlock != nil)
    {
        operation.failure = failureBlock;
    }
    
    [self.queueManager enqueueOperation:operation];
    
    return operation;
}

- (BoxAPIJSONOperation *)editUserWithID:(NSString *)userID requestBuilder:(BoxUsersRequestBuilder *)builder success:(BoxUserBlock)successBlock failure:(BoxAPIJSONFailureBlock)failureBlock
{
    NSURL *URL = [self URLWithResource:@"users" ID:userID subresource:nil subID:nil];
    BoxAPIJSONOperation *operation = [[BoxAPIJSONOperation alloc] initWithURL:URL HTTPMethod:BoxAPIHTTPMethodPUT body:builder.bodyParameters queryParams:builder.queryStringParameters OAuth2Session:self.OAuth2Session];
    
    operation.success = ^(NSURLRequest *request, NSHTTPURLResponse *response, NSDictionary *JSONDictionary)
    {
        if (successBlock != nil)
        {
            successBlock([[BoxUser alloc] initWithResponseJSON:JSONDictionary mini:NO]);
        }
    };
    if (failureBlock != nil)
    {
        operation.failure = failureBlock;
    }
    
    [self.queueManager enqueueOperation:operation];
    
    return operation;
}

- (BoxAPIJSONOperation *)deleteUserWithID:(NSString *)userID requestBuilder:(BoxUsersRequestBuilder *)builder success:(BoxSuccessfulDeleteBlock)successBlock failure:(BoxAPIJSONFailureBlock)failureBlock
{
    NSURL *URL = [self URLWithResource:@"users" ID:userID subresource:nil subID:nil];
    BoxAPIJSONOperation *operation = [[BoxAPIJSONOperation alloc] initWithURL:URL HTTPMethod:BoxAPIHTTPMethodDELETE body:nil queryParams:builder.queryStringParameters OAuth2Session:self.OAuth2Session];
    
    operation.success = ^(NSURLRequest *request, NSHTTPURLResponse *response, NSDictionary *JSONDictionary)
    {
        if (successBlock != nil)
        {
            successBlock(userID);
        }
    };
    if (failureBlock != nil)
    {
        operation.failure = failureBlock;
    }
    
    [self.queueManager enqueueOperation:operation];
    
    return operation;
}

@end
