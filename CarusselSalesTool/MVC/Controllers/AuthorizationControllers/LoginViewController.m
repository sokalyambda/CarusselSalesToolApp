//
//  LoginViewController.m
//  CarusselSalesTool
//
//  Created by Eugenity on 26.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "LoginViewController.h"
#import "Validator.h"
#import "HomeViewController.h"

@interface LoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) Validator *validator;

@end

@implementation LoginViewController

#pragma mark - Accessors

- (Validator *)validator
{
    if (!_validator) {
        _validator = [Validator sharedValidator];
    }
    return _validator;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma mark - Actions

- (IBAction)loginClick:(id)sender
{
    if (![self.validator validateEmailField:self.userNameField andPasswordField:self.passwordField]) {
        
        NSMutableString *errString = self.validator.validationErrorString;
        
        ShowTitleAlert(NSLocalizedString(@"Warning!", nil), errString);
        
        [self.validator cleanValidationErrorString];
    } else {
        //TODO: Login action
        [self performSegueWithIdentifier:@"homeScreenSegue" sender:self];
    }
}

- (IBAction)remindPasswordClick:(id)sender
{
    if (![self.validator validateEmailField:self.userNameField]) {
        
        NSMutableString *errString = self.validator.validationErrorString;
        
        ShowTitleAlert(NSLocalizedString(@"Warning!", nil), errString);
        
        [self.validator cleanValidationErrorString];
    } else {
        //TODO: RemindPassword action
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.userNameField isFirstResponder]) {
        [self.passwordField becomeFirstResponder];
    } else if ([self.passwordField isFirstResponder]) {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"homeScreenSegue"]) {
//        HomeViewController *controller = (HomeViewController *)segue.destinationViewController;
    }
}

@end
