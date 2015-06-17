//
//  CarsFiltersViewController.h
//  CarusselSalesTool
//
//  Created by Eugenity on 26.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

typedef enum : NSUInteger {
    CSTFiltersPanelStateClosed,
    CSTFiltersPanelStateOpened
} CSTFiltersPanelState;

#import <UIKit/UIKit.h>

@class CarsFiltersViewController;
@protocol CSTCarsFiltersDelegate;

@interface CarsFiltersViewController : UIViewController

@property (assign, nonatomic) CSTFiltersPanelState state;

@property (assign, nonatomic) CGRect containerFrame;


@property (weak, nonatomic) id<CSTCarsFiltersDelegate> delegate;

@end

@protocol CSTCarsFiltersDelegate <NSObject>

@optional
- (void)carsFiltersController:(CarsFiltersViewController *)controller didSelectFiltersForCarSearch:(NSDictionary *)filters;

@end