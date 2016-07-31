//
//  LIFXAPIWrapper.m
//  LIFXAPIWrapper
//
//  Created by Maxime de Chalendar on 26/06/2015.
//  Copyright (c) 2015 DCMaxxx. All rights reserved.
//

#import "AFNetworking.h"
#import "LIFXAPIWrapper.h"
#import "LIFXLight.h"
#import "LIFXScene.h"
#import "LIFXTargetOperationResult.h"
#import "LIFXErrors.h"

#define DefaultLIFXAPIWrapperFailureBlock ^(NSURLSessionDataTask *task, NSError *error) \
                                          { if (onFailure) onFailure([self errorFromNetworkError:error]); }

static NSString * const LIFXAPIBaseURL = @"https://api.lifx.com/v1beta1/";

@interface LIFXAPIWrapper ()

@property (strong, nonatomic) AFHTTPSessionManager *manager;

@end

@implementation LIFXAPIWrapper

+ (instancetype)sharedAPIWrapper
{
    static LIFXAPIWrapper *APIWrapper;

    static dispatch_once_t APIWrapperToken;
    dispatch_once(&APIWrapperToken, ^{
        APIWrapper = [LIFXAPIWrapper new];
    });
    
    return APIWrapper;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:LIFXAPIBaseURL]];
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    return self;
}

- (void)setOAuthToken:(NSString *)OAuthToken
{
    [self.manager.requestSerializer setAuthorizationHeaderFieldWithUsername:OAuthToken password:@""];
}

- (void)authenticateWithUsername:(NSString *)username password:(NSString *)password
                    onCompletion:(void (^)())onCompletion
                       onFailure:(LIFXAPIWrapperFailureBlock)onFailure
{
    // This is not implemented yet.
}

- (void)getAllLightsWithCompletion:(void (^)(NSArray *lights))onCompletion
                         onFailure:(LIFXAPIWrapperFailureBlock)onFailure
{
    [self.manager GET:[self escapedLightTargetSelector:nil] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (onCompletion)
            onCompletion([LIFXLight arrayOfModelsWithDictionaries:[self arrayWrappedResponse:responseObject]]);
    } failure:DefaultLIFXAPIWrapperFailureBlock];
}

- (void)getLightsWithTarget:(id<LIFXTargetable>)target
               onCompletion:(void (^)(NSArray *lights))onCompletion
                  onFailure:(LIFXAPIWrapperFailureBlock)onFailure
{
    [self.manager GET:[self escapedLightTargetSelector:target] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (onCompletion)
            onCompletion([LIFXLight arrayOfModelsWithDictionaries:[self arrayWrappedResponse:responseObject]]);
    } failure:DefaultLIFXAPIWrapperFailureBlock];
}

- (void)getScenesWithCompletion:(void (^)(NSArray *))onCompletion onFailure:(LIFXAPIWrapperFailureBlock)onFailure
{
    [self.manager GET:@"scenes/" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (onCompletion)
            onCompletion([LIFXScene arrayOfModelsWithDictionaries:[self arrayWrappedResponse:responseObject]]);
    } failure:DefaultLIFXAPIWrapperFailureBlock];
}

- (void)applyScene:(LIFXScene *)scene
      onCompletion:(void (^)(NSArray *results))onCompletion
         onFailure:(LIFXAPIWrapperFailureBlock)onFailure
{
    [self.manager PUT:[self escapedSceneSelector:scene] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (onCompletion)
            onCompletion([LIFXTargetOperationResult arrayOfModelsWithDictionaries:[self arrayWrappedResponse:responseObject]]);
    } failure:DefaultLIFXAPIWrapperFailureBlock];
}

- (void)toggleLightsWithTarget:(id<LIFXTargetable>)target
                  onCompletion:(void (^)(NSArray *results))onCompletion
                     onFailure:(LIFXAPIWrapperFailureBlock)onFailure
{
    [self.manager POST:[self escaptedLightTargetSelector:target withAction:@"toggle"] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (onCompletion)
            onCompletion([LIFXTargetOperationResult arrayOfModelsWithDictionaries:[self arrayWrappedResponse:responseObject]]);
    } failure:DefaultLIFXAPIWrapperFailureBlock];
}

- (void)turnOnLightsWithTarget:(id<LIFXTargetable>)target
                  onCompletion:(void (^)(NSArray *results))onCompletion
                     onFailure:(LIFXAPIWrapperFailureBlock)onFailure
{
    [self changeLightPowerStatus:YES ofTarget:target onCompletion:onCompletion onFailure:onFailure];
}

