//
//  LIFXModel.m
//  LIFXAPIWrapper
//
//  Created by Maxime de Chalendar on 26/06/2015.
//  Copyright (c) 2015 DCMaxxx. All rights reserved.
//

#import "LIFXModel.h"

@implementation LIFXModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    return [self new];
}

+ (NSArray *)arrayOfModelsWithDictionaries:(NSArray *)dictionaries
{
    NSMutableArray *models = [NSMutableArray new];
    for (NSDictionary *dictionary in dictionaries)
        [models addObject:[self modelWithDictionary:dictionary]];
    return [models copy];
}

- (BOOL)isEqual:(id)object
{
    return object == self;
}

- (NSString *)description
{
    return @"LIFXModel";
}

@end
