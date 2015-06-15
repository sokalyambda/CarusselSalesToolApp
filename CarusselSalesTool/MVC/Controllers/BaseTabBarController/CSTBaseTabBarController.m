//
//  CSTBaseTabBarController.m
//  CarusselSalesTool
//
//  Created by Eugenity on 05.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

typedef enum : NSUInteger {
    CSTSelectedControllerTypeCarsList,
    CSTSelectedControllerTypeProspectsList,
    CSTSelectedControllerTypeAddNewProspect,
    CSTSelectedControllerTypeTasksList,
    CSTSelectedControllerTypeLogout
} CSTSelectedControllerType;

#import "CSTBaseTabBarController.h"
#import "CSTCommonTopController.h"

#import "CSTDemoSwitch.h"

static CGFloat const kTopViewHeight = 48.f;
static CGFloat const kStatusBarHeight = 20.f;

static NSString *const kTabBarSettingsFileName = @"TabBarSettings";

static NSString *const kFirstImageName          = @"firstImageName";
static NSString *const kSecondImageName         = @"secondImageName";
static NSString *const kThirdImageName          = @"thirdImageName";
static NSString *const kFourthImageName         = @"fourthImageName";
static NSString *const kFifthImageName          = @"fifthImageName";
static NSString *const kFirstSelectedImageName  = @"firstSelectedImageName";
static NSString *const kSecondSelectedImageName = @"secondSelectedImageName";
static NSString *const kThirdSelectedImageName  = @"thirdSelectedImageName";
static NSString *const kFourthSelectedImageName = @"fourthSelectedImageName";
static NSString *const kFifthSelectedImageName  = @"fifthSelectedImageName";
static NSString *const kSelectionIndicatorName  = @"selectionIndicatorImageName";


@interface CSTBaseTabBarController () <UITabBarControllerDelegate, CSTDemoSwitchDelegate>

@property (strong, nonatomic) CSTCommonTopController *topController;

@property (strong, nonatomic) NSDictionary *tabBarSettings;

@end

@implementation CSTBaseTabBarController

#pragma mark - Accessors

- (NSDictionary *)tabBarSettings
{
    if (!_tabBarSettings) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:kTabBarSettingsFileName ofType:@"plist"];
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
        _tabBarSettings = dict;
    }
    return _tabBarSettings;
}

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
    UIImage *selectedItemBackground = [UIImage imageNamed:self.tabBarSettings[kSelectionIndicatorName]];
    
    [self.tabBar setSelectionIndicatorImage:selectedItemBackground];
    self.delegate = self;

    [self reInitTabBaItems];
}

- (void)addTopController
{
    self.topController = [[CSTCommonTopController alloc] initWithNibName:NSStringFromClass([CSTCommonTopController class]) bundle:nil];
    [self.topController.view setFrame:CGRectMake(0, kStatusBarHeight, CGRectGetWidth(self.view.frame), kTopViewHeight)];
    [self.view addSubview:self.topController.view];
    [self addChildViewController:self.topController];
    [self.topController didMoveToParentViewController:self];
    
    self.topController.demoSwitch.delegate = self;
}

- (void)reInitTabBaItems
{
    //load images for icons
    UIImage *firstImage             = [[UIImage imageNamed:self.tabBarSettings[kFirstImageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *secondImage            = [[UIImage imageNamed:self.tabBarSettings[kSecondImageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *thirdImage             = [[UIImage imageNamed:self.tabBarSettings[kThirdImageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *fourthImage            = [[UIImage imageNamed:self.tabBarSettings[kFourthImageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *fifthImage             = [[UIImage imageNamed:self.tabBarSettings[kFifthImageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *firstSelectedImage     = [[UIImage imageNamed:self.tabBarSettings[kFirstSelectedImageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *secondSelectedImage    = [[UIImage imageNamed:self.tabBarSettings[kSecondSelectedImageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *thirdSelectedImage     = [[UIImage imageNamed:self.tabBarSettings[kThirdSelectedImageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *fourthSelectedImage    = [[UIImage imageNamed:self.tabBarSettings[kFourthSelectedImageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *fifthSelectedImage     = [[UIImage imageNamed:self.tabBarSettings[kFifthSelectedImageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
    for (UITabBarItem *item in self.tabBar.items) {
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xCCCFD1)} forState:UIControlStateNormal];
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: UIColorFromRGB(0x336666), NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    }

    //get the tab bar elements
    UITabBarItem *firstItem     = self.tabBar.items[0];
    UITabBarItem *secondItem    = self.tabBar.items[1];
    UITabBarItem *thirdItem     = self.tabBar.items[2];
    UITabBarItem *fourthItem    = self.tabBar.items[3];
    UITabBarItem *fifthItem     = self.tabBar.items[4];
    
    firstItem = [firstItem initWithTitle:NSLocalizedString(@"Cars", nil) image:firstImage selectedImage:firstSelectedImage];
    secondItem = [secondItem initWithTitle:NSLocalizedString(@"Prospects", nil) image:secondImage selectedImage:secondSelectedImage];
    thirdItem = [thirdItem initWithTitle:NSLocalizedString(@"Add Prospect", nil) image:thirdImage selectedImage:thirdSelectedImage];
    fourthItem = [fourthItem initWithTitle:NSLocalizedString(@"Tasks", nil) image:fourthImage selectedImage:fourthSelectedImage];
    fifthItem = [fifthItem initWithTitle:NSLocalizedString(@"Logout", nil) image:fifthImage selectedImage:fifthSelectedImage];
}

#pragma mark - UITabBarControllerDelegaet

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    //TODO: logout logic
    if (self.selectedIndex == CSTSelectedControllerTypeLogout) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)changeTabBarItemsEnabled:(BOOL)enabled
{
    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem *tabBarItem, NSUInteger idx, BOOL *stop) {
        if (idx % 4 != 0) {
            tabBarItem.enabled = !enabled;
        }
    }];
    
    if (self.selectedIndex != CSTSelectedControllerTypeCarsList) {
        [self setSelectedIndex:0];
    }
}
@end
