//
//  LIFXCapabilities.h
//  LIFXAPIWrapper
//
//  Created by Maxime de Chalendar on 26/06/2015.
//  Copyright (c) 2015 DCMaxxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LIFXModel.h"

/**
 * @brief A model representing the capabilities of a light
 * @disucssion Capabilities can be used to determined wheter or not some options are available
 */
@interface LIFXCapabilities : LIFXModel

/**
 * @brief Whether the light supports color changes
 */
@property (assign, nonatomic) BOOL hasColor;

/**
 * @brief Whether the light supports color temperature changes
 */
@property (assign, nonatomic) BOOL hasVariableColorTemperature;

@end
