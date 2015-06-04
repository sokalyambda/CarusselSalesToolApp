//
//  ProspectsListViewController.m
//  CarusselSalesTool
//
//  Created by Eugenity on 26.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "ProspectsListViewController.h"
#import "CSTProspectCell.h"
#import "UIView+MakeFromXib.h"

@interface ProspectsListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *prospectsTableView;
@property (strong, nonatomic) NSArray *prospectsList;
@property (weak, nonatomic) IBOutlet UISearchBar *prospectSearchBar;

@end

@implementation ProspectsListViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.prospectsList = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4",@"5", nil];

}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.prospectsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSTProspectCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CSTProspectCell class])];
    
    if(!cell) {
        cell = [CSTProspectCell makeFromXib];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
