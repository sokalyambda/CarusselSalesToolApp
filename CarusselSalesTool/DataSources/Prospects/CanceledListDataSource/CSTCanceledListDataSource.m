//
//  CSTCanceledListDataSource.m
//  CarusselSalesTool
//
//  Created by Eugenity on 15.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTCanceledListDataSource.h"

static NSString *cellIdentifier = @"CanceledCell";

@interface CSTCanceledListDataSource ()

@property (strong, nonatomic) NSArray *prospectsCanceled;

@end

@implementation CSTCanceledListDataSource

#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        _prospectsCanceled = @[@"Arseniy", @"Svitlana", @"Nadiya", @"Kateryna", @"Petr"];
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.prospectsCanceled count];
}

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    NSString *nameString = self.prospectsCanceled[indexPath.row];
    cell.textLabel.text = nameString;
}

@end
