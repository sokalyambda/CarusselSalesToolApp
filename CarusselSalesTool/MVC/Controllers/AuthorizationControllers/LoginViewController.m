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

static NSString *const kMainTabBarSegue = @"mainTabBarSegue";

@interface LoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *authScrollView;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (strong, nonatomic) UITextField *activeField;
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
    [self handleKeyboardNotifications];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Actions

- (IBAction)loginClick:(id)sender
{
    [self performSegueWithIdentifier:kMainTabBarSegue sender:self];
    /*
    if (![self.validator validateEmailField:self.userNameField andPasswordField:self.passwordField]) {
        
        NSMutableString *errString = self.validator.validationErrorString;
        
        ShowTitleAlert(NSLocalizedString(@"Warning!", nil), errString);
        
        [self.validator cleanValidationErrorString];
    } else {
        //TODO: Login action
        [self performSegueWithIdentifier:@"homeScreenSegue" sender:self];
    }
     */
}

- (IBAction)remindPasswordClick:(id)sender
{
    /*
    if (![self.validator validateEmailField:self.userNameField]) {
        
        NSMutableString *errString = self.validator.validationErrorString;
        
        ShowTitleAlert(NSLocalizedString(@"Warning!", nil), errString);
        
        [self.validator cleanValidationErrorString];
    } else {
        //TODO: RemindPassword action
    }
     */
}

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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kMainTabBarSegue]) {
//        HomeViewController *controller = (HomeViewController *)segue.destinationViewController;
    }
}

@end
