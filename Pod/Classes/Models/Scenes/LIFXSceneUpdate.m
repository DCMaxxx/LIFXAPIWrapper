//
//  LIFXLight.m
//  LIFXAPIWrapper
//
//  Created by Maxime de Chalendar on 26/06/2015.
//  Copyright (c) 2015 DCMaxxx. All rights reserved.
//

#import "LIFXScene.h"
#import "LIFXLight.h"

@implementation LIFXSceneUpdate

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    LIFXSceneUpdate *update = [super modelWithDictionary:dictionary];
    
    update.color = [LIFXColor modelWithDictionary:dictionary[@"color"]];
    update.brightness = [dictionary[@"brightness"] doubleValue];

    update.on = [LIFXLight powerStateStringToPowerStatus:dictionary[@"power"]];
    
    update.serialNumber = dictionary[@"serial_number"];
    
    return update;
}

- (NSDictionary *)toDictionary
{
    return @{@"color": self.color.toDictionary ?: @{},
             @"brightness": @(self.brightness),
             @"power": [LIFXLight powerStateStringFromPowerStatus:self.isOn],
             @"serial_number": self.serialNumber};
}

- (BOOL)isEqual:(id)object
{
    if ([super isEqual:object])
        return YES;
    
    if ([self class] != [object class])
        return NO;
    
    LIFXSceneUpdate *otherUpdate = object;
    return [otherUpdate.color isEqual:self.color]
    && otherUpdate.brightness == self.brightness
    && otherUpdate.isOn == self.isOn
    && [otherUpdate.serialNumber isEqualToString:self.serialNumber];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"LIFXSceneUpdate : (%@, brightness: %@, on: %@) on %@",
            self.color, @(self.brightness), @(self.isOn), self.serialNumber];
}

@end
