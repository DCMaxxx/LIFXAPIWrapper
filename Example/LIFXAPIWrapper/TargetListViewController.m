//
//  LIFXViewController.m
//  LIFXAPIWrapper
//
//  Created by Maxime de Chalendar on 06/27/2015.
//  Copyright (c) 2014 Maxime de Chalendar. All rights reserved.
//

#import "TargetListViewController.h"
#import "TargetViewController.h"
#import <LIFXAPIWrapper.h>
#import <LIFXLight.h>


@interface TargetListViewController ()

@property (strong, nonatomic) NSArray *locations;
@property (strong, nonatomic) NSArray *groups;
@property (strong, nonatomic) NSArray *lights;

@end


@implementation TargetListViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self fetchLights];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"LightViewController"])
    {
        TargetViewController *viewController = segue.destinationViewController;
        viewController.target = [self selectedTarget];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3; // Locations, Groups, Lights
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return self.locations.count;
    else if (section == 1)
        return self.groups.count;
    else if (section == 2)
        return self.lights.count;
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return @"Locations";
    else if (section == 1)
        return @"Groups";
    else if (section == 2)
        return @"Lights";
    return @"";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LightTableViewCell"];
    
    NSString *name;
    if (indexPath.section == 0)
        name = ((LIFXLocation *)self.locations[indexPath.row]).name;
    else if (indexPath.section == 1)
        name = ((LIFXGroup *)self.groups[indexPath.row]).name;
    else if (indexPath.section == 2)
        name = ((LIFXLight *)self.lights[indexPath.row]).label;

    cell.textLabel.text = name;
    return cell;
}

#pragma mark - Fetch lights & reload view

- (void)fetchLights
{
    [[LIFXAPIWrapper sharedAPIWrapper] getAllLightsWithCompletion:^(NSArray *lights) {
        [self updateViewWithLights:lights];
        
    } onFailure:^(NSError *error) {
        [self displayAPIError:error];
        
    }];
}

- (void)updateViewWithLights:(NSArray *)lights
{
    [self setupLocationAndGroupsFromLights:lights];
    [self.tableView reloadData];
}

- (void)setupLocationAndGroupsFromLights:(NSArray *)lights
{
    NSMutableArray *locations = [NSMutableArray new];
    NSMutableArray *groups = [NSMutableArray new];

    for (LIFXLight *light in lights)
    {
        if ([locations containsObject:light.location] == NO)
            [locations addObject:light.location];
        if ([groups containsObject:light.group] == NO)
            [groups addObject:light.group];
    }
    
    self.locations = [locations copy];
    self.groups = [groups copy];
    self.lights = lights;
}

- (void)displayAPIError:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - Convenience methods

- (id<LIFXTargetable>)selectedTarget
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if (indexPath == nil)
        return nil;

    if (indexPath.section == 0)
        return self.locations[indexPath.row];
    else if (indexPath.section == 1)
        return self.groups[indexPath.row];
    else if (indexPath.section == 2)
        return self.lights[indexPath.row];
    return nil;
}

@end
