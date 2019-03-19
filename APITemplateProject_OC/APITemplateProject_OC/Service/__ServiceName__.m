//
//  __ServiceName__.m
//  APITemplateProject_OC
//
//  Created by casa on 2019/3/18.
//  Copyright © 2019 casa. All rights reserved.
//

#import "__ServiceName__.h"

NSString * const kServiceIdentifier__ServiceName__ = @"__ServiceName__";

@interface __ServiceName__ ()

@property (nonatomic, strong, readonly) NSURL *baseURL;
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation __ServiceName__

#pragma mark - CTServiceProtocol
- (NSURLRequest *)requestWithParams:(NSDictionary *)params methodName:(NSString *)methodName requestType:(CTAPIManagerRequestType)requestType {
    return nil;
}

- (NSDictionary *)resultWithResponseObject:(id)responseObject response:(NSURLResponse *)response request:(NSURLRequest *)request error:(NSError *__autoreleasing *)error {
    return nil;
}

- (BOOL)handleCommonErrorWithResponse:(CTURLResponse *)response manager:(CTAPIBaseManager *)manager errorType:(CTAPIManagerErrorType)errorType {
    return YES;
}

#pragma mark - getters and setters
- (AFHTTPSessionManager *)sessionManager
{
    if (_sessionManager == nil) {
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:self.baseURL];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    }
    return _sessionManager;
}

- (NSURL *)baseURL
{
    NSURL *result = nil;
    if (self.apiEnvironment == CTServiceAPIEnvironmentRelease) {
        result = [NSURL URLWithString:@"__ReleaseBaseURL__"];
    }
    if (self.apiEnvironment == CTServiceAPIEnvironmentDevelop) {
        result = [NSURL URLWithString:@"__DevelopBaseURL__"];
    }
    if (self.apiEnvironment == CTServiceAPIEnvironmentReleaseCandidate) {
        result = [NSURL URLWithString:@"__ReleaseCandidateBaseURL__"];
    }
    return result;
}

@end
