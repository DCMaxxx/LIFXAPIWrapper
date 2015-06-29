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

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    LIFXTargetOperationUpdate *update = [super modelWithDictionary:dictionary];

    if (dictionary[@"hue"])
        update.hue = [dictionary[@"hue"] integerValue];
    if (dictionary[@"saturation"])
        update.saturation = [dictionary[@"saturation"] doubleValue];
    if (dictionary[@"brightness"])
        update.brightness = [dictionary[@"brightness"] doubleValue];
    if (dictionary[@"kelvin"])
        update.kelvin = [dictionary[@"kelvin"] integerValue];
    if (dictionary[@"string"])
        update.updateString = dictionary[@"string"];
    
    return update;
}

- (NSDictionary *)toDictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    if (self.applyHue)
        dictionary[@"hue"] = @(self.hue);
    if (self.applySaturation)
        dictionary[@"saturation"] = @(self.saturation);
    if (self.applyBrightness)
        dictionary[@"brightness"] = @(self.brightness);
    if (self.applyKelvin)
        dictionary[@"kelvin"] = @(self.kelvin);
    if (self.updateString)
        dictionary[@"string"] = self.updateString;
    
    return [dictionary copy];
}

- (BOOL)isEqual:(id)object
{
    if ([super isEqual:object])
        return YES;
    
    if ([self class] != [object class])
        return NO;
    
    LIFXTargetOperationUpdate *otherOperation = object;
    return ([otherOperation.updateString isEqualToString:self.updateString])
    || ((otherOperation.applyHue == self.applyHue && otherOperation.hue == self.hue)
        && (otherOperation.applySaturation == self.applyBrightness && otherOperation.saturation == self.saturation)
        && (otherOperation.applyBrightness == self.applyBrightness && otherOperation.brightness == self.brightness)
        && (otherOperation.applyKelvin == self.applyKelvin && otherOperation.kelvin == self.kelvin));
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"LIFXTargetOperationUpdate: %@", self.updateString];
}

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

+ (instancetype)updateWithHue:(NSUInteger)hue
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
    if (self.applyHue)              [updateString appendFormat:@"hue:%@",                                               @(self.hue)];
    if (self.applySaturation)       [updateString appendFormat:@"%@saturation:%@",  (updateString.length ? @" " : @""), @(self.saturation)];
    if (self.applyBrightness)       [updateString appendFormat:@"%@brightness:%@",  (updateString.length ? @" " : @""), @(self.brightness)];
    if (self.applyKelvin)           [updateString appendFormat:@"%@kelvin:%@ ",     (updateString.length ? @" " : @""), @(self.kelvin)];
    
    return [updateString copy];
}

- (void)setHue:(NSUInteger)hue
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
