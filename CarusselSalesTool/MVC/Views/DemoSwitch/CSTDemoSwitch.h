//
//  CSTDemoSwitch.h
//  CarusselSalesTool
//
//  Created by Eugenity on 10.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CSTDemoSwitchDelegate <NSObject>

- (void)changeTabBarItemsEnabled:(BOOL)enabled;

@end

@interface CSTDemoSwitch : UISwitch

@property (nonatomic, weak) id<CSTDemoSwitchDelegate> delegate;

@end
