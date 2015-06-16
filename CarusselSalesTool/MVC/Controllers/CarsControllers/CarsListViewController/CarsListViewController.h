//
//  CarsListViewController.h
//  CarusselSalesTool
//
//  Created by Eugenity on 26.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CarsFiltersViewController.h"

@class CSTCar;

typedef void(^CarSelectedCompletion)(CSTCar *car);

@interface CarsListViewController : UIViewController<CSTCarsFiltersDelegate>

@property (copy, nonatomic) CarSelectedCompletion carSelectedCompletion;

- (void)getCarsListPage:(NSUInteger)page withFilters:(NSDictionary *)filters;

@end
