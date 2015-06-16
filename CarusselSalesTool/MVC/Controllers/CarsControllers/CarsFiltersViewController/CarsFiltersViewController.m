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

static CGFloat kSlideTiming = 0.5f;

@interface CarsFiltersViewController () <UITextFieldDelegate, UITextViewDelegate, UIGestureRecognizerDelegate>

@property (assign, nonatomic) CGRect hiddenFrame;

@property (weak, nonatomic) IBOutlet UIView *scrollContainer;
@property (weak, nonatomic) IBOutlet UIView *searchView;

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

#pragma mark - Accessors

- (CGRect)hiddenFrame
{
    if (CGRectEqualToRect(_hiddenFrame, CGRectZero)) {
        _hiddenFrame = (CGRect) {
            .origin = CGPointMake(-CGRectGetWidth(self.containerFrame) + CGRectGetWidth(self.searchView.frame), CGRectGetMinY(self.containerFrame)),
            .size = self.containerFrame.size
        };
    }
    return _hiddenFrame;
}

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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setupGestures];
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
    [self movePanelToOriginalPosition];
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

#pragma mark - Filters methods

- (IBAction)showFiltersClick:(id)sender
{
    NSUInteger filtersPanelState = self.state;
    switch (filtersPanelState) {
        case CSTFiltersPanelStateOpened: {
            [self movePanelToOriginalPosition];
            break;
        }
        case CSTFiltersPanelStateClosed: {
            [self showFilters];
            break;
        }
        default:
            break;
    }
}

- (void)showFilters
{
    WEAK_SELF;
    [UIView animateWithDuration:kSlideTiming delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.view.frame = self.containerFrame;
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             weakSelf.state = CSTFiltersPanelStateOpened;
                             weakSelf.carsFiltersScrollView.scrollEnabled = YES;
                         }
                     }];
}

- (void)movePanelToOriginalPosition
{
    WEAK_SELF;
    [UIView animateWithDuration:kSlideTiming delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         weakSelf.view.frame = weakSelf.hiddenFrame;
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [weakSelf resetFiltersPanel];
                         }
                     }];
}

- (void)resetFiltersPanel
{
    self.state = CSTFiltersPanelStateClosed;
    self.carsFiltersScrollView.contentOffset = CGPointZero;
    self.carsFiltersScrollView.scrollEnabled = NO;
}

#pragma mark - DropDown methods

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

#pragma mark - UIGestureRecognizer methods

- (void)setupGestures
{
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(movePanel:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    
    [self.view addGestureRecognizer:panRecognizer];
}

-(void)movePanel:(UIPanGestureRecognizer *)gesture
{
    NSUInteger filtersPanelState = self.state;
    
    CGPoint velocity = [gesture velocityInView:gesture.view];
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        if (velocity.x > 0 && filtersPanelState == CSTFiltersPanelStateClosed) {
            [self showFilters];
        } else if (velocity.x < 0 && filtersPanelState == CSTFiltersPanelStateOpened) {
            [self movePanelToOriginalPosition];
        }
    }
}

#pragma mark - Keyboard methods

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

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // Disallow recognition of tap gestures in the UISwitch.
    if ([touch.view isKindOfClass:[UISlider class]]) {
        return NO;
    }
    return YES;
}

@end
