//
//  CarCell.m
//  CarusselSalesTool
//
//  Created by Eugenity on 26.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTCarCell.h"

@interface CSTCarCell ()

@property (weak, nonatomic) IBOutlet UIImageView *carImage;
@property (weak, nonatomic) IBOutlet UILabel *carPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *carTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *carYearLabel;
@property (weak, nonatomic) IBOutlet UILabel *carPowerLabel;
@property (weak, nonatomic) IBOutlet UILabel *carFuelLabel;
@property (weak, nonatomic) IBOutlet UILabel *carTransmissionLabel;

@end

@implementation CSTCarCell

- (UIEdgeInsets)layoutMargins
{
    return UIEdgeInsetsZero;
}

#pragma mark - Actions

- (void)configureCellWithCar:(CSTCar *)car
{
    self.carPriceLabel.text         = [NSString stringWithFormat:@"%li", (long)car.price];
    self.carTitleLabel.text         = car.title;
    self.carPowerLabel.text         = [NSString stringWithFormat:@"%likW/%lihp", (long)car.powerKw, (long)car.powerHp];
    self.carFuelLabel.text          = car.fuel.title;
    self.carTransmissionLabel.text  = car.transsmision.title;
    
    NSURL *carImageURL = [NSURL URLWithString:car.defaultImage.mediumUrl];
    if (![carImageURL isEqual:[NSNull null]]) {
        [self.carImage sd_setImageWithURL:carImageURL];
    }
}

@end
