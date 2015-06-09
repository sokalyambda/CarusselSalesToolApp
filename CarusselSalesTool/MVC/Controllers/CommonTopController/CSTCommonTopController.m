//
//  CSTCommonTopController.m
//  CarusselSalesTool
//
//  Created by Eugenity on 08.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTCommonTopController.h"

@interface CSTCommonTopController ()
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *notificationsCountLabel;

@end

@implementation CSTCommonTopController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Actions

- (IBAction)demoModeClick:(UISwitch *)demoSwitch {
    NSLog(@"us on? %i", demoSwitch.isOn);
}


@end
