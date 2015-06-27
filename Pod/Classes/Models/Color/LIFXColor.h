//
//  LIFXColor.h
//  LIFXAPIWrapper
//
//  Created by Maxime de Chalendar on 26/06/2015.
//  Copyright (c) 2015 DCMaxxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LIFXModel.h"

/**
 * @brief A model representing a color of a light
 */
@interface LIFXColor : LIFXModel

/**
 * @brief The hue component of the color
 * @discussion hue range: [0-360]
 */
@property (assign, nonatomic) CGFloat hue;

/**
 * @brief The saturation component of the color
 * @discussion saturation range: [0-1]
 */
@property (assign, nonatomic) CGFloat saturation;

/**
 * @brief The kelvin component of the color
 * @discussion kelvin range: [2500-9000]
 */
@property (assign, nonatomic) NSUInteger kelvin;

@end
