//
//  LIFXLight.h
//  LIFXAPIWrapper
//
//  Created by Maxime de Chalendar on 26/06/2015.
//  Copyright (c) 2015 DCMaxxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LIFXModel.h"
#import "LIFXSceneUpdate.h"
#import "LIFXSceneAccount.h"
#import "LIFXColor.h"

/**
 * @brief A model representing a scene
 */
@interface LIFXScene : LIFXModel

/**
 * @brief The name of the scene
 */
@property (strong, nonatomic) NSString *name;

/**
 * @brief An array of updates that will be applied to targets
 */
@property (strong, nonatomic) NSArray *updates;

/**
 * @brief The identifier of the scene
 */
@property (strong, nonatomic) NSString *uuid;

/**
 * @brief The account of the scene
 */
@property (strong, nonatomic) LIFXSceneAccount *account;

/**
 * @brief The date when the scene was created
 */
@property (strong, nonatomic) NSDate *createdAt;

/**
 * @brief The date when the scene was last updated
 */
@property (strong, nonatomic) NSDate *updatedAt;

@end
