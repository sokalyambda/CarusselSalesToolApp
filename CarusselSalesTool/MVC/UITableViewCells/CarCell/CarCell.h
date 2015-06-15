//
//  CarCell.h
//  CarusselSalesTool
//
//  Created by Eugenity on 26.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *carImage;
@property (weak, nonatomic) IBOutlet UILabel *carPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *carTitleLabel;

@end
