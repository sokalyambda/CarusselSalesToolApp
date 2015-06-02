//
//  ProspectDetailsViewController.m
//  CarusselSalesTool
//
//  Created by Eugenity on 26.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "ProspectDetailsViewController.h"

@interface ProspectDetailsViewController () <UITextFieldDelegate>

@property (strong, nonatomic) UITextField *activeField;
@property (weak, nonatomic) IBOutlet UIScrollView *prospectDetailsScrollView;

@end

@implementation ProspectDetailsViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self handleKeyboardNotifications];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Keyboard methods

- (void)keyboardWillShow:(NSNotification*) notification
{
    NSDictionary* info = [notification userInfo];
    CGRect keyBoardFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    keyBoardFrame = [self.view convertRect:keyBoardFrame fromView:nil];
    
    CGSize kbSize = keyBoardFrame.size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.prospectDetailsScrollView.contentInset = contentInsets;
    self.prospectDetailsScrollView.scrollIndicatorInsets = contentInsets;

    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    
    if (CGRectIntersectsRect(keyBoardFrame, self.activeField.frame)) {
        [self.prospectDetailsScrollView scrollRectToVisible:self.activeField.frame animated:YES];
    }
//    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
//        [self.prospectDetailsScrollView scrollRectToVisible:self.activeField.frame animated:YES];
//    }
}

- (void)keyboardWillHide:(NSNotification*) notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.prospectDetailsScrollView.contentInset = contentInsets;
    self.prospectDetailsScrollView.scrollIndicatorInsets = contentInsets;
}

#pragma mark - Actions

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

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeField = nil;
}



@end
