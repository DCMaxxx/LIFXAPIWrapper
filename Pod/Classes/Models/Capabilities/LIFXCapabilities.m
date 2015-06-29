//
//  LIFXCapabilities.m
//  LIFXAPIWrapper
//
//  Created by Maxime de Chalendar on 26/06/2015.
//  Copyright (c) 2015 DCMaxxx. All rights reserved.
//

#import "LIFXCapabilities.h"

@implementation LIFXCapabilities

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    LIFXCapabilities *capabilities = [super modelWithDictionary:dictionary];
    
    capabilities.hasColor = [dictionary[@"has_color"] boolValue];
    capabilities.hasVariableColorTemperature = [dictionary[@"has_variable_color_temp"] boolValue];
    
    return capabilities;
}

- (NSDictionary *)toDictionary
{
    return @{@"has_color": @(self.hasColor),
             @"has_variable_color_temp": @(self.hasVariableColorTemperature)};
}

- (BOOL)isEqual:(id)object
{
    if ([super isEqual:object])
        return YES;
    
    if ([self class] != [object class])
        return NO;
    
    LIFXCapabilities *otherCapabilities = object;
    return otherCapabilities.hasColor == self.hasColor &&
    otherCapabilities.hasVariableColorTemperature == self.hasVariableColorTemperature;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"LIFXCapabilities : hasColors: %@, hasVariableColorTemperature: %@", @(self.hasColor), @(self.hasVariableColorTemperature)];
}

@end
