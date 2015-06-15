//
//  CSTNewListDataSource.m
//  CarusselSalesTool
//
//  Created by Eugenity on 15.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTNewListDataSource.h"

static NSString *cellIdentifier = @"NewCell";

@interface CSTNewListDataSource ()

@property (strong, nonatomic) NSArray *prospectsNew;

@end

@implementation CSTNewListDataSource

#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        _prospectsNew = @[@"Ivan", @"Fedor", @"Petr", @"Vasiliy", @"Nikolay"];
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.prospectsNew count];
}

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    NSString *nameString = self.prospectsNew[indexPath.row];
    cell.textLabel.text = nameString;
}

@end
