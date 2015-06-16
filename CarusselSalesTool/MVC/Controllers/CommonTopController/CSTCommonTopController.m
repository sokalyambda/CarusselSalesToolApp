//
//  CSTCommonTopController.m
//  CarusselSalesTool
//
//  Created by Eugenity on 08.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTCommonTopController.h"

#import "KeychainItemWrapper.h"

#import "CSTDemoSwitch.h"

@interface CSTCommonTopController () <UIAlertViewDelegate>

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
    if (!demoSwitch.isOn) {
        UIAlertView *passwordAlert = [[UIAlertView alloc] initWithTitle:@"Please enter password" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Done", nil];
        passwordAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [passwordAlert textFieldAtIndex:0].placeholder = @"Please enter your email";
        [passwordAlert show];
    } else {
        if ([demoSwitch.delegate respondsToSelector:@selector(changeTabBarItemsEnabled:)]) {
            [demoSwitch.delegate changeTabBarItemsEnabled:demoSwitch.isOn];
        }
    }
}

#pragma mark - AlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.alertViewStyle == UIAlertViewStylePlainTextInput && buttonIndex != alertView.cancelButtonIndex) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"Password" accessGroup:nil];
        NSString *password = [wrapper objectForKey:(__bridge id)(kSecValueData)];
        if ([password isEqualToString:textField.text]) {
            if ([self.demoSwitch.delegate respondsToSelector:@selector(changeTabBarItemsEnabled:)]) {
                [self.demoSwitch.delegate changeTabBarItemsEnabled:self.demoSwitch.isOn];
            }
        } else {
            [self.demoSwitch setOn:!self.demoSwitch.isOn animated:YES];
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"You entered incorrect password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    }
}

@end
