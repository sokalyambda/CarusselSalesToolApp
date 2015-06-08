//
//  CSTBaseTabBarController.m
//  CarusselSalesTool
//
//  Created by Eugenity on 05.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTBaseTabBarController.h"
#import "CSTCommonTopController.h"

static CGFloat const kTopViewHeight = 44.f;
static CGFloat const kStatusBarHeight = 20.f;

@interface CSTBaseTabBarController () <UITabBarControllerDelegate>

@property (strong, nonatomic) CSTCommonTopController *topController;

@end

@implementation CSTBaseTabBarController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTabBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self addTopController];
}

#pragma mark - Actions

- (void)initTabBar
{
    UIImage *selectedItemBackground = [UIImage imageNamed:@"btn_tab_bar_on"];
    [self.tabBar setSelectionIndicatorImage:selectedItemBackground];
    self.delegate = self;
    
    //load images for icons
    UIImage *firstImage             = [UIImage imageNamed:@"icn_cars"];
    UIImage *secondImage            = [UIImage imageNamed:@"icn_prospects"];
    UIImage *thirdImage             = [UIImage imageNamed:@"add_prospects"];
    UIImage *fourthImage            = [UIImage imageNamed:@"icn_tasks"];
    UIImage *firstSelectedImage     = [UIImage imageNamed:@"icn_cars_active"];
    UIImage *secondSelectedImage    = [UIImage imageNamed:@"icn_prospects_active"];
    UIImage *thirdSelectedImage     = [UIImage imageNamed:@"add_prospects_active"];
    UIImage *fourthSelectedImage    = [UIImage imageNamed:@"icn_tasks_active"];
    UIImage *fifthImage             = [UIImage imageNamed:@"logout"];
    UIImage *fifthSelectedImage     = [UIImage imageNamed:@"logout_active"];
    
    //get the tab bar elements
    UITabBarItem *firstItem     = self.tabBar.items[0];
    UITabBarItem *secondItem    = self.tabBar.items[1];
    UITabBarItem *thirdItem     = self.tabBar.items[2];
    UITabBarItem *fourthItem    = self.tabBar.items[3];
    UITabBarItem *fifthItem     = self.tabBar.items[4];
    
    for (UITabBarItem *item in self.tabBar.items) {
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateNormal];
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor darkGrayColor], NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    }
    
    //set up icons for all tabs and rendering mode for they
    firstImage = [firstImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    secondImage = [secondImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    thirdImage = [thirdImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    fourthImage = [fourthImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    fifthImage = [fifthImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    firstSelectedImage = [firstSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    secondSelectedImage = [secondSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    thirdSelectedImage = [thirdSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    fourthSelectedImage = [fourthSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    fifthSelectedImage = [fifthSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    firstItem = [firstItem initWithTitle:NSLocalizedString(@"Cars", nil) image:firstImage selectedImage:firstSelectedImage];
    secondItem = [secondItem initWithTitle:NSLocalizedString(@"Prospects", nil) image:secondImage selectedImage:secondSelectedImage];
    thirdItem = [thirdItem initWithTitle:NSLocalizedString(@"Add Prospect", nil) image:thirdImage selectedImage:thirdSelectedImage];
    fourthItem = [fourthItem initWithTitle:NSLocalizedString(@"Tasks", nil) image:fourthImage selectedImage:fourthSelectedImage];
    fifthItem = [fifthItem initWithTitle:NSLocalizedString(@"Logout", nil) image:fifthImage selectedImage:fifthSelectedImage];
}

- (void)addTopController
{
    self.topController = [[CSTCommonTopController alloc] initWithNibName:NSStringFromClass([CSTCommonTopController class]) bundle:nil];
    [self.topController.view setFrame:CGRectMake(0, kStatusBarHeight, CGRectGetWidth(self.view.frame), kTopViewHeight)];
    [self.view addSubview:self.topController.view];
    [self addChildViewController:self.topController];
    [self.topController didMoveToParentViewController:self];
}

#pragma mark - UITabBarControllerDelegaet

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    //TODO: logout logic
    if (self.selectedIndex == 4) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
