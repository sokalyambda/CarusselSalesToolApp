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

@interface CSTTasksListController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *tasksDataSource;
@property (weak, nonatomic) IBOutlet UITableView *taskTableView;

@end

@implementation CSTTasksListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WEAK_SELF;
    [[CSTDataManager sharedInstance] getTasksList:^(NSArray *tasksList, NSError *error) {
        weakSelf.tasksDataSource = tasksList;
        [weakSelf.taskTableView reloadData];
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
@end
