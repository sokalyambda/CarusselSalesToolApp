//
//  CSTMakeCarDataSource.m
//  CarusselSalesTool
//
//  Created by Eugenity on 07.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTMakeCarDataSource.h"
#import "CSTModelGroup.h"
#import "CSTMakeCar.h"
#import "CSTModelGroupSectionHeader.h"
#import "UIView+MakeFromXib.h"

static NSString *cellIdentifier = @"MakeCarCell";
static CGFloat const kSectionHeaderHeight = 50.f;

@interface CSTMakeCarDataSource () <ExpandableSectionDelegate>

@property (strong, nonatomic) NSArray *manufacturers;
@property (strong, nonatomic) NSArray *models;

@end

@implementation CSTMakeCarDataSource

#pragma mark - Init

- (instancetype)init
{
#warning Temporary, hard code!!
    self = [super init];
    if (self) {
        CSTMakeCar *opelMake = [[CSTMakeCar alloc] init];
        opelMake.title = @"Opel";
        CSTMakeCar *fordMake = [[CSTMakeCar alloc] init];
        fordMake.title = @"Ford";
        CSTMakeCar *bwmMake = [[CSTMakeCar alloc] init];
        bwmMake.title = @"BWM";
        CSTMakeCar *fiatMake = [[CSTMakeCar alloc] init];
        fiatMake.title = @"Fiat";
        _manufacturers = @[opelMake, fordMake, bwmMake, fiatMake];
        
        CSTModelGroup *corsaModel = [[CSTModelGroup alloc] init];
        corsaModel.title = @"Corsa";
        CSTModelGroup *merivaModel = [[CSTModelGroup alloc] init];
        merivaModel.title = @"Meriva";
        CSTModelGroup *astraModel = [[CSTModelGroup alloc] init];
        astraModel.title = @"Astra";
        CSTModelGroup *insigniaModel = [[CSTModelGroup alloc] init];
        insigniaModel.title = @"Insignia";
        _models = @[corsaModel, merivaModel, astraModel, insigniaModel];
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.manufacturers count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CSTMakeCar *currentMakeCar = self.manufacturers[section];
    
    return currentMakeCar.showModels ? [self.models count] : 0;
}

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    CSTModelGroup *currentModel = self.models[indexPath.row];
    cell.textLabel.text = currentModel.title;
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CSTModelGroupSectionHeader *header = [CSTModelGroupSectionHeader makeFromXib];
    CSTMakeCar *currentMakeCar = self.manufacturers[section];
    header.modelGroupTitleLabel.text = currentMakeCar.title;
    header.section = section;
    header.delegate = self;
    
    [self rotateArrowImageForHeaderView:header toAngle:currentMakeCar.showModels ? M_PI_2 : 0.f];
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kSectionHeaderHeight;
}

#pragma mark - ExpandableSectionDelegate

- (void)shouldExpandSectionFromHeader:(CSTModelGroupSectionHeader *)headerView
{
    CSTMakeCar *currentMakeCar = self.manufacturers[headerView.section];
    currentMakeCar.showModels = !currentMakeCar.showModels;
    
    [self.dropDownTableView beginUpdates];
    [self.dropDownTableView reloadSections:[NSIndexSet indexSetWithIndex:headerView.section] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.dropDownTableView endUpdates];
    
    if (currentMakeCar.showModels) {
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
