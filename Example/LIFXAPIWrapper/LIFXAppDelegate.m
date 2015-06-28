//
//  LIFXAppDelegate.m
//  LIFXAPIWrapper
//
//  Created by CocoaPods on 06/27/2015.
//  Copyright (c) 2014 Maxime de Chalendar. All rights reserved.
//

#import "LIFXAppDelegate.h"
#import <LIFXAPIWrapper.h>

static NSString * const LIFXAPIOAuthToken = @"your-oauth-token";

@implementation LIFXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[LIFXAPIWrapper sharedAPIWrapper] setOAuthToken:LIFXAPIOAuthToken];

    return YES;
}

@end
