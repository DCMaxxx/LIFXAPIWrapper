//
//  LIFXTargetOperation.m
//  LIFXAPIWrapper
//
//  Created by Maxime de Chalendar on 27/06/2015.
//  Copyright (c) 2015 DCMaxxx. All rights reserved.
//

#import "LIFXTargetOperationResult.h"

@implementation LIFXTargetOperationResult

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    LIFXTargetOperationResult *operation = [super modelWithDictionary:dictionary];
    
    operation.lightIdentifier = dictionary[@"id"];
    operation.lightLabel = dictionary[@"label"];
    operation.status = dictionary[@"status"];
    
    return operation;
}

- (NSDictionary *)toDictionary
{
    return @{@"id": self.lightIdentifier,
             @"label": self.lightLabel,
             @"status": self.status};
}

- (BOOL)isEqual:(id)object
{
    if ([super isEqual:object])
        return YES;
    
    if ([self class] != [object class])
        return NO;
    
    LIFXTargetOperationResult *otherOperation = object;
    return [otherOperation.lightIdentifier isEqualToString:self.lightIdentifier] &&
    [otherOperation.lightLabel isEqualToString:self.lightLabel] &&
    [otherOperation.status isEqualToString:self.status];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"LIFXTargetOperation: Light %@ (%@): %@", self.lightLabel, self.lightIdentifier, self.status];
}

@end
