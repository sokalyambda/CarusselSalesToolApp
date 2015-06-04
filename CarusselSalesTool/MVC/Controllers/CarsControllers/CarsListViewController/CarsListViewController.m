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
#import "Car.h"

@interface CarsListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *cars;

@end

@implementation CarsListViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cars = [NSArray arrayWithObjects:@"car 1", @"car 2", @"car 3", @"car 4", nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cars count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CarCell class])];
    
    if (cell == nil) {
        cell = [CarCell makeFromXib];
    }
    
    //TODO: configure cell

    
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO: pass car to detail controller
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
