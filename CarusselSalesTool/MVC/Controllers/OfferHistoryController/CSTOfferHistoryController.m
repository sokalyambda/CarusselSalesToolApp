//
//  CSTOfferHistoryController.m
//  CarusselSalesTool
//
//  Created by Eugenity on 11.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTOfferHistoryController.h"
#import "CSTBaseOffersController.h"

@interface CSTOfferHistoryController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *historyTableView;
@property (strong, nonatomic) NSArray *historyDataSource;
@end

@class CSTNavigationSegue;

@implementation CSTOfferHistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.historyDataSource = [[NSArray alloc]initWithObjects:@1, @2, @3, @4, @5, nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.historyDataSource count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSTBaseOffersController *controller = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([CSTBaseOffersController class])];
    [controller setSelectedIndex:1];

}

@end
