//
//  CSTMakeCarDataSource.m
//  CarusselSalesTool
//
//  Created by Eugenity on 07.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTMakeCarDataSource.h"
#import "CSTModelGroup.h"
#import "CSTModelGroupSectionHeader.h"
#import "UIView+MakeFromXib.h"

static NSString *cellIdentifier = @"MakeCarCell";
static CGFloat const kSectionHeaderHeight = 50.f;

@interface CSTMakeCarDataSource () <ExpandableSectionDelegate>

@property (strong, nonatomic) NSArray *modelGroups;
@property (strong, nonatomic) NSArray *models;

@end

@implementation CSTMakeCarDataSource

#pragma mark - Init

- (instancetype)init
{
#warning Temporary, hard code!!
    self = [super init];
    if (self) {
        CSTModelGroup *opelGroup = [[CSTModelGroup alloc] init];
        opelGroup.title = @"Opel";
        CSTModelGroup *fordGroup = [[CSTModelGroup alloc] init];
        fordGroup.title = @"Ford";
        CSTModelGroup *bwmGroup = [[CSTModelGroup alloc] init];
        bwmGroup.title = @"BWM";
        CSTModelGroup *fiatGroup = [[CSTModelGroup alloc] init];
        fiatGroup.title = @"Fiat";
        _modelGroups = @[opelGroup, fordGroup, bwmGroup, fiatGroup];
        _models = @[@"Corsa", @"Meriva", @"Astra", @"Insignia"];
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.modelGroups count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CSTModelGroup *currentModelGroup = self.modelGroups[section];
    
    return currentModelGroup.showModels ? [self.models count] : 0;
}

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    NSString *currentModel = self.models[indexPath.row];
    cell.textLabel.text = currentModel;
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CSTModelGroupSectionHeader *header = [CSTModelGroupSectionHeader makeFromXib];
    CSTModelGroup *currentModelGroup = self.modelGroups[section];
    header.modelGroupTitleLabel.text = currentModelGroup.title;
    header.section = section;
    header.delegate = self;
    
    [self rotateArrowImageForHeaderView:header toAngle:currentModelGroup.showModels ? M_PI_2 : 0.f];
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kSectionHeaderHeight;
}

#pragma mark - ExpandableSectionDelegate

- (void)shouldExpandSectionFromHeader:(CSTModelGroupSectionHeader *)headerView
{
    CSTModelGroup *currentModelGroup = self.modelGroups[headerView.section];
    currentModelGroup.showModels = !currentModelGroup.showModels;
    
    [self.dropDownTableView beginUpdates];
    [self.dropDownTableView reloadSections:[NSIndexSet indexSetWithIndex:headerView.section] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.dropDownTableView endUpdates];
    
    if (currentModelGroup.showModels) {
        [self.dropDownTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:[self.models indexOfObject:[self.models firstObject]] inSection:headerView.section] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (void)rotateArrowImageForHeaderView:(CSTModelGroupSectionHeader *)header toAngle:(CGFloat)angleValue
{
    [UIView animateWithDuration:.5f delay:0.f options:UIViewAnimationOptionCurveLinear animations:^{
        header.arrowImage.transform = CGAffineTransformMakeRotation(angleValue);
    } completion:nil];
}

@end
