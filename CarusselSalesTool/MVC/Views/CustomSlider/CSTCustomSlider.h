//
//  CSTCustomSlider.h
//  CarusselSalesTool
//
//  Created by Eugenity on 03.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CSTSliderPopup;

@interface CSTCustomSlider : UISlider

@property (weak, nonatomic) IBOutlet CSTSliderPopup *popupView;

@end
