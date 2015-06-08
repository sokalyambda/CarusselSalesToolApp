//
//  CSTFuelTypeDataSource.m
//  CarusselSalesTool
//
//  Created by Eugenity on 07.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTFuelTypeDataSource.h"

static NSString *cellIdentifier = @"FuelTypeCell";

@interface CSTFuelTypeDataSource ()

@property (strong, nonatomic) NSArray *fuelTypes;

@end

@implementation CSTFuelTypeDataSource

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        _fuelTypes = @[@"All", @"Petrol", @"Diesel", @"CNG/LPG", @"Electric", @"Hibrid"];
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.fuelTypes count];
}

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    NSString *fuelTypeString = self.fuelTypes[indexPath.row];
    cell.textLabel.text = fuelTypeString;
}

@end
