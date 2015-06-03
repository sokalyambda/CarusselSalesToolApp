//
//  MainCarsViewController.m
//  CarusselSalesTool
//
//  Created by Eugenity on 26.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "MainCarsViewController.h"
#import "CarsListViewController.h"
#import "CarDetailsViewController.h"
#import "CarsFiltersViewController.h"
#import "DropDownTable.h"
#import "UIView+MakeFromXib.h"

#import "DropDownCell.h"

static CGFloat kSlideTiming = 0.5f;

@interface MainCarsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *carsListHolder;
@property (weak, nonatomic) IBOutlet UIView *carDetailsHolder;

@property (assign, nonatomic) CGRect originalPanelPosition;

@property (strong, nonatomic) CarsListViewController *carsListController;
@property (strong, nonatomic) CarsFiltersViewController *carsFiltersController;
@property (strong, nonatomic) CarDetailsViewController *carDetailsController;

@property (strong, nonatomic) DropDownTable *dropDownTable;

@end

@implementation MainCarsViewController

#pragma mark - Accessors

- (CGRect)originalPanelPosition
{
    if (CGRectEqualToRect(_originalPanelPosition, CGRectZero)) {
        _originalPanelPosition = (CGRect) {
            .origin = CGPointMake(-CGRectGetWidth(self.carsListHolder.frame), CGRectGetMinY(self.carsListHolder.frame)),
            .size = self.carsListHolder.frame.size
        };
    }
    
    return _originalPanelPosition;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupChildControllers];
    [self initDropDownTableView];
    self.tabBarController.navigationItem.title = NSLocalizedString(@"Carussel Sales Tool", nil);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - Actions

- (IBAction)showFiltersClick:(id)sender
{
    NSUInteger filtersPanelState = self.carsFiltersController.state;
    switch (filtersPanelState) {
        case FiltersPanelStateOpened: {
            [self movePanelToOriginalPosition];
            break;
        }
        case FiltersPanelStateClosed: {
            [self showFilters];
            break;
        }
        default:
            break;
    }
}

//for test only
- (IBAction)dropDownTestClick:(id)sender
{
    [self.dropDownTable dropDownTableBecomeActiveInView:self.view fromAnchorView:sender withCompletion:nil];
}

- (void)setupChildControllers
{
    self.carsListController = [[CarsListViewController alloc] initWithNibName:NSStringFromClass([CarsListViewController class]) bundle:nil];
    [self.carsListController.view setFrame:self.carsListHolder.frame];
    [self.carsListHolder addSubview:self.carsListController.view];
    [self addChildViewController:self.carsListController];
    [self.carsListController didMoveToParentViewController:self];
    
    self.carDetailsController = [[CarDetailsViewController alloc] initWithNibName:NSStringFromClass([CarDetailsViewController class]) bundle:nil];
    [self.carDetailsController.view setFrame:self.carDetailsHolder.frame];
    [self.carDetailsHolder addSubview:self.carDetailsController.view];
    [self addChildViewController:self.carDetailsController];
    [self.carDetailsController didMoveToParentViewController:self];
}

- (UIView *)getFiltersView
{
    if (!self.carsFiltersController) {
        // this is where you define the view for the left panel
        self.carsFiltersController = [[CarsFiltersViewController alloc] initWithNibName:NSStringFromClass([CarsFiltersViewController class]) bundle:nil];
        
        [self.view addSubview:self.carsFiltersController.view];
        
        [self addChildViewController:self.carsFiltersController];
        [self.carsFiltersController didMoveToParentViewController:self];
        
        self.carsFiltersController.view.frame = self.originalPanelPosition;
    }
    
    UIView *view = self.carsFiltersController.view;
    return view;
}

- (void)showFilters
{
    UIView *childView = [self getFiltersView];

    //to correct the appearance of left panel
    [self.view bringSubviewToFront:childView];
    
    [UIView animateWithDuration:kSlideTiming delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         childView.frame = self.carsListHolder.frame;
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             self.carsFiltersController.state = FiltersPanelStateOpened;
                         }
                     }];
}

- (void)movePanelToOriginalPosition
{
    [UIView animateWithDuration:kSlideTiming delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.carsFiltersController.view.frame = self.originalPanelPosition;
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [self resetFiltersPanel];
                         }
                     }];
}

- (void)resetFiltersPanel
{
    if (self.carsFiltersController) {
        [self.carsFiltersController.view removeFromSuperview];
        self.carsFiltersController = nil;
        self.carsFiltersController.state = FiltersPanelStateClosed;
    }
}

- (void)initDropDownTableView
{
    self.dropDownTable = [DropDownTable makeFromXib];
    self.dropDownTable.dataSource = self;
    self.dropDownTable.delegate = self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DropDownCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DropDownCell class])];
    
    if (cell == nil) {
        cell = [DropDownCell makeFromXib];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %i", indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

@end
