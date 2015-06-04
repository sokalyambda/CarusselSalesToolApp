//
//  CarsFiltersViewController.m
//  CarusselSalesTool
//
//  Created by Eugenity on 26.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CarsFiltersViewController.h"
#import "CSTBorderedPlaceholderTextView.h"

@interface CarsFiltersViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *priceValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *mileageValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *perfomanceValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *displacementValueLabel;
@property (weak, nonatomic) IBOutlet CSTBorderedPlaceholderTextView *extraDataTextView;
@property (weak, nonatomic) IBOutlet UIScrollView *carsFiltersScrollView;

@property (strong, nonatomic) UIView *activeField;

@end

@implementation CarsFiltersViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self handleKeyboardNotifications];
    self.extraDataTextView.placeholder = NSLocalizedString(@"Extra Data", nil);
}

#pragma mark - Actions

- (IBAction)priceSliderAction:(UISlider *)slider
{
    self.priceValueLabel.text = [NSString stringWithFormat:@"%f", slider.value];
}

- (IBAction)mileageSliderAction:(UISlider *)slider
{
    self.mileageValueLabel.text = [NSString stringWithFormat:@"%f", slider.value];
}

- (IBAction)perfomanceSliderAction:(UISlider *)slider
{
    self.perfomanceValueLabel.text = [NSString stringWithFormat:@"%f", slider.value];
}

- (IBAction)displacementSliderAction:(UISlider *)slider
{
    self.displacementValueLabel.text = [NSString stringWithFormat:@"%f", slider.value];
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

- (void)keyboardWillShow:(NSNotification*)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect keyBoardFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    keyBoardFrame = [self.view convertRect:keyBoardFrame fromView:nil];
    
    CGSize kbSize = keyBoardFrame.size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.carsFiltersScrollView.contentInset = contentInsets;
    self.carsFiltersScrollView.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardWillHide:(NSNotification*) notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.carsFiltersScrollView.contentInset = contentInsets;
    self.carsFiltersScrollView.scrollIndicatorInsets = contentInsets;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.carsFiltersScrollView scrollRectToVisible:self.extraDataTextView.frame animated:YES];
}

@end
