//
//  LIFXColor.m
//  LIFXAPIWrapper
//
//  Created by Maxime de Chalendar on 26/06/2015.
//  Copyright (c) 2015 DCMaxxx. All rights reserved.
//

#import "LIFXColor.h"

@implementation LIFXColor

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    LIFXColor *color = [super modelWithDictionary:dictionary];
    
    color.hue = [dictionary[@"hue"] integerValue];
    color.saturation = [dictionary[@"saturation"] doubleValue];
    color.kelvin = [dictionary[@"kelvin"] integerValue];

    return color;
}

- (NSDictionary *)toDictionary
{
    return @{@"hue": @(self.hue),
             @"saturation": @(self.saturation),
             @"kelvin": @(self.kelvin)};
}

- (BOOL)isEqual:(id)object
{
    if ([super isEqual:object])
        return YES;
    
    if ([self class] != [object class])
        return NO;
    
    LIFXColor *otherColor = object;
    return otherColor.hue == self.hue &&
    otherColor.saturation == self.saturation &&
    otherColor.kelvin == self.kelvin;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"LIFXColor : h:%@, s:%@, k:%@", @(self.hue), @(self.saturation), @(self.kelvin)];
}

@end
