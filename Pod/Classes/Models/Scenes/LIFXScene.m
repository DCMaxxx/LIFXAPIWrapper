//
//  LIFXLight.m
//  LIFXAPIWrapper
//
//  Created by Maxime de Chalendar on 26/06/2015.
//  Copyright (c) 2015 DCMaxxx. All rights reserved.
//

#import "LIFXScene.h"

@implementation LIFXScene

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    LIFXScene *scene = [super modelWithDictionary:dictionary];
    
    scene.name = dictionary[@"name"];

    NSMutableArray *updates = [NSMutableArray new];
    for (NSDictionary *update in dictionary[@"devices"])
        [updates addObject:[LIFXSceneUpdate modelWithDictionary:update]];
    scene.updates = [updates copy];
    
    scene.uuid = dictionary[@"uuid"];
    scene.account = [LIFXSceneAccount modelWithDictionary:dictionary[@"account"]];
    
    scene.createdAt = [NSDate dateWithTimeIntervalSince1970:[dictionary[@"created_at"] doubleValue]];
    scene.updatedAt = [NSDate dateWithTimeIntervalSince1970:[dictionary[@"updated_at"] doubleValue]];

    return scene;
}

- (NSDictionary *)toDictionary
{
    NSMutableArray *rawUpdates = [NSMutableArray new];
    for (LIFXSceneUpdate *update in self.updates)
        [rawUpdates addObject:[update toDictionary]];

    return @{@"name": self.name,
             @"devices": [rawUpdates copy],
             @"uuid": self.uuid,
             @"account": [self.account toDictionary] ?: @{},
             @"created_at": @([self.createdAt timeIntervalSince1970]),
             @"updated_at": @([self.updatedAt timeIntervalSince1970])};
}

- (BOOL)isEqual:(id)object
{
    if ([super isEqual:object])
        return YES;
    
    if ([self class] != [object class])
        return NO;
    
    LIFXScene *otherScene = object;
    return [otherScene.uuid isEqualToString:self.uuid];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"LIFXScene : %@ (%@)", self.name, self.uuid];
}

@end
