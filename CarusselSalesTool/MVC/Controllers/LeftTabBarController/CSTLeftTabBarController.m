//
//  CSTLeftTabBarController.m
//  CarusselSalesTool
//
//  Created by Eugenity on 02.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTLeftTabBarController.h"

static NSString *const kCarsListSegueIdentifier = @"carsListSegue";
static NSString *const kProspectsListSegueIdentifier = @"prospectsListSegue";
static NSString *const kAddNewProspectSegueIdentifier = @"addNewProspectSegue";
static NSString *const kTasksListSegueIdentifier = @"tasksListSegue";

@interface CSTLeftTabBarController ()

@property (strong, nonatomic) NSArray *availableIdentifiers;

@end

@implementation CSTLeftTabBarController

#pragma mark - Accessors

- (NSArray *)availableIdentifiers
{
    if (!_availableIdentifiers) {
        _availableIdentifiers = @[kCarsListSegueIdentifier,
                                  kProspectsListSegueIdentifier,
                                  kAddNewProspectSegueIdentifier,
                                  kTasksListSegueIdentifier];
    }
    return _availableIdentifiers;
}

- (void)setSelectedIndex:(int)index
{
    if ([self.tabBarButtons count] <= index) {
        return;
    }
    
    [self performSegueWithIdentifier:self.availableIdentifiers[index]
                              sender:self.tabBarButtons[index]];
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([self.tabBarButtons count]) {
        [self performSegueWithIdentifier:kCarsListSegueIdentifier
                                  sender:self.tabBarButtons[0]];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([self.availableIdentifiers containsObject:segue.identifier]) {
        for (UIButton *btn in self.tabBarButtons) {
            if (sender && ![btn isEqual:sender]) {
                [btn setSelected: NO];
            } else if (sender) {
                [btn setSelected: YES];
            }
        }
    }
}

@end
