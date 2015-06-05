//
//  CarsListViewController.h
//  CarusselSalesTool
//
//  Created by Eugenity on 26.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CSTCar;

typedef void(^CarSelectedCompletion)(CSTCar *car);

@interface CarsListViewController : UIViewController

@property (copy, nonatomic) CarSelectedCompletion carSelectedCompletion;

@end
