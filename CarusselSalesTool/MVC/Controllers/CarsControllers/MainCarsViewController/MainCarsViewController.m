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

static CGFloat kSlideTiming = 0.5f;

@interface MainCarsViewController ()<CSTCarsFiltersDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *carsListHolder;
@property (weak, nonatomic) IBOutlet UIView *carDetailsHolder;
@property (weak, nonatomic) IBOutlet UIView *searchView;

@property (assign, nonatomic) CGRect originalPanelPosition;

@property (strong, nonatomic) CarsListViewController *carsListController;
@property (strong, nonatomic) CarsFiltersViewController *carsFiltersController;
@property (strong, nonatomic) CarDetailsViewController *carDetailsController;

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
    [self setupGestures];
}

#pragma mark - Actions

- (IBAction)showFiltersClick:(id)sender
{
    NSUInteger filtersPanelState = self.carsFiltersController.state;
    switch (filtersPanelState) {
        case CSTFiltersPanelStateOpened: {
            [self movePanelToOriginalPosition];
            break;
        }
        case CSTFiltersPanelStateClosed: {
            [self showFilters];
            break;
        }
        default:
            break;
    }
}

- (void)setupChildControllers
{
    self.carsListController = [[CarsListViewController alloc] initWithNibName:NSStringFromClass([CarsListViewController class]) bundle:nil];
    [self.carsListController.view setFrame:self.carsListHolder.frame];
    [self.carsListHolder addSubview:self.carsListController.view];
    [self addChildViewController:self.carsListController];
    [self.carsListController didMoveToParentViewController:self];
    //setup completion block for carsListController to determine what car has been selected
    [self handleCarSelection];
    
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
        
        //setup the delegate
        self.carsFiltersController.delegate = self;
                
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
    [self.view addSubview:childView];
    //to correct the appearance of left panel
    [self.view bringSubviewToFront:self.searchView];
    
    [UIView animateWithDuration:kSlideTiming delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         childView.frame = self.carsListHolder.frame;
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             self.carsFiltersController.state = CSTFiltersPanelStateOpened;
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
        self.carsFiltersController.state = CSTFiltersPanelStateClosed;
    }
}

- (void)handleCarSelection {
    WEAK_SELF;
    [self.carsListController setCarSelectedCompletion:^(CSTCar *car) {
        weakSelf.carDetailsController.currentCar = car;
    }];
}

#pragma mark - Gestures Actions

- (void)setupGestures
{
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(movePanel:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    
    [self.view addGestureRecognizer:panRecognizer];
}

-(void)movePanel:(UIPanGestureRecognizer *)gesture
{
    NSUInteger filtersPanelState = self.carsFiltersController.state;
    
    [gesture.view.layer removeAllAnimations];
    
    CGPoint velocity = [gesture velocityInView:gesture.view];
    
    if(gesture.state == UIGestureRecognizerStateBegan) {
        if(velocity.x > 0 && filtersPanelState == CSTFiltersPanelStateClosed) {
            [self showFilters];
        } else {
            [self movePanelToOriginalPosition];
        }
    }
}

#pragma mark - CSTCarsFiltersDelegate

- (void)carsFiltersController:(CarsFiltersViewController *)controller didSelectFiltersForCarSearch:(NSDictionary *)filters
{
    [self.carsListController getCarsListWithFilters:filters];
    [self movePanelToOriginalPosition];
}

@end
