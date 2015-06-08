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
