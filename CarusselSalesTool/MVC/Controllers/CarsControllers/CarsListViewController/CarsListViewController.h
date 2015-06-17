//
//  CarsListViewController.h
//  CarusselSalesTool
//
//  Created by Eugenity on 26.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CarsFiltersViewController.h"

@class CSTCar;
@protocol CSTCarsListDelegate;

@interface CarsListViewController : UIViewController<CSTCarsFiltersDelegate>

@property (weak, nonatomic) id<CSTCarsListDelegate> delegate;

@end

@protocol CSTCarsListDelegate <NSObject>

@optional
- (void)carsListTable:(UITableView *)carsListTable didSelectCar:(CSTCar *)car;

@end
