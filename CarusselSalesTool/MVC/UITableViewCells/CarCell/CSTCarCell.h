//
//  CarCell.h
//  CarusselSalesTool
//
//  Created by Eugenity on 26.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CSTCar;

@interface CSTCarCell : UITableViewCell

- (void)configureCellWithCar:(CSTCar *)car;

@end