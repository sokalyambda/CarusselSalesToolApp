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
#import "CSTBaseDropDownDataSource.h"

@interface CarsFiltersViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *priceValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *mileageValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *perfomanceValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *displacementValueLabel;
@property (weak, nonatomic) IBOutlet CSTBorderedPlaceholderTextView *extraDataTextView;
@property (weak, nonatomic) IBOutlet UIScrollView *carsFiltersScrollView;

@property (weak, nonatomic) IBOutlet CSTBorderedTextField *carMakeField;
@property (weak, nonatomic) IBOutlet CSTBorderedTextField *fuelTypeField;
@property (weak, nonatomic) IBOutlet CSTBorderedTextField *bodyTypeField;
@property (weak, nonatomic) IBOutlet CSTBorderedTextField *yearFromField;

@property (strong, nonatomic) UIView *activeField;
@property (strong, nonatomic) DropDownTable *dropDownTable;

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

- (void)initDropDownTableView
{
    self.dropDownTable = [DropDownTable makeFromXib];
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

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CSTBaseDropDownDataSource *dataSource = [self getCurrentDataSourceForDropDownTableFromTextField:textField];
    
    [self.dropDownTable dropDownTableBecomeActiveInView:self.view
                                         fromAnchorView:textField
                                         withDataSource:dataSource
                                         withCompletion:^(DropDownTable *dropDownTable, BOOL isExpanded, BOOL isApply) {
        NSLog(@"is apply? %i", isApply);
    }];
}

- (CSTBaseDropDownDataSource *)getCurrentDataSourceForDropDownTableFromTextField:(UITextField *)textField
{
    CSTBaseDropDownDataSource *currentDataSource = nil;
    
    if ([textField isEqual:self.yearFromField]) {
        currentDataSource = [[CSTBaseDropDownDataSource alloc] initWithDataSourceType:DropDownDataSourceTypeYearFrom];
    } else if ([textField isEqual:self.bodyTypeField]) {
        currentDataSource = [[CSTBaseDropDownDataSource alloc] initWithDataSourceType:DropDownDataSourceTypeBodyType];
    } else if ([textField isEqual:self.fuelTypeField]) {
        currentDataSource = [[CSTBaseDropDownDataSource alloc] initWithDataSourceType:DropDownDataSourceTypeFuelType];
    } else if ([textField isEqual:self.carMakeField]) {
        currentDataSource = [[CSTBaseDropDownDataSource alloc] initWithDataSourceType:DropDownDataSourceTypeMakeCar];
    }
    
    return currentDataSource;
}

@end
