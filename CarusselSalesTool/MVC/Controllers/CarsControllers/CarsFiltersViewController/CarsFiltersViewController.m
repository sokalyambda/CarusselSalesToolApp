//
//  CarsFiltersViewController.m
//  CarusselSalesTool
//
//  Created by Eugenity on 26.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CarsFiltersViewController.h"
#import "CSTBorderedPlaceholderTextView.h"

@interface CarsFiltersViewController ()

@property (weak, nonatomic) IBOutlet UILabel *priceValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *mileageValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *perfomanceValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *displacementValueLabel;
@property (weak, nonatomic) IBOutlet CSTBorderedPlaceholderTextView *extraDataTextView;

@end

@implementation CarsFiltersViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.extraDataTextView.placeholder = NSLocalizedString(@"Extra data", nil);
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

@end
