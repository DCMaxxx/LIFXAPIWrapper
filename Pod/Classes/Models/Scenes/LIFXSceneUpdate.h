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

/**
 * @brief A model representing a single step of scene
 */
@interface LIFXSceneUpdate : LIFXModel

/**
 * @brief The new color of the update
 */
@property (strong, nonatomic) LIFXColor *color;

/**
 * @brief The brightness of the update
 */
@property (assign, nonatomic) CGFloat brightness;

/**
 * @brief The power status of the update
 */
@property (assign, nonatomic, getter=isOn) BOOL on;

/**
 * @brief The serial number to apply this update to
 */
@property (strong, nonatomic) NSString *serialNumber;

@end

