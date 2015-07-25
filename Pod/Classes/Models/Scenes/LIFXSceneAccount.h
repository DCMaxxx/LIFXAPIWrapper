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

/**
 * @brief A model representing the account of a scene
 * @discussion
 * No idea what this is for.
 See: http://api.developer.lifx.com/docs/list-scenes
 */
@interface LIFXSceneAccount : LIFXModel

@property (strong, nonatomic) NSString *uuid;

@end
