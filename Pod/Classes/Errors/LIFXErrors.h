//
//  LIFXErrors.h
//  LIFXAPIWrapper
//
//  Created by Maxime de Chalendar on 27/06/2015.
//  Copyright (c) 2015 DCMaxxx. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * @brief The domain used in the LIFXAPIWrapper
 */
FOUNDATION_EXPORT NSString * const LIFXAPIErrorDomain;

/**
 * @brief The userInfo key for the JSON response on a failed request
 */
FOUNDATION_EXPORT NSString * const LIFXAPIErrorUserInfoKeyJSONResponse;

/**
 * @brief The possible error codes returned by the LIFX API
 */
typedef NS_ENUM(NSUInteger, LIFXAPIErrorCode) {
    /// Bad access token
    LIFXAPIErrorCodeBadToken            = 401,
    /// Selector is malformed or did not match any lights
    LIFXAPIErrorCodeTargetNotFound      = 404,
    /// One light may be physically powered off or unreachable
    LIFXAPIErrorCodeUnreachable         = 408,
    /// Missing or malformed parameters
    LIFXAPIErrorCodeMalformedRequest    = 422,
    /// The request exceeded a rate limit
    LIFXAPIErrorCodeRateLimitExceeded   = 429,
    /// Something went wrong on LIFX's end
    LIFXAPIErrorCodeServerFailure       = 500 // And above
};

/**
 * @brief Verifies if the error code matches a server failure error code
 */
BOOL LIFXAPIErrorCodeIsServerFailure(LIFXAPIErrorCode errorCode);

/**
 * @brief Verifies if the error code doesn't match any of the error codes in LIFXAPIErrorCode
 */
BOOL LIFXAPIErrorCodeIsUnknown(LIFXAPIErrorCode errorCode);

/**
 * @brief Returns a string representing the error from the error code
 */
NSString *defaultErrorDescriptionFromCode(LIFXAPIErrorCode errorCode);
