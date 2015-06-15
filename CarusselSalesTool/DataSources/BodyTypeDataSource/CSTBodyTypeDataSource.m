//
//  CSTBodyTypeDataSource.m
//  CarusselSalesTool
//
//  Created by Eugenity on 07.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTBodyTypeDataSource.h"

static NSString *cellIdentifier = @"BodyTypeCell";

@interface CSTBodyTypeDataSource ()

@property (strong, nonatomic) NSArray *bodyTypes;

@end

@implementation CSTBodyTypeDataSource

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        _bodyTypes = @[@"All", @"5 doors", @"4 doors", @"3 doors", @"2 doors", @"SUV"];
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.bodyTypes count];
}

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    NSString *bodyTypeString = self.bodyTypes[indexPath.row];
    cell.textLabel.text = bodyTypeString;
}

@end
