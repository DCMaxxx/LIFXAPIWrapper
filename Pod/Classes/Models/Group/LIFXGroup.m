//
//  LIFXGroup.m
//  LIFXAPIWrapper
//
//  Created by Maxime de Chalendar on 26/06/2015.
//  Copyright (c) 2015 DCMaxxx. All rights reserved.
//

#import "LIFXGroup.h"

@implementation LIFXBaseGroup

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    LIFXBaseGroup *group = [super modelWithDictionary:dictionary];
    
    group.identifier = dictionary[@"id"];
    group.name = dictionary[@"name"];
    
    return group;
}

- (NSDictionary *)toDictionary
{
    return @{@"id": self.identifier,
             @"name": self.name};
}

- (BOOL)isEqual:(id)object
{
    if ([super isEqual:object])
        return YES;
    
    if ([self class] != [object class])
        return NO;
    
    LIFXGroup *otherGroup = object;
    return [otherGroup.identifier isEqualToString:self.identifier];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"LIFXBaseGroup : %@ (%@)", self.name, self.identifier];
}

- (NSString *)targetSelector { return @""; }

@end

@implementation LIFXGroup

- (NSString *)targetSelector
{
    return [NSString stringWithFormat:@"group_id:%@", self.identifier];
}

@end

@implementation LIFXLocation

- (NSString *)targetSelector
{
    return [NSString stringWithFormat:@"location_id:%@", self.identifier];
}

@end
