//
//  CSTBorderedTextField.m
//  CarusselSalesTool
//
//  Created by Eugenity on 02.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTBorderedTextField.h"

static CGFloat kLeftViewWidth = 10.f;

@interface CSTBorderedTextField ()

@end

@implementation CSTBorderedTextField

#pragma mark - Init

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
    if (!self.background) {
        [self setBackground:[UIImage imageNamed:@"username_box"]];
    }
    [self addLeftView];
    
    self.font = [UIFont fontWithName:@"Lato-Light" size:14.f];
    self.textColor = UIColorFromRGB(0x405663);
}

- (void)addLeftView
{
    self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kLeftViewWidth, CGRectGetHeight(self.frame))];
    self.leftViewMode = UITextFieldViewModeAlways;
}

@end
