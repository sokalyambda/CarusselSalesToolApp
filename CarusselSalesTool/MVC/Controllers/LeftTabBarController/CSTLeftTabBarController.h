//
//  CSTLeftTabBarController.h
//  CarusselSalesTool
//
//  Created by Eugenity on 02.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSTLeftTabBarController : UIViewController

@property (nonatomic, strong) UIViewController *currentViewController;
@property (nonatomic, weak) IBOutlet UIView *placeholderView;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *tabBarButtons;

- (void)setSelectedIndex:(int)index;

@end
