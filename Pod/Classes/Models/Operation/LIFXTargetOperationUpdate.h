//
//  LIFXTargetOperationUpdate.h
//  LIFXAPIWrapper
//
//  Created by Maxime de Chalendar on 27/06/2015.
//  Copyright (c) 2015 DCMaxxx. All rights reserved.
//

#import "LIFXModel.h"
#import "LIFXColor.h"

/**
 * @brief A model representing an update that can be applied to a target by the LIFX API
 */
@interface LIFXTargetOperationUpdate : NSObject

/**
 * @brief Creates a new update that will be passed as-is to the LIFX API
 * @discussion Possible values are available here : http://developer.lifx.com/#colors
 * If this method is used to create an update, its hue, saturation, brightness and kelvin
 * properties will be ignored.
 *
 * @param string The string representing the update
 * @return The newly created update
 */
+ (instancetype)updateWithString:(NSString *)string;

/**
 * @brief Creates a new update that will change the color of the target
 *
 * @param color The color to apply to the target
 * @return The newly created update
 */
+ (instancetype)updateWithColor:(LIFXColor *)color;

/**
 * @brief Creates a new update that will change the color as well as the brightness of the target
 *
 * @param color The color to apply to the target
 * @param brightness The brightness to apply to the target. range : [0-1]
 * @return The newly created update
 */
+ (instancetype)updateWithColor:(LIFXColor *)color brightness:(CGFloat)brightness;

/**
 * @brief Creates a new update that will only change the hue of the target
 *
 * @param hue The hue to apply to the target. range : [0-360]
 * @return The newly created update
 */
+ (instancetype)updateWithHue:(CGFloat)hue;

/**
 * @brief Creates a new update that will only change the saturation of the target
 *
 * @param saturation The saturation to apply to the target. range : [0-1]
 * @return The newly created update
 */
+ (instancetype)updateWithSaturation:(CGFloat)saturation;

/**
 * @brief Creates a new update that will only change the brightness of the target
 *
 * @param brightness The brightness to apply to the target. range : [0-1]
 * @return The newly created update
 */
+ (instancetype)updateWithBrightness:(CGFloat)brightness;

/**
 * @brief Creates a new update that will only change the kelvin of the target
 *
 * @param kelvin The kelvin to apply to the target. range : [2500-9000]
 * @return The newly created update
 */
+ (instancetype)updateWithKelvin:(NSUInteger)kelvin;

/**
 * @brief The hue to apply to the target
 */
@property (assign, nonatomic) CGFloat hue;

/**
 * @brief The saturation to apply to the target
 */
@property (assign, nonatomic) CGFloat saturation;

/**
 * @brief The brightness to apply to the target
 */
@property (assign, nonatomic) CGFloat brightness;

/**
 * @brief The kelvin to apply to the target
 */
@property (assign, nonatomic) NSUInteger kelvin;

/**
 * @brief Creates the update string from the receiver values
 * @return The update string to pass to the LIFX API
 */
- (NSString *)updateString;

@end
