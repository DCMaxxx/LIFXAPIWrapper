//
//  LightViewController.h
//  LIFXAPIWrapper
//
//  Created by Maxime de Chalendar on 27/06/2015.
//  Copyright (c) 2015 Maxime de Chalendar. All rights reserved.
//

@import UIKit;
#import <LIFXTargetable.h>

@interface TargetViewController : UIViewController

@property (strong, nonatomic) id<LIFXTargetable> target;

@end
