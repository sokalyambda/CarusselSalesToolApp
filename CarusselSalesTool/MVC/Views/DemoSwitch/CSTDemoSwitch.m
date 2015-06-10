//
//  CSTDemoSwitch.m
//  CarusselSalesTool
//
//  Created by Eugenity on 10.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTDemoSwitch.h"

@implementation CSTDemoSwitch

#pragma mark - Init

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
    [self addTarget:self action:@selector(stateChanged) forControlEvents:UIControlEventValueChanged];
    [self setOnTintColor:UIColorFromRGB(0xBeC5C9)];
    [self setTintColor:UIColorFromRGB(0x828D94)];
    [self setThumbTintColor:UIColorFromRGB(0x828D94)];
}

#pragma mark - Actions

- (void)stateChanged
{
    UIColor *thumbColor = nil;
    if (self.isOn) {
        thumbColor = UIColorFromRGB(0x30C175);
    } else {
        thumbColor = UIColorFromRGB(0x828D94);
    }
    
    WEAK_SELF;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.thumbTintColor = thumbColor;
    });
}

@end
