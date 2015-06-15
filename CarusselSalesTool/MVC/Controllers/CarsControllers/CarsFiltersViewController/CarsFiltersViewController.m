//
//  CarsFiltersViewController.m
//  CarusselSalesTool
//
//  Created by Eugenity on 26.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CarsFiltersViewController.h"

#import "CSTBorderedPlaceholderTextView.h"
#import "DropDownTable.h"
#import "UIView+MakeFromXib.h"
#import "CSTBorderedTextField.h"
#import "CSTCustomSlider.h"

#import "CSTBaseDropDownDataSource.h"

@interface CarsFiltersViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *scrollContainer;

@property (weak, nonatomic) IBOutlet CSTBorderedPlaceholderTextView *extraDataTextView;
@property (weak, nonatomic) IBOutlet UIScrollView *carsFiltersScrollView;

@property (weak, nonatomic) IBOutlet CSTBorderedTextField *carMakeField;
@property (weak, nonatomic) IBOutlet CSTBorderedTextField *fuelTypeField;
@property (weak, nonatomic) IBOutlet CSTBorderedTextField *bodyTypeField;
@property (weak, nonatomic) IBOutlet CSTBorderedTextField *yearFromField;

@property (strong, nonatomic) UIView *activeField;
@property (strong, nonatomic) DropDownTable *dropDownTable;

@property (strong, nonatomic) NSMutableDictionary *chosenFiltersDictionary;

@end

@implementation CarsFiltersViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initDropDownTableView];
    self.extraDataTextView.placeholder = NSLocalizedString(@"Extra Data", nil);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self handleKeyboardNotifications];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Actions

- (IBAction)searchCarsClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(carsFiltersController:didSelectFiltersForCarSearch:)]) {
        self.chosenFiltersDictionary = [@{} mutableCopy];
        [self.delegate carsFiltersController:self didSelectFiltersForCarSearch:self.chosenFiltersDictionary];
    }
}

- (IBAction)priceSliderAction:(CSTCustomSlider *)slider
{

}

- (IBAction)mileageSliderAction:(CSTCustomSlider *)slider
{

}

- (IBAction)perfomanceSliderAction:(CSTCustomSlider *)slider
{

}

- (IBAction)displacementSliderAction:(CSTCustomSlider *)slider
{

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

- (void)initDropDownTableView
{
    self.dropDownTable = [DropDownTable makeFromXib];
}

- (CSTBaseDropDownDataSource *)getCurrentDataSourceForDropDownTableFromTextField:(UITextField *)textField
{
    CSTBaseDropDownDataSource *currentDataSource = nil;
    
    if ([textField isEqual:self.yearFromField]) {
        currentDataSource = [[CSTBaseDropDownDataSource alloc] initWithDataSourceType:CSTDropDownDataSourceTypeYearFrom];
    } else if ([textField isEqual:self.bodyTypeField]) {
        currentDataSource = [[CSTBaseDropDownDataSource alloc] initWithDataSourceType:CSTDropDownDataSourceTypeBodyType];
    } else if ([textField isEqual:self.fuelTypeField]) {
        currentDataSource = [[CSTBaseDropDownDataSource alloc] initWithDataSourceType:CSTDropDownDataSourceTypeFuelType];
    } else if ([textField isEqual:self.carMakeField]) {
        currentDataSource = [[CSTBaseDropDownDataSource alloc] initWithDataSourceType:CSTDropDownDataSourceTypeMakeCar];
    }
    
    return currentDataSource;
}

#pragma mark - Keyboard methods

- (void)keyboardWillShow:(NSNotification*)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect keyBoardFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    keyBoardFrame = [self.view convertRect:keyBoardFrame fromView:nil];
    
    CGRect dropDownFrame = self.dropDownTable.frame;
    
    CGSize kbSize = keyBoardFrame.size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    
    self.carsFiltersScrollView.contentInset = contentInsets;
    self.carsFiltersScrollView.scrollIndicatorInsets = contentInsets;
    
    if (self.dropDownTable.isExpanded && CGRectIntersectsRect(keyBoardFrame, dropDownFrame)) {
        CGPoint contentOffset = CGPointMake(0, CGRectGetMinY(self.activeField.frame));
        [self.carsFiltersScrollView setContentOffset:contentOffset animated:YES];
    }
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.carsFiltersScrollView.contentInset = contentInsets;
    self.carsFiltersScrollView.scrollIndicatorInsets = contentInsets;
    self.carsFiltersScrollView.contentOffset = CGPointZero;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.carsFiltersScrollView scrollRectToVisible:self.extraDataTextView.frame animated:YES];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeField = textField;
    CSTBaseDropDownDataSource *dataSource = [self getCurrentDataSourceForDropDownTableFromTextField:textField];
    
    [self.dropDownTable dropDownTableBecomeActiveInView:self.scrollContainer
                                         fromAnchorView:textField
                                         withDataSource:dataSource
                                         withCompletion:^(DropDownTable *dropDownTable, BOOL isExpanded, BOOL isApply) {
        NSLog(@"is apply? %i", isApply);
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeField = nil;
}

@end
