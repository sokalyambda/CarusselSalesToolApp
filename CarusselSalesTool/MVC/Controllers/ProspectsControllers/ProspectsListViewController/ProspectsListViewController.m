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
#import "CSTProspect.h"

@interface ProspectsListViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *prospectsTableView;
@property (weak, nonatomic) IBOutlet CSTCommonSearchBar *prospectsSearchBar;

@property (strong, nonatomic) NSArray *prospectsList;
@property (strong, nonatomic) NSArray *filteredProspects;
@property (assign, nonatomic) BOOL isFiltered;

@end

@implementation ProspectsListViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    CSTProspect *p1 = [[CSTProspect alloc]init];
    CSTProspect *p2 = [[CSTProspect alloc]init];
    CSTProspect *p3 = [[CSTProspect alloc]init];
    CSTProspect *p4 = [[CSTProspect alloc]init];
    CSTProspect *p5 = [[CSTProspect alloc]init];
    CSTProspect *p6 = [[CSTProspect alloc]init];
    CSTProspect *p7 = [[CSTProspect alloc]init];
    p1.firstName = @"Arseniy";
    p2.firstName = @"Svitlana";
    p3.firstName = @"Nadiya";
    p4.firstName = @"Nastja";
    p5.firstName = @"Fedor";
    p6.firstName = @"Konstantin";
    p7.firstName = @"Artur";
    self.prospectsList = [[NSArray alloc]initWithObjects:p1, p2, p3, p4, p5, p6, p7, nil];
    
//    WEAK_SELF;
//    [[CSTDataManager sharedInstance] getProspectsList:^(NSArray *prospectsList, NSError *error) {
//        weakSelf.prospectsList = prospectsList;
//        [weakSelf.prospectsTableView reloadData];
//    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self customizeSearchBar];
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isFiltered) {
        return [self.filteredProspects count];
    }
    return [self.prospectsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSTProspectCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CSTProspectCell class])];
    
    if (!cell) {
        cell = [CSTProspectCell makeFromXib];
    }
    CSTProspect *currentProspect = self.isFiltered ? self.filteredProspects[indexPath.row] : self.prospectsList[indexPath.row];
    [cell configureCellWithProspect:currentProspect];
    
    return cell;
}

#pragma mark - UITableViewDelegate 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    CSTBaseOffersController *controller = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([CSTBaseOffersController class])];
//    [self.navigationController pushViewController:controller animated:YES];
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"mainOffersSegue" sender:self];
}

#pragma mark - Actions

- (void)customizeSearchBar
{
    [self.prospectsSearchBar setRightImageName:@"icn_search"];
    self.prospectsSearchBar.placeholder = NSLocalizedString(@"Name of prospect", nil);
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    if (text.length == 0) {
        self.isFiltered = NO;
    } else {
        self.isFiltered = YES;
        NSPredicate *predicate =[NSPredicate predicateWithFormat:@"firstName CONTAINS[cd] %@", text];
        self.filteredProspects = [self.prospectsList filteredArrayUsingPredicate:predicate];
    }
    [self.prospectsTableView reloadData];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"mainOffersSegue"]) {
        CSTBaseOffersController *controller = (CSTBaseOffersController *)segue.destinationViewController;
        controller.hidesBottomBarWhenPushed = NO;
    }
}

@end
