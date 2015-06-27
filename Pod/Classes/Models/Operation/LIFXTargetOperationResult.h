//
//  LIFXTargetOperation.h
//  LIFXAPIWrapper
//
//  Created by Maxime de Chalendar on 27/06/2015.
//  Copyright (c) 2015 DCMaxxx. All rights reserved.
//

#import "LIFXModel.h"

/**
 * @brief A model representing the status of a light update operation
 * @discussion When updating the color of a light, or changing its power state
 * a LIFXTargetOperation is returned.
 */
@interface LIFXTargetOperationResult : LIFXModel

/**
 * @brief The identifier of the light affected by the operation
 */
@property (strong, nonatomic) NSString *lightIdentifier;

/**
 * @brief The label of the light affected by the operation
 */
@property (strong, nonatomic) NSString *lightLabel;

/**
 * @brief The status of the operation
 * @discussion Possible values can be found here : http://developer.lifx.com/#reachability
 */
@property (strong, nonatomic) NSString *status;

@end
