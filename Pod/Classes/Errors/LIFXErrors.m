//
//  LIFXErrors.m
//  LIFXAPIWrapper
//
//  Created by Maxime de Chalendar on 27/06/2015.
//  Copyright (c) 2015 DCMaxxx. All rights reserved.
//

#import "LIFXErrors.h"

NSString * const LIFXAPIErrorDomain = @"com.maxime-dechalendar.LIFXAPIWrapper";
NSString * const LIFXAPIErrorUserInfoKeyJSONResponse = @"com.maxime-dechalendar.LIFXAPIWrapper.userInfos.JSONResponse";

BOOL LIFXAPIErrorCodeIsUnknown(LIFXAPIErrorCode errorCode)
{
    LIFXAPIErrorCode errorCodes[] = {
        LIFXAPIErrorCodeBadToken, LIFXAPIErrorCodeTargetNotFound, LIFXAPIErrorCodeUnreachable,
        LIFXAPIErrorCodeMalformedRequest, LIFXAPIErrorCodeRateLimitExceeded
    };
    
    if (LIFXAPIErrorCodeIsServerFailure(errorCode))
        return NO;
    
    for (NSUInteger idx = 0; idx < sizeof(errorCodes) / sizeof(errorCodes[0]); ++idx)
        if (errorCodes[idx] == errorCode)
            return NO;
    
    return YES;
}

BOOL LIFXAPIErrorCodeIsServerFailure(LIFXAPIErrorCode errorCode)
{
    return errorCode >= LIFXAPIErrorCodeServerFailure;
}

NSString *defaultErrorDescriptionFromCode(LIFXAPIErrorCode errorCode)
{
    switch (errorCode)
    {
        case LIFXAPIErrorCodeBadToken:
            return @"OAuthToken is invalid";
            
        case LIFXAPIErrorCodeTargetNotFound:
            return @"Requested target was not found";
            
        case LIFXAPIErrorCodeUnreachable:
            return @"Requested target is unreachable";
            
        case LIFXAPIErrorCodeMalformedRequest:
            return @"Request was malformed";
            
        case LIFXAPIErrorCodeRateLimitExceeded:
            return @"Requests limit exceeded";
            
        default:
            if (LIFXAPIErrorCodeIsServerFailure(errorCode))
                return @"A server-side error occured";
            else
                return @"An unknown error occured";
    }
}