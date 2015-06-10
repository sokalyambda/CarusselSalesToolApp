//
//  CSTTasksListController.m
//  CarusselSalesTool
//
//  Created by Eugenity on 05.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTTasksListController.h"
#import "CSTTaskCell.h"
#import "UIView+MakeFromXib.h"
#import "CSTCommonSearchBar.h"

@interface CSTTasksListController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *tasksDataSource;
@property (weak, nonatomic) IBOutlet UITableView *taskTableView;
@property (weak, nonatomic) IBOutlet CSTCommonSearchBar *tasksSearchBar;

@end

@implementation CSTTasksListController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WEAK_SELF;
    [[CSTDataManager sharedInstance] getTasksList:^(NSArray *tasksList, NSError *error) {
        weakSelf.tasksDataSource = tasksList;
        [weakSelf.taskTableView reloadData];
    }];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self customizeSearchBar];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tasksDataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSTTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CSTTaskCell class])];
    
    if(!cell) {
        cell = [CSTTaskCell makeFromXib];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Actions

- (void)customizeSearchBar
{
    [self.tasksSearchBar setRightImageName:@"icn_search"];
    self.tasksSearchBar.placeholder = NSLocalizedString(@"Task's name", nil);
}

@end
