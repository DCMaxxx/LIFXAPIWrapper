//
//  LightViewController.m
//  LIFXAPIWrapper
//
//  Created by Maxime de Chalendar on 27/06/2015.
//  Copyright (c) 2015 Maxime de Chalendar. All rights reserved.
//

#import "TargetViewController.h"
#import <LIFXAPIWrapper.h>
#import <LIFXLight.h>
#import <LIFXTargetOperationUpdate.h>
#import <LIFXErrors.h>


@interface TargetViewController ()

@property (weak, nonatomic) IBOutlet UISlider *hueSlider;
@property (weak, nonatomic) IBOutlet UISlider *saturationSlider;
@property (weak, nonatomic) IBOutlet UISlider *brightnessSlider;
@property (weak, nonatomic) IBOutlet UISlider *kelvinSlider;
@property (weak, nonatomic) IBOutlet UISwitch *powerSwitch;

@end


@implementation TargetViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self.target isKindOfClass:[LIFXLight class]])
        [self configureViewWithSelectedLight];
}

#pragma mark - Toggling power & Updating color

- (IBAction)toogledSwitch:(UISwitch *)sender
{
    [[LIFXAPIWrapper sharedAPIWrapper] changeLightPowerStatus:sender.isOn ofTarget:self.target onCompletion:^(NSArray *results) {
        [self logAPIResult:results];
        
    } onFailure:^(NSError *error) {
        [self displayAPIError:error];
        
    }];
}

- (IBAction)pressedUpdateColorButton:(UIButton *)sender
{
    LIFXTargetOperationUpdate *colorUpdate = [LIFXTargetOperationUpdate new];
    colorUpdate.hue = self.hueSlider.value;
    colorUpdate.saturation = self.saturationSlider.value;
    colorUpdate.brightness = self.brightnessSlider.value;
    
    [[LIFXAPIWrapper sharedAPIWrapper] applyUpdate:colorUpdate toTarget:self.target onCompletion:^(NSArray *results) {
        [self logAPIResult:results];
        
    } onFailure:^(NSError *error) {
        [self displayAPIError:error];

    }];
}

- (IBAction)pressedUpdateKelvinButton:(UIButton *)sender
{
    LIFXTargetOperationUpdate *kelvinUpdate = [LIFXTargetOperationUpdate updateWithKelvin:self.kelvinSlider.value];
    
    [[LIFXAPIWrapper sharedAPIWrapper] applyUpdate:kelvinUpdate toTarget:self.target onCompletion:^(NSArray *results) {
        [self logAPIResult:results];
                
    } onFailure:^(NSError *error) {
        [self displayAPIError:error];
        
    }];
}

- (void)logAPIResult:(NSArray *)results
{
    NSLog(@"Operation succeeded with results: %@", results);
}

- (void)displayAPIError:(NSError *)error
{
    NSLog(@"Operation failed with code: %@, JSON response : %@", @(error.code), error.userInfo[LIFXAPIErrorUserInfoKeyJSONResponse]);

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - Convenience methods

- (void)configureViewWithSelectedLight
{
    LIFXLight *light = self.target;
    
    self.hueSlider.value = light.color.hue;
    self.saturationSlider.value = light.color.saturation;
    self.brightnessSlider.value = light.brightness;
    self.kelvinSlider.value = light.color.kelvin;
    self.powerSwitch.on = light.on;
}

@end
