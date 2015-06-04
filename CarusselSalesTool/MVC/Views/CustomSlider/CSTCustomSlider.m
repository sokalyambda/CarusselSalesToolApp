//
//  CSTCustomSlider.m
//  CarusselSalesTool
//
//  Created by Eugenity on 03.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTCustomSlider.h"

@implementation CSTCustomSlider

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    [self setThumbImage:self.currentThumbImage forState:UIControlStateNormal];
    
    self.maximumTrackTintColor = [UIColor lightGrayColor];
    self.thumbTintColor = [UIColor lightGrayColor];
    self.minimumTrackTintColor = [UIColor darkGrayColor];
}


@end
