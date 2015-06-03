//
//  AddProspectViewController.m
//  CarusselSalesTool
//
//  Created by Eugenity on 29.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "AddProspectViewController.h"
#import "ProspectDetailsViewController.h"
#import "CarsFiltersViewController.h"

@interface AddProspectViewController ()

@property (strong, nonatomic) ProspectDetailsViewController *prospectDetailsController;
@property (strong, nonatomic) CarsFiltersViewController *carsFiltersController;

@property (weak, nonatomic) IBOutlet UIView *prospectDetailsHolder;
@property (weak, nonatomic) IBOutlet UIView *carsFiltersHolder;

@end

@implementation AddProspectViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildControllers];
}

#pragma mark - Actions

- (void)setupChildControllers
{
    self.prospectDetailsController = [[ProspectDetailsViewController alloc] initWithNibName:NSStringFromClass([ProspectDetailsViewController class]) bundle:nil];
    [self.prospectDetailsController.view setFrame:self.prospectDetailsHolder.frame];
    [self.prospectDetailsHolder addSubview:self.prospectDetailsController.view];
    [self addChildViewController:self.prospectDetailsController];
    [self.prospectDetailsController didMoveToParentViewController:self];
    
    self.carsFiltersController = [[CarsFiltersViewController alloc] initWithNibName:NSStringFromClass([CarsFiltersViewController class]) bundle:nil];
    [self.carsFiltersController.view setFrame:self.carsFiltersHolder.frame];
    [self.carsFiltersHolder addSubview:self.carsFiltersController.view];
    [self addChildViewController:self.carsFiltersController];
    [self.carsFiltersController didMoveToParentViewController:self];
}


@end
