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
#import "MNMBottomPullToRefreshManager.h"

static NSUInteger const kCarsPerPage = 10.f;
static NSUInteger const kBottomPullRefreshHeight = 60.f;

@interface CarsListViewController () <UITableViewDataSource, UITableViewDelegate, MNMBottomPullToRefreshManagerClient>

@property (strong, nonatomic) NSArray *cars;

@property (strong, nonatomic) CSTDataManager *dataManager;

@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) MNMBottomPullToRefreshManager *bottomRefreshManager;

@property (weak, nonatomic) IBOutlet UITableView *carListTableView;

@property (assign, nonatomic) NSUInteger currentCarsPage;

@end

@implementation CarsListViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataManager = [CSTDataManager sharedInstance];
    [self getCarsListPage:0 withFilters:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setupRefreshControl];
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    [self.bottomRefreshManager relocatePullToRefreshView];
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
}

#pragma mark - Actions

- (void)setupRefreshControl
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.carListTableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshCarsList) forControlEvents:UIControlEventValueChanged];
    
    self.bottomRefreshManager = [[MNMBottomPullToRefreshManager alloc] initWithPullToRefreshViewHeight:kBottomPullRefreshHeight tableView:self.carListTableView withClient:self];
}

- (void)getCarsListPage:(NSUInteger)page withFilters:(NSDictionary *)filters
{
    if(!self.refreshControl.isRefreshing && !self.bottomRefreshManager.isLoading) {
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
    [self.dataManager getCarListForRow:page pageSize:kCarsPerPage parameter:param result:^(NSArray *carList, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        
        [weakSelf.refreshControl endRefreshing];
        
        weakSelf.cars = carList;
        
        [weakSelf tableView:weakSelf.carListTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        
        [weakSelf.carListTableView reloadData];
        
        [weakSelf.bottomRefreshManager tableViewReloadFinished];
    }];
}

- (void)refreshCarsList
{
    [self getCarsListPage:0 withFilters:nil];
}

#pragma mark - MNMBottomPullToRefreshManagerClient

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.bottomRefreshManager tableViewScrolled];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.bottomRefreshManager tableViewReleased];
}

- (void)bottomPullToRefreshTriggered:(MNMBottomPullToRefreshManager *)manager
{
    [self refreshCarsList];
}

@end
