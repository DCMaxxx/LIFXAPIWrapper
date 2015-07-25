//
//  LIFXLight.m
//  LIFXAPIWrapper
//
//  Created by Maxime de Chalendar on 26/06/2015.
//  Copyright (c) 2015 DCMaxxx. All rights reserved.
//

#import "LIFXScene.h"

@implementation LIFXSceneAccount

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    LIFXSceneAccount *account = [super modelWithDictionary:dictionary];
    
    account.uuid = dictionary[@"uuid"];
    
    return account;
}

- (NSDictionary *)toDictionary
{
    return @{@"uuid": self.uuid};
}

- (BOOL)isEqual:(id)object
{
    if ([super isEqual:object])
        return YES;
    
    if ([self class] != [object class])
        return NO;
    
    LIFXSceneAccount *otherAccount = object;
    return [otherAccount.uuid isEqualToString:self.uuid];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"LIFXSceneAccount : %@", self.uuid];
}

@end
