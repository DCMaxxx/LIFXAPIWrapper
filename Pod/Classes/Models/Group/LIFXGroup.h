//
//  LIFXGroup.h
//  LIFXAPIWrapper
//
//  Created by Maxime de Chalendar on 26/06/2015.
//  Copyright (c) 2015 DCMaxxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LIFXModel.h"

/**
 * @brief A mother class for handling LIFX groups
 * @discussion A group represents a targetable set of lights or sub-groups
 */
@interface LIFXBaseGroup : LIFXModel <LIFXTargetable>

/**
 * @brief The identifier of the group
 */
@property (strong, nonatomic) NSString *identifier;

/**
 * @brief The name of the group
 */
@property (strong, nonatomic) NSString *name;

@end


/**
 * @brief A group subclass representing a location (i.e. a set of groups)
 */
@interface LIFXLocation : LIFXBaseGroup
@end


/**
 * @brief A groupd subclass representing a group (i.e. a set of lights)
 */
@interface LIFXGroup : LIFXBaseGroup
@end
