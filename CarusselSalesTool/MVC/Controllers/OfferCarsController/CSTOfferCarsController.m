//
//  CSTOfferCarsController.m
//  CarusselSalesTool
//
//  Created by Eugenity on 11.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTOfferCarsController.h"
#import "CarsListViewController.h"
#import "CSTOfferDataController.h"

@interface CSTOfferCarsController ()

@property (weak, nonatomic) IBOutlet UIView *offerDataHolder;
@property (weak, nonatomic) IBOutlet UIView *carsListHolder;

@property (strong, nonatomic) CarsListViewController *carsListController;
@property (strong, nonatomic) CSTOfferDataController *offerDataController;
@end

@implementation CSTOfferCarsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildControllers];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupChildControllers
{
    self.carsListController = [[CarsListViewController alloc] initWithNibName:NSStringFromClass([CarsListViewController class]) bundle:nil];
    [self.carsListController.view setFrame:self.carsListHolder.frame];
    [self.carsListHolder addSubview:self.carsListController.view];
    [self addChildViewController:self.carsListController];
    [self.carsListController didMoveToParentViewController:self];

    self.offerDataController = [[CSTOfferDataController alloc] initWithNibName:NSStringFromClass([CSTOfferDataController class]) bundle:nil];
    [self.offerDataController.view setFrame:self.offerDataHolder.frame];
    [self.offerDataHolder addSubview:self.offerDataController.view];
    [self addChildViewController:self.offerDataController];
    [self.offerDataController didMoveToParentViewController:self];
}


@end