- (void)turnOffLightsWithTarget:(id<LIFXTargetable>)target
                   onCompletion:(void (^)(NSArray *results))onCompletion
                      onFailure:(LIFXAPIWrapperFailureBlock)onFailure
{
    [self changeLightPowerStatus:NO ofTarget:target onCompletion:onCompletion onFailure:onFailure];
}

- (void)changeLightPowerStatus:(BOOL)powerStatus ofTarget:(id<LIFXTargetable>)target
                  onCompletion:(void (^)(NSArray *results))onCompletion
                     onFailure:(LIFXAPIWrapperFailureBlock)onFailure
{
    NSDictionary *parameters = @{@"state": [LIFXLight powerStateStringFromPowerStatus:powerStatus]};
    [self.manager PUT:[self escaptedLightTargetSelector:target withAction:@"power"] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (onCompletion)
            onCompletion([LIFXTargetOperationResult arrayOfModelsWithDictionaries:[self arrayWrappedResponse:responseObject]]);
    } failure:DefaultLIFXAPIWrapperFailureBlock];
}

- (void)applyUpdate:(LIFXTargetOperationUpdate *)update toTarget:(id<LIFXTargetable>)target
       onCompletion:(void (^)(NSArray *results))onCompletion
          onFailure:(LIFXAPIWrapperFailureBlock)onFailure
{
    NSDictionary *parameters = @{@"color": [update updateString]};
    [self applyUpdateWithTarget:target parameters:parameters onCompletion:onCompletion onFailure:onFailure];
}

- (void)applyUpdate:(LIFXTargetOperationUpdate *)update overDuration:(NSTimeInterval)duration powerLightsOn:(BOOL)powerStatus
           toTarget:(id<LIFXTargetable>)target
       onCompletion:(void (^)(NSArray *results))onCompletion
          onFailure:(LIFXAPIWrapperFailureBlock)onFailure
{
    NSDictionary *parameters = @{@"color": [update updateString],
                                 @"duration": @(duration),
                                 @"power_on": [self booleanStringFromBoolean:powerStatus]};
    [self applyUpdateWithTarget:target parameters:parameters onCompletion:onCompletion onFailure:onFailure];
}

- (void)applyUpdateWithTarget:(id<LIFXTargetable>)target parameters:(NSDictionary *)parameters
                 onCompletion:(void (^)(NSArray *results))onCompletion
                    onFailure:(LIFXAPIWrapperFailureBlock)onFailure

{
    [self.manager PUT:[self escaptedLightTargetSelector:target withAction:@"color"] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (onCompletion)
            onCompletion([LIFXTargetOperationResult arrayOfModelsWithDictionaries:[self arrayWrappedResponse:responseObject]]);
    } failure:DefaultLIFXAPIWrapperFailureBlock];
}

#pragma mark - Convenience methods

- (NSArray *)arrayWrappedResponse:(id)response
{
    if ([response isKindOfClass:[NSArray class]])
        return response;
    else
        return @[response];
}

- (NSString *)escapedLightTargetSelector:(id<LIFXTargetable>)target
{
    return [self escaptedLightTargetSelector:target withAction:nil];
}

- (NSString *)escaptedLightTargetSelector:(id<LIFXTargetable>)target withAction:(NSString *)action
{
    NSString *lightsPath = @"lights/";
    NSString *targetSelector = [lightsPath stringByAppendingString:[target targetSelector] ?: @"all"];
    if (action.length > 0)
        targetSelector = [targetSelector stringByAppendingFormat:@"/%@", action];
        
    return [targetSelector stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
}

- (NSString *)escapedSceneSelector:(LIFXScene *)scene
{
    return [NSString stringWithFormat:@"scenes/scene_id:%@/activate", scene.uuid];
}

- (NSString *)booleanStringFromBoolean:(BOOL)boolean
{
    return boolean ? @"true" : @"false";
}

- (NSError *)errorFromNetworkError:(NSError *)networkError
{
    NSHTTPURLResponse *failedResponse = networkError.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
    NSDictionary *failedJSONResponse = [NSJSONSerialization JSONObjectWithData:networkError.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:0 error:nil]; // We don't really care about JSON parsing here.
    NSUInteger code = failedResponse.statusCode;

    NSDictionary *userInfos = @{NSLocalizedDescriptionKey: failedJSONResponse[@"message"] ?: defaultErrorDescriptionFromCode(code),
                                LIFXAPIErrorUserInfoKeyJSONResponse: failedJSONResponse ?: @{}};
    
    NSError *error = [NSError errorWithDomain:LIFXAPIErrorDomain code:code userInfo:userInfos];
    return error;
}


@end
