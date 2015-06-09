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

@interface CarsFiltersViewController : UIViewController

@property (assign, nonatomic) CSTFiltersPanelState state;

@end
