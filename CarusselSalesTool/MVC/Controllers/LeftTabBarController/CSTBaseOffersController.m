//
//  CSTLeftTabBarController.m
//  CarusselSalesTool
//
//  Created by Eugenity on 02.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTBaseOffersController.h"

static NSString *const kCarsByProspectSegueIdentifier = @"carsByProspectSegue";
static NSString *const kOfferCarsSegueIdentifier = @"offerCarsSegue";
static NSString *const kOfferHistorySegueIdentifier = @"offerHistorySegue";

@interface CSTBaseOffersController ()

@property (strong, nonatomic) NSArray *availableIdentifiers;

@end

@implementation CSTBaseOffersController

#pragma mark - Accessors

- (NSArray *)availableIdentifiers
{
    if (!_availableIdentifiers) {
        _availableIdentifiers = @[kCarsByProspectSegueIdentifier,
                                  kOfferCarsSegueIdentifier,
                                  kOfferHistorySegueIdentifier];
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
        [self performSegueWithIdentifier:kCarsByProspectSegueIdentifier
                                  sender:self.tabBarButtons[0]];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([self.availableIdentifiers containsObject:segue.identifier]) {
        for (UIButton *btn in self.tabBarButtons) {
            if (sender && ![btn isEqual:sender]) {
                [btn setSelected:NO];
            } else if (sender) {
                [btn setSelected:YES];
            }
        }
    }
}

@end