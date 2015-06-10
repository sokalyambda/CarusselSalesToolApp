//
//  CSTCommonTopController.m
//  CarusselSalesTool
//
//  Created by Eugenity on 08.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTCommonTopController.h"
#import "CSTDemoSwitch.h"

@interface CSTCommonTopController ()

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *notificationsCountLabel;

@end

@implementation CSTCommonTopController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CSTCompany *companyInfo = [CSTDataManager sharedInstance].companyInfo;
    self.userNameLabel.text = [NSString stringWithFormat:@"%@ %@", companyInfo.firstName, companyInfo.lastName];
}

#pragma mark - Actions

- (IBAction)demoModeClick:(CSTDemoSwitch *)demoSwitch {
    if ([demoSwitch.delegate respondsToSelector:@selector(changeTabBarItemsEnabled:)]) {
        [demoSwitch.delegate changeTabBarItemsEnabled:demoSwitch.isOn];
    }
}


@end
