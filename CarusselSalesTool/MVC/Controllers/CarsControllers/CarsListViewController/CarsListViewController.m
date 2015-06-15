//
//  CarsListViewController.m
//  CarusselSalesTool
//
//  Created by Eugenity on 26.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CarsListViewController.h"
#import "CarsFiltersViewController.h"

#import "CSTCarCell.h"
#import "UIView+MakeFromXib.h"

#import "CSTDataManager.h"


@interface CarsListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *cars;
@property (strong, nonatomic) CSTDataManager *dataManager;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@property (weak, nonatomic) IBOutlet UITableView *carListTableView;

@end

@implementation CarsListViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataManager = [CSTDataManager sharedInstance];
    [self getCarsListPage:0 withFilters:nil];
    
    [self setupRefreshControl];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cars count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSTCarCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CSTCarCell class])];
    
    if (!cell) {
        cell = [CSTCarCell makeFromXib];
    }
    
    CSTCar *currentCar = self.cars[indexPath.row];
    
    [cell configureCellWithCar:currentCar];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSTCar *chosenCar = self.cars[indexPath.row];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    WEAK_SELF;
    [self.dataManager getCarWithID:chosenCar.ID result:^(CSTCar *car, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if (weakSelf.carSelectedCompletion && car) {
            weakSelf.carSelectedCompletion(car);
        }
    }];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Actions

- (void)setupRefreshControl
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.carListTableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshCarsList) forControlEvents:UIControlEventValueChanged];
}

- (void)getCarsListPage:(NSUInteger)page withFilters:(NSDictionary *)filters
{
    if(!self.refreshControl.isRefreshing) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    NSMutableDictionary *param = [@{//StatusType  : @0,
                                    //                            BrandType   : @1,
                                    //                            ModelType   : @4,
                                    //                            LocationType: @(((CSTLocation *)self.dataManager.companyInfo.location[0]).ID),
                                    //                            ImageType   : @"false",
                                    } mutableCopy];
    if (filters) {
        [param addEntriesFromDictionary:filters];
    }
    WEAK_SELF;
    [self.dataManager getCarListForRow:page pageSize:10 parameter:param result:^(NSArray *carList, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        [weakSelf.refreshControl endRefreshing];
        weakSelf.cars = carList;
        [weakSelf tableView:weakSelf.carListTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [weakSelf.carListTableView reloadData];
    }];
}

- (void)refreshCarsList
{
    [self getCarsListPage:0 withFilters:nil];
}

@end
