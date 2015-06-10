//
//  CSTBadgeLabel.m
//  CarusselSalesTool
//
//  Created by Eugenity on 10.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTBadgeLabel.h"

@implementation CSTBadgeLabel

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.layer.backgroundColor = UIColorFromRGB(0x33CC66).CGColor;
    self.layer.cornerRadius = CGRectGetHeight(self.bounds) / 2;
}

@end
