//
//  CSTFavouritesListDataSource.m
//  CarusselSalesTool
//
//  Created by Eugenity on 15.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTFavouritesListDataSource.h"

static NSString *cellIdentifier = @"FavouritesCell";

@interface CSTFavouritesListDataSource ()

@property (strong, nonatomic) NSArray *prospectsFavourites;

@end

@implementation CSTFavouritesListDataSource

#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        _prospectsFavourites = @[@"Fedor", @"Petr", @"Lyudmila", @"Valentin", @"Konstantin"];
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.prospectsFavourites count];
}

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    NSString *nameString = self.prospectsFavourites[indexPath.row];
    cell.textLabel.text = nameString;
}

@end
