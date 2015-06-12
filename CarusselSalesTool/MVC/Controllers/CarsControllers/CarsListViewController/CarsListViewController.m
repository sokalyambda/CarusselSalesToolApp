//
//  CarsListViewController.m
//  CarusselSalesTool
//
//  Created by Eugenity on 26.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CarsListViewController.h"

#import "CarCell.h"
#import "UIView+MakeFromXib.h"

#import "CSTDataManager.h"


@interface CarsListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *cars;
@property (strong, nonatomic) CSTDataManager *dataManager;

@property (weak, nonatomic) IBOutlet UITableView *carListTbleView;

@end

@implementation CarsListViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataManager = [CSTDataManager sharedInstance];
    [self getCarsList];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cars count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CarCell class])];
    
    if (!cell) {
        cell = [CarCell makeFromXib];
    }
    
    CSTCar *currentCar = self.cars[indexPath.row];
    
    cell.carPriceLabel.text = [NSString stringWithFormat:@"%i",currentCar.price];
    cell.carTitleLabel.text = currentCar.title;
    
    NSURL *carImageURL = [NSURL URLWithString:currentCar.defaultImage.mediumUrl];
    
    if (![carImageURL isEqual:[NSNull null]]) {
        [cell.carImage sd_setImageWithURL:carImageURL];
    }
 
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

- (void)getCarsList
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *param = @{StatusType  : @0,
//                            BrandType   : @1,
//                            ModelType   : @4,
//                            LocationType: @(((CSTLocation *)self.dataManager.companyInfo.location[0]).ID),
//                            ImageType   : @"false",
                            };
    WEAK_SELF;
    [self.dataManager getCarListForRow:0 pageSize:10 parameter:param result:^(NSArray *carList, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        weakSelf.cars = carList;
        [weakSelf.carListTbleView reloadData];
    }];
}

@end
