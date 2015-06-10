//
//  CSTCommonSearchBar.m
//  CarusselSalesTool
//
//  Created by Eugenity on 09.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTCommonSearchBar.h"

@implementation CSTCommonSearchBar

#pragma mark - Accessors

- (void)setRightImageName:(NSString *)rightImageName
{
    _rightImageName = rightImageName;
    [self addRightSearchImage];
}

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

#pragma mark - Actions

- (void)addRightSearchImage
{
    UITextField *searchField = [self valueForKey:@"_searchField"];
    UIImageView *searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.rightImageName]];
    
    [searchField setRightView:searchIcon];
    [searchField setLeftViewMode:UITextFieldViewModeNever];
    [searchField setRightViewMode:UITextFieldViewModeAlways];
    [searchField setClearButtonMode: UITextFieldViewModeNever];
}

- (void)commonInit
{
    [self setSearchFieldBackgroundImage:[UIImage imageNamed:@"search_field"] forState:UIControlStateNormal];
    [self setSearchTextPositionAdjustment:UIOffsetMake(10.f, 0)];
    [self setBarTintColor:[UIColor clearColor]];
    
    self.barTintColor = [UIColor clearColor];
    self.backgroundImage = [UIImage new];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setFont:[UIFont fontWithName:@"Lato-Light" size:16]];
}

@end
