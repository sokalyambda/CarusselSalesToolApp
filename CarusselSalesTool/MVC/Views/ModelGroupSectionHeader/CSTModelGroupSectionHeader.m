//
//  CSTModelGroupSectionHeader.m
//  CarusselSalesTool
//
//  Created by Eugenity on 08.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTModelGroupSectionHeader.h"

@implementation CSTModelGroupSectionHeader

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
    CALayer *bottomLayer = [CALayer layer],
    *topLeayer = [CALayer layer];
    CGRect frame = self.bounds;
    bottomLayer.frame = CGRectMake(0, CGRectGetHeight(frame) - 0.5f, CGRectGetWidth(frame), 0.5f);
    bottomLayer.backgroundColor = [UIColor whiteColor].CGColor;
    topLeayer.frame = CGRectMake(0, 0, CGRectGetWidth(frame), 0.5f);
    topLeayer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:topLeayer];
    [self.layer addSublayer:bottomLayer];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expandSection)];
    [self addGestureRecognizer:tap];
}

#pragma mark - IBActions

- (void)expandSection
{
    if ([self.delegate respondsToSelector:@selector(shouldExpandSectionFromHeader:)]) {
        [self.delegate shouldExpandSectionFromHeader:self];
    }
}

@end
