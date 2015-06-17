//
//  MainCarsViewController.m
//  CarusselSalesTool
//
//  Created by Eugenity on 26.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "MainCarsViewController.h"
#import "CarsListViewController.h"
#import "CarDetailsViewController.h"
#import "CarsFiltersViewController.h"

@interface MainCarsViewController ()<CSTCarsListDelegate>

@property (weak, nonatomic) IBOutlet UIView *carsListHolder;
@property (weak, nonatomic) IBOutlet UIView *carDetailsHolder;
@property (weak, nonatomic) IBOutlet UIView *searchView;

@property (strong, nonatomic) CarsListViewController *carsListController;
@property (strong, nonatomic) CarsFiltersViewController *carsFiltersController;
@property (strong, nonatomic) CarDetailsViewController *carDetailsController;

@end

@implementation MainCarsViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupChildControllers];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self setupFiltersController];
}

#pragma mark - Actions

- (void)setupFiltersController
{
    self.carsFiltersController = [[CarsFiltersViewController alloc] initWithNibName:NSStringFromClass([CarsFiltersViewController class]) bundle:nil];
    //setup the delegate
    self.carsFiltersController.delegate = self.carsListController;
    
    [self addChildViewController:self.carsFiltersController];
    [self.carsFiltersController didMoveToParentViewController:self];
    
    [self.view addSubview:self.carsFiltersController.view];
    //to correct the appearance of left panel
    [self.view bringSubviewToFront:self.carsFiltersController.view];
    self.carsFiltersController.containerFrame = self.carsListHolder.frame;
    
    self.carsFiltersController.view.frame = (CGRect) {
        .origin = CGPointMake(-CGRectGetWidth(self.carsListHolder.frame) + CGRectGetMinX(self.carsListHolder.frame), CGRectGetMinY(self.carsListHolder.frame)),
        .size = self.carsListHolder.frame.size
    };;
}

- (void)setupCarsListController
{
    self.carsListController = [[CarsListViewController alloc] initWithNibName:NSStringFromClass([CarsListViewController class]) bundle:nil];
    [self.carsListController.view setFrame:self.carsListHolder.frame];
    [self.carsListHolder addSubview:self.carsListController.view];
    [self addChildViewController:self.carsListController];
    [self.carsListController didMoveToParentViewController:self];
    self.carsListController.delegate = self;
}

- (void)setupCarDetailsController
{
    self.carDetailsController = [[CarDetailsViewController alloc] initWithNibName:NSStringFromClass([CarDetailsViewController class]) bundle:nil];
    [self.carDetailsController.view setFrame:self.carDetailsHolder.frame];
    [self.carDetailsHolder addSubview:self.carDetailsController.view];
    [self addChildViewController:self.carDetailsController];
    [self.carDetailsController didMoveToParentViewController:self];
}

- (void)setupChildControllers
{
    [self setupCarsListController];
    [self setupCarDetailsController];
}

#pragma mark - CSTCarsListDelegate

- (void)carsListTable:(UITableView *)carsListTable didSelectCar:(CSTCar *)car
{
    self.carDetailsController.currentCar = car;
}

@end
