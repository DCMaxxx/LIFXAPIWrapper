//
//  LIFXLight.h
//  LIFXAPIWrapper
//
//  Created by Maxime de Chalendar on 26/06/2015.
//  Copyright (c) 2015 DCMaxxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LIFXModel.h"
#import "LIFXColor.h"
#import "LIFXGroup.h"
#import "LIFXCapabilities.h"

/**
 * @brief A model representing a light
 */
@interface LIFXLight : LIFXModel <LIFXTargetable>

/**
 * @brief The location of the light : Home, work, etc.
 */
@property (strong, nonatomic) LIFXGroup *location;

/**
 * @brief The group of the light : Kitche, Bed room, etc.
 */
@property (strong, nonatomic) LIFXGroup *group;

/**
 * @brief The name of the light
 */
@property (strong, nonatomic) NSString *label;

/**
 * @brief Wheter the light is connected to the WiFi or not
 */
@property (assign, nonatomic, getter=isConnected) BOOL connected;

/**
 * @brief Wheter the light status is on or not
 */
@property (assign, nonatomic, getter=isOn) BOOL on;

/**
 * @brief The color of the light
 */
@property (strong, nonatomic) LIFXColor *color;

/**
 * @brief The brightness of the light
 * @discussion brightness range is [0-1]
 */
@property (assign, nonatomic) CGFloat brightness;

/**
 * @brief The light API identifier
 */
@property (strong, nonatomic) NSString *identifier;

/**
 * @brief The light unique identifier
 */
@property (strong, nonatomic) NSString *uuid;

/**
 * @brief The light product name
 */
@property (strong, nonatomic) NSString *productName;

/**
 * @brief The light capabilities
 */
@property (strong, nonatomic) LIFXCapabilities *capabilities;

/**
 * @brief The last time the light was connected
 */
@property (strong, nonatomic) NSDate *lastSeen;

/**
 * @brief The number of seconds since the light was connected
 */
@property (assign, nonatomic) CGFloat secondsSinceSeen;

/**
 * @brief Converts a power status API string to a boolean
 * @param powerState The string representing the status, returned by the API
 * @return A boolean value representing the power state
 */
+ (BOOL)powerStateStringToPowerStatus:(NSString *)powerState;

/**
 * @brief Converts a boolean status to a status string usable by the LIFX API
 * @param powerStatus The power state
 * @return A string representing the power state
 */
+ (NSString *)powerStateStringFromPowerStatus:(BOOL)powerStatus;

@end
