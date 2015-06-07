//
//  CSTCarYearFromDataSource.m
//  CarusselSalesTool
//
//  Created by Eugenity on 07.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTCarYearFromDataSource.h"

@interface CSTCarYearFromDataSource ()

@property (strong, nonatomic) NSArray *years;

@end

@implementation CSTCarYearFromDataSource

- (void)dealloc
{
    NSLog(@"object has been deallocated");
}

#pragma mark - Init

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"YearCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSString *yearString = self.years[indexPath.row];
    
    cell.textLabel.text = yearString;
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
}

@end
