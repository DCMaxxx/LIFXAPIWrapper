//
//  LIFXTargetOperationUpdate.m
//  LIFXAPIWrapper
//
//  Created by Maxime de Chalendar on 27/06/2015.
//  Copyright (c) 2015 DCMaxxx. All rights reserved.
//

#import "LIFXTargetOperationUpdate.h"

@interface LIFXTargetOperationUpdate ()

@property (strong, nonatomic) NSString *updateString;

@property (assign, nonatomic) BOOL applyHue;
@property (assign, nonatomic) BOOL applySaturation;
@property (assign, nonatomic) BOOL applyBrightness;
@property (assign, nonatomic) BOOL applyKelvin;

@end

@implementation LIFXTargetOperationUpdate

+ (instancetype)updateWithString:(NSString *)string
{
    LIFXTargetOperationUpdate *update = [self new];
    update.updateString = string;
    return update;
}

+ (instancetype)updateWithColor:(LIFXColor *)color
{
    LIFXTargetOperationUpdate *update = [self new];
    update.hue = color.hue;
    update.saturation = color.saturation;
    update.kelvin = color.kelvin;
    return update;
}

+ (instancetype)updateWithColor:(LIFXColor *)color brightness:(CGFloat)brightness
{
    LIFXTargetOperationUpdate *update = [self updateWithColor:color];
    update.brightness = brightness;
    return update;
}

+ (instancetype)updateWithHue:(CGFloat)hue
{
    LIFXTargetOperationUpdate *update = [self new];
    update.hue = hue;
    return update;
}

+ (instancetype)updateWithSaturation:(CGFloat)saturation
{
    LIFXTargetOperationUpdate *update = [self new];
    update.saturation = saturation;
    return update;
}

+ (instancetype)updateWithBrightness:(CGFloat)brightness
{
    LIFXTargetOperationUpdate *update = [self new];
    update.brightness = brightness;
    return update;
}

+ (instancetype)updateWithKelvin:(NSUInteger)kelvin
{
    LIFXTargetOperationUpdate *update = [self new];
    update.kelvin = kelvin;
    return update;
}

- (NSString *)updateString
{
    if (_updateString)
        return _updateString;
    
    NSMutableString *updateString = [NSMutableString new];
    if (self.applyHue)          [updateString appendFormat:@" hue:%@",          @(self.hue)];
    if (self.applySaturation)   [updateString appendFormat:@" saturation:%@",   @(self.saturation)];
    if (self.applyBrightness)   [updateString appendFormat:@" brightness:%@",   @(self.brightness)];
    if (self.applyKelvin)       [updateString appendFormat:@" kelvin:%@ ",      @(self.kelvin)];
    
    return [updateString copy];
}

- (void)setHue:(CGFloat)hue
{
    _hue = hue;
    self.applyHue = YES;
}

- (void)setSaturation:(CGFloat)saturation
{
    _saturation = saturation;
    self.applySaturation = YES;
}

- (void)setBrightness:(CGFloat)brightness
{
    _brightness = brightness;
    self.applyBrightness = YES;
}

- (void)setKelvin:(NSUInteger)kelvin
{
    _kelvin = kelvin;
    self.applyKelvin = YES;
}

@end
