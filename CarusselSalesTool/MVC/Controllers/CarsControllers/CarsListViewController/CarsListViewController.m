//
//  CarsListViewController.m
//  CarusselSalesTool
//
//  Created by Eugenity on 26.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CarsListViewController.h"

#import "CSTCarCell.h"
#import "UIView+MakeFromXib.h"

#import "CSTDataManager.h"
#import "MNMBottomPullToRefreshManager.h"

static NSInteger const kCarsPerPage = 10.f;
static NSInteger const kBottomPullRefreshHeight = 60.f;

@interface CarsListViewController () <UITableViewDataSource, UITableViewDelegate, MNMBottomPullToRefreshManagerClient>

@property (strong, nonatomic) NSMutableArray *cars;

@property (strong, nonatomic) CSTDataManager *dataManager;

@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) MNMBottomPullToRefreshManager *bottomRefreshManager;

@property (weak, nonatomic) IBOutlet UITableView *carListTableView;

@property (assign, nonatomic) NSInteger currentCarsPage;
@property (assign, nonatomic) NSInteger totalCarsCount;
@property (assign, nonatomic) NSInteger possibleCarsCount;

@end

@implementation CarsListViewController

#pragma mark - Accessors

- (NSMutableArray *)cars
{
    if (!_cars) {
        _cars = [NSMutableArray array];
    }
    return _cars;
}

- (NSInteger)possibleCarsCount
{
    NSInteger diff = self.totalCarsCount - [self.cars count];
    if (diff >= 0 && diff < kCarsPerPage) {
        _possibleCarsCount = diff;
    } else if (diff >= kCarsPerPage) {
        _possibleCarsCount = kCarsPerPage;
    } else {
        _possibleCarsCount = 0;
    }
    return _possibleCarsCount;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataManager = [CSTDataManager sharedInstance];
    [self receiveTotalCarsCount];
    [self getCarsListPage:self.currentCarsPage withCount:self.possibleCarsCount withFilters:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setupRefreshControl];
}

- (void)viewDidLayoutSubviews
{
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
        if ([weakSelf.delegate respondsToSelector:@selector(carsListTable:didSelectCar:)] && car) {
            [weakSelf.delegate carsListTable:weakSelf.carListTableView didSelectCar:car];
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

- (void)getCarsListPage:(NSUInteger)page withCount:(NSInteger)count withFilters:(NSDictionary *)filters
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
    [self.dataManager getCarListForRow:page pageSize:count parameter:param result:^(NSArray *carList, NSError *error) {
        
        ++weakSelf.currentCarsPage;
        
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        
        [weakSelf.refreshControl endRefreshing];
        
        [weakSelf.cars addObjectsFromArray:carList];
                
        [weakSelf.carListTableView reloadData];
        
        [weakSelf.bottomRefreshManager tableViewReloadFinished];
    }];
    
}

- (void)refreshCarsList
{
    self.cars = nil;
    self.currentCarsPage = 0;
    [self getCarsListPage:0 withCount:self.possibleCarsCount withFilters:nil];
}

- (void)receiveTotalCarsCount
{
//    WEAK_SELF;
//    [self.dataManager getCarsCount:^(NSInteger count, NSError *error) {
//        if (!error) {
//            weakSelf.totalCarsCount = count;
//        } else {
//            ShowTitleErrorAlert(NSLocalizedString(@"Cars count hasn't received.", nil), error);
//        }
//        NSLog(@"total count %li", (long)count);
//    }];
#warning hardCode!
    self.totalCarsCount = 37;
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
    [self getCarsListPage:self.currentCarsPage withCount:self.possibleCarsCount withFilters:nil];
}

#pragma mark - CSTCarsFiltersDelegate

- (void)carsFiltersController:(CarsFiltersViewController *)controller didSelectFiltersForCarSearch:(NSDictionary *)filters
{
    [self getCarsListPage:self.currentCarsPage withCount:self.possibleCarsCount withFilters:filters];
}

@end
