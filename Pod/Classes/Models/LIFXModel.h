//
//  LIFXModel.h
//  LIFXAPIWrapper
//
//  Created by Maxime de Chalendar on 26/06/2015.
//  Copyright (c) 2015 DCMaxxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LIFXTargetable.h"

/**
 * @brief A mother class for parsing LIFX API responses
 * @discussion Parses NSDictionary returned by the LIFX API into meaningful,
 * comparable, descriptable models.
 */
@interface LIFXModel : NSObject

/**
 * @brief Creates a model from a NSDictionary
 *
 * @param dictionary The dictionary returned by the LIFX API
 * @return The parsed model
 */
+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary;

/**
 * @brief Creates a new array of models from an array of NSDictionary
 *
 * @param dictionaries The array of NSDictioanry returned by the LIFX API
 * @return The array of parsed models
 */
+ (NSArray *)arrayOfModelsWithDictionaries:(NSArray *)dictionaries;

/**
 * @brief Returns a NSDictionary representing the model, that can be passed back to -modelWithDictionary.
 *
 * @return A new NSDictionary representing the model
 */
- (NSDictionary *)toDictionary;

- (BOOL)isEqual:(id)object;
- (NSString *)description;

@end
