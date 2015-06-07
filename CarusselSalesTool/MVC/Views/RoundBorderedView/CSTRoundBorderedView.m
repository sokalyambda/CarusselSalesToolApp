//
//  CSTRoundBorderedView.m
//  CarusselSalesTool
//
//  Created by Eugenity on 04.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTRoundBorderedView.h"

@implementation CSTRoundBorderedView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
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
//    self.backgroundColor = [UIColor colorWithWhite:.9f alpha:.5f];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 7.f;
    self.layer.borderWidth = 2.f;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

@end
