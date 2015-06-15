//
//  CSTCarYearFromDataSource.m
//  CarusselSalesTool
//
//  Created by Eugenity on 07.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTCarYearFromDataSource.h"

static NSString *cellIdentifier = @"YearCell";

@interface CSTCarYearFromDataSource ()

@property (strong, nonatomic) NSArray *years;

@end

@implementation CSTCarYearFromDataSource

#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        _years = @[@"2015", @"2014", @"2013", @"2012", @"2011"];
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.years count];
}

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    NSString *yearString = self.years[indexPath.row];
    cell.textLabel.text = yearString;
}

@end
