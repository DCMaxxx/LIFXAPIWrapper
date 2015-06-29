//
//  LIFXLight.m
//  LIFXAPIWrapper
//
//  Created by Maxime de Chalendar on 26/06/2015.
//  Copyright (c) 2015 DCMaxxx. All rights reserved.
//

#import "LIFXLight.h"

static NSString * const LIFXLightDateFormat = @"yyyy-MM-dd'T'HH:mm.ss.SSZZ";

@implementation LIFXLight

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    LIFXLight *light = [super modelWithDictionary:dictionary];
    
    light.location = [LIFXLocation modelWithDictionary:dictionary[@"location"]];
    light.group = [LIFXGroup modelWithDictionary:dictionary[@"group"]];
    light.label = dictionary[@"label"];
    
    light.connected = [dictionary[@"connected"] boolValue];
    light.on = [self powerStateStringToPowerStatus:dictionary[@"power"]];
    
    light.color = [LIFXColor modelWithDictionary:dictionary[@"color"]];
    light.brightness = [dictionary[@"brightness"] doubleValue];
    
    light.identifier = dictionary[@"id"];
    light.uuid = dictionary[@"uuid"];
    
    light.productName = dictionary[@"product_name"];
    light.capabilities = [LIFXCapabilities modelWithDictionary:dictionary[@"capabilities"]];

    NSDateFormatter *dateFormatter = [self LIFXDateFormatter];
    light.lastSeen = [dateFormatter dateFromString:dictionary[@"last_seen"]];
    light.secondsSinceSeen = [dictionary[@"seconds_since_seen"] doubleValue];

    return light;
}

- (NSDictionary *)toDictionary
{
    return @{@"location": self.location ? [self.location toDictionary] : @{},
             @"group": self.group ? [self.group toDictionary] : @{},
             @"label": self.label,
             @"connected": @(self.isConnected),
             @"power": @(self.isOn),
             @"color": self.color ? [self.color toDictionary] : @{},
             @"brightness": @(self.brightness),
             @"identifier": self.identifier,
             @"uuid": self.uuid,
             @"product_name": self.productName,
             @"capabilities": self.capabilities ? [self.capabilities toDictionary] : @{},
             @"last_seen": [[LIFXLight LIFXDateFormatter] stringFromDate:self.lastSeen],
             @"seconds_since_seen": @(self.secondsSinceSeen)};
}

- (BOOL)isEqual:(id)object
{
    if ([super isEqual:object])
        return YES;
    
    if ([self class] != [object class])
        return NO;
    
    LIFXLight *otherLight = object;
    return [otherLight.uuid isEqualToString:self.uuid];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"LIFXLight : %@ (%@)", self.label, self.uuid];
}

- (NSString *)targetSelector
{
    return [NSString stringWithFormat:@"id:%@", self.identifier];
}

+ (BOOL)powerStateStringToPowerStatus:(NSString *)powerState
{
    return [powerState isEqualToString:@"on"];
    
}

+ (NSString *)powerStateStringFromPowerStatus:(BOOL)powerStatus
{
    return powerStatus ? @"on" : @"off";
}

#pragma mark - Convenience methods

+ (NSDateFormatter *)LIFXDateFormatter
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = LIFXLightDateFormat;
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    return dateFormatter;
}

@end
