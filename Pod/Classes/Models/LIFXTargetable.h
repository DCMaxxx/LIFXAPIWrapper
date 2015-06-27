//
//  LIFXTargetable.h
//  LIFXAPIWrapper
//
//  Created by Maxime de Chalendar on 27/06/2015.
//  Copyright (c) 2015 DCMaxxx. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * @brief Represents an object that can be changed by the LIFX API
 *
 * @discussion Represents an object that can be turned on / off, or which colors can be changed.
 * Typically, this can be a location, a group or a LIFX light.
 */
@protocol LIFXTargetable <NSObject>


/**
 * @brief A string that will be used by the LIFX API to identify the object
 * @returns The string identifier
 */
- (NSString *)targetSelector;

@end
