//
//  LoginViewController.m
//  CarusselSalesTool
//
//  Created by Eugenity on 26.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "LoginViewController.h"

#import "CSTAuthorizationTextField.h"

#import "CSTValidator.h"
#import "CSTDataManager.h"

static NSString *const kMainTabBarSegue = @"mainTabBarSegue";

@interface LoginViewController () <UITextFieldDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *authScrollView;
@property (weak, nonatomic) IBOutlet CSTAuthorizationTextField *userNameField;
@property (weak, nonatomic) IBOutlet CSTAuthorizationTextField *passwordField;

@property (strong, nonatomic) UITextField *activeField;
@property (strong, nonatomic) CSTValidator *validator;

@end

@implementation LoginViewController

#pragma mark - Accessors

- (CSTValidator *)validator
{
    if (!_validator) {
        _validator = [CSTValidator sharedValidator];
    }
    return _validator;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self customizeFields];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [self handleKeyboardNotifications];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Actions

- (IBAction)loginClick:(id)sender
{
    WEAK_SELF;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[CSTDataManager sharedInstance] signInWithUserName:self.userNameField.text password:self.passwordField.text withResult:^(BOOL success, NSError *error) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        success ? [weakSelf performSegueWithIdentifier:kMainTabBarSegue sender:weakSelf] : ShowErrorAlert(error);
    }];
}

- (IBAction)remindPasswordClick:(id)sender
{
    UIAlertView *forgotPassword = [[UIAlertView alloc] initWithTitle:@"Forgot password" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Forgot", nil];
    forgotPassword.alertViewStyle = UIAlertViewStylePlainTextInput;
    [forgotPassword textFieldAtIndex:0].placeholder = @"Please enter your email";
    [forgotPassword show];
}

#pragma mark - Metods

- (void)handleKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)customizeFields
{
    [self.userNameField setImageName:@"icn_user_login"];
    [self.passwordField setImageName:@"icn_pass"];
}

#pragma mark - Keyboard methods

- (void)keyboardWillShow:(NSNotification*) notification
{
    NSDictionary* info = [notification userInfo];
    CGRect keyBoardFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    keyBoardFrame = [self.view convertRect:keyBoardFrame fromView:nil];
    
    CGSize kbSize = keyBoardFrame.size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.authScrollView.contentInset = contentInsets;
    self.authScrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;

    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        [self.authScrollView scrollRectToVisible:self.activeField.frame animated:YES];
    }
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.authScrollView.contentInset = contentInsets;
    self.authScrollView.scrollIndicatorInsets = contentInsets;
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

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeField = nil;
}

#pragma mark - UIAlertViewDalegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.alertViewStyle == UIAlertViewStylePlainTextInput && buttonIndex != alertView.cancelButtonIndex) {
        self.validator.validationErrorString = [[NSMutableString alloc] initWithString:@""];
        UITextField *textField = [alertView textFieldAtIndex:0];
        if ([self.validator validateEmailField:textField]) {
            NSLog(@"%@", textField.text);
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:self.validator.validationErrorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    }
}

@end
