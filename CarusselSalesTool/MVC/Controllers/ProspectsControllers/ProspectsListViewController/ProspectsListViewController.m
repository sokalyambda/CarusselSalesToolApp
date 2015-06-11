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
#import "CSTCommonSearchBar.h"
#import "CSTBaseOffersController.h"

@interface ProspectsListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *prospectsTableView;
@property (weak, nonatomic) IBOutlet CSTCommonSearchBar *prospectsSearchBar;

@property (strong, nonatomic) NSArray *prospectsList;

@end

@implementation ProspectsListViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WEAK_SELF;
    [[CSTDataManager sharedInstance] getProspectsList:^(NSArray *prospectsList, NSError *error) {
        weakSelf.prospectsList = prospectsList;
        [weakSelf.prospectsTableView reloadData];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self customizeSearchBar];
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
    CSTBaseOffersController *controller = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([CSTBaseOffersController class])];
    [self.navigationController pushViewController:controller animated:YES];
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Actions

- (void)customizeSearchBar
{
    [self.prospectsSearchBar setRightImageName:@"icn_search"];
    self.prospectsSearchBar.placeholder = NSLocalizedString(@"Name of prospect", nil);
}

@end
