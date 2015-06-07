//
//  CSTBaseDropDownDataSource.m
//  CarusselSalesTool
//
//  Created by Eugenity on 07.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTBaseDropDownDataSource.h"

#import "CSTMakeCarDataSource.h"
#import "CSTFuelTypeDataSource.h"
#import "CSTBodyTypeDataSource.h"
#import "CSTCarColorDataSource.h"
#import "CSTCarYearFromDataSource.h"

@implementation CSTBaseDropDownDataSource

- (instancetype)initWithDataSourceType:(DropDownDataSourceType)dataSourceType
{
    id currentDataSource = nil;
    
    switch (dataSourceType) {
        case DropDownDataSourceTypeMakeCar:
            currentDataSource = [[CSTMakeCarDataSource alloc] init];
            break;
        case DropDownDataSourceTypeFuelType:
            currentDataSource = [[CSTFuelTypeDataSource alloc] init];
            break;
        case DropDownDataSourceTypeBodyType:
            currentDataSource = [[CSTBodyTypeDataSource alloc] init];
            break;
        case DropDownDataSourceTypeCarColor:
            currentDataSource = [[CSTCarColorDataSource alloc] init];
            break;
        case DropDownDataSourceTypeYearFrom:
            currentDataSource = [[CSTCarYearFromDataSource alloc] init];
            break;
            
        default:
            break;
    }
    return currentDataSource;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
