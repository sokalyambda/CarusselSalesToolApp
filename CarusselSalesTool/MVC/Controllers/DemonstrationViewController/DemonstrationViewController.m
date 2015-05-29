//
//  DemonstrationViewController.m
//  CarusselSalesTool
//
//  Created by Eugenity on 28.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "DemonstrationViewController.h"
#import "CarsFiltersViewController.h"
#import "CarsListViewController.h"

@interface DemonstrationViewController ()

@property (weak, nonatomic) IBOutlet UIView *carsFiltersHolder;
@property (weak, nonatomic) IBOutlet UIView *carsListHolder;

@property (strong, nonatomic) CarsFiltersViewController *carsFiltersController;
@property (strong, nonatomic) CarsListViewController *carsListController;

@end

@implementation DemonstrationViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildControllers];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - Actions

- (void)setupChildControllers
{
    self.carsListController = [[CarsListViewController alloc] initWithNibName:NSStringFromClass([CarsListViewController class]) bundle:nil];
    
    [self.carsListController.view setFrame:self.carsListHolder.frame];
    
    [self.carsListHolder addSubview:self.carsListController.view];
    
    [self addChildViewController:self.carsListController];
    [self.carsListController didMoveToParentViewController:self];
    
    self.carsFiltersController = [[CarsFiltersViewController alloc] initWithNibName:NSStringFromClass([CarsFiltersViewController class]) bundle:nil];
    
    [self.carsFiltersController.view setFrame:self.carsFiltersHolder.frame];
    
    [self.carsFiltersHolder addSubview:self.carsFiltersController.view];
    
    [self addChildViewController:self.carsFiltersController];
    [self.carsFiltersController didMoveToParentViewController:self];
}

@end
