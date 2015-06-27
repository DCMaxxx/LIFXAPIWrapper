//
//  LIFXAPIWrapper.h
//  LIFXAPIWrapper
//
//  Created by Maxime de Chalendar on 26/06/2015.
//  Copyright (c) 2015 DCMaxxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LIFXTargetable.h"
#import "LIFXTargetOperationUpdate.h"

/**
 * @brief A type representing a block that will be called if the API operation fails
 * @discussion Possible error can be found here : http://developer.lifx.com/#errors
 */
typedef void (^LIFXAPIWrapperFailureBlock)(NSError *error);

/**
 * @brief An APIWrapper class that makes requests to the LIFX API
 * @discussion The API wrapper makes calls the the LIFX HTTP API.
 * The API specs are available here : http://developer.lifx.com/
 */
@interface LIFXAPIWrapper : NSObject

/**
 * @brief A singleton LIFXAPIWrapper object
 * @discussion Use this singleton for quick integration of the LIFXAPIWrapper class
 * Of course, you can create your one LIFXAPIWrapper objects using +new
 */
+ (instancetype)sharedAPIWrapper;

/**
 * @brief Sets the OAuth token which will be used in all the API calls
 * @discussion For now, the only way to get an OAuth token is to log on here :
 * https://cloud.lifx.com/settings and request a new token.
 * There is currently no way to authenticate using a username/password combination
 */
- (void)setOAuthToken:(NSString *)OAuthToken;

/**
 * @brief NOT IMPLEMENTED. See -setOAuthToken:
 */
- (void)authenticateWithUsername:(NSString *)username password:(NSString *)password
                    onCompletion:(void (^)())onCompletion
                       onFailure:(LIFXAPIWrapperFailureBlock)onFailure;

/**
 * @brief Get a list of all the lights
 *
 * @param onCompletion A block that will be called if the operation succeeds. 'lights' is an array of LIFXLight
 * @param onFailure A block that will be called it the operation fails
 */
- (void)getAllLightsWithCompletion:(void (^)(NSArray *lights))onCompletion
                         onFailure:(LIFXAPIWrapperFailureBlock)onFailure;

/**
 * @brief Get a list of lights matching a given target
 *
 * @param target The target that will be used to filter the lights
 * @param onCompletion A block that will be called if the operation succeeds. 'lights' is an array of LIFXLight
 * @param onFailure A block that will be called it the operation fails
 */
- (void)getLightsWithTarget:(id<LIFXTargetable>)target
               onCompletion:(void (^)(NSArray *lights))onCompletion
                  onFailure:(LIFXAPIWrapperFailureBlock)onFailure;

/**
 * @brief Toggle a list of lights matching a given target
 *
 * @param target The target that will be used to filter the lights
 * @param onCompletion A block that will be called if the operation succeeds. 'results' is an array of LIFXTargetOperationResult
 * @param onFailure A block that will be called it the operation fails
 */
- (void)toggleLightsWithTarget:(id<LIFXTargetable>)target
                  onCompletion:(void (^)(NSArray *results))onCompletion
                     onFailure:(LIFXAPIWrapperFailureBlock)onFailure;

/**
 * @brief Turn lights matching a given target on
 *
 * @param target The target that will be used to filter the lights
 * @param onCompletion A block that will be called if the operation succeeds. 'results' is an array of LIFXTargetOperationResult
 * @param onFailure A block that will be called it the operation fails
 */
- (void)turnOnLightsWithTarget:(id<LIFXTargetable>)target
                  onCompletion:(void (^)(NSArray *results))onCompletion
                     onFailure:(LIFXAPIWrapperFailureBlock)onFailure;

/**
 * @brief Turn lights matching a given target off
 *
 * @param target The target that will be used to filter the lights
 * @param onCompletion A block that will be called if the operation succeeds. 'results' is an array of LIFXTargetOperationResult
 * @param onFailure A block that will be called it the operation fails
 */
- (void)turnOffLightsWithTarget:(id<LIFXTargetable>)target
                   onCompletion:(void (^)(NSArray *results))onCompletion
                      onFailure:(LIFXAPIWrapperFailureBlock)onFailure;

/**
 * @brief Turn lights matching a given target off or on
 *
 * @param powerStatus Whether the lights should be turned on or off
 * @param target The target that will be used to filter the lights
 * @param onCompletion A block that will be called if the operation succeeds. 'results' is an array of LIFXTargetOperationResult
 * @param onFailure A block that will be called it the operation fails
 */
- (void)changeLightPowerStatus:(BOOL)powerStatus ofTarget:(id<LIFXTargetable>)target
                  onCompletion:(void (^)(NSArray *results))onCompletion
                     onFailure:(LIFXAPIWrapperFailureBlock)onFailure;

/**
 * @brief Apply a given update to lights matching a specific target
 * @discussion See -applyUpdate:overDuration:powerLightsOn:toTarget:onCompletion:onFailure: for more configuration parameters.
 * Default values for the other parameters are available here : http://developer.lifx.com/#set-color
 *
 * @param update The update to apply to the lights
 * @param target The target that will be used to filter the lights
 * @param onCompletion A block that will be called if the operation succeeds. 'results' is an array of LIFXTargetOperationResult
 * @param onFailure A block that will be called it the operation fails
 */
- (void)applyUpdate:(LIFXTargetOperationUpdate *)update toTarget:(id<LIFXTargetable>)target
       onCompletion:(void (^)(NSArray *results))onCompletion
          onFailure:(LIFXAPIWrapperFailureBlock)onFailure;

/**
 * @brief Apply a given update to lights matching a specific target
 *
 * @param update The update to apply to the lights
 * @param duration Fades between the current status and the update over 'duration'
 * @param powerStatus Whether to power on the lights before applying the update or not
 * @param target The target that will be used to filter the lights
 * @param onCompletion A block that will be called if the operation succeeds. 'results' is an array of LIFXTargetOperationResult
 * @param onFailure A block that will be called it the operation fails
 */
- (void)applyUpdate:(LIFXTargetOperationUpdate *)update overDuration:(NSTimeInterval)duration powerLightsOn:(BOOL)powerStatus
           toTarget:(id<LIFXTargetable>)target
       onCompletion:(void (^)(NSArray *results))onCompletion
          onFailure:(LIFXAPIWrapperFailureBlock)onFailure;

@end
