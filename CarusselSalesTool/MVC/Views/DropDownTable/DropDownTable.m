//
//  DropDownTable.m
//  CarusselSalesTool
//
//  Created by Eugenity on 27.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "DropDownTable.h"

static NSUInteger const kDropDownHeight = 300.f;
static CGFloat const kSlidingTime = .5f;

@interface DropDownTable ()

@property (copy, nonatomic) DropDownCompletionHandler completion;
@property (strong, nonatomic) UIView *anchorView;
@property (assign, nonatomic) BOOL isExpanded;

@end

@implementation DropDownTable {
    CGRect savedDropDownTableFrame;
}

#pragma mark - Accessors

- (void)setAnchorView:(UIView *)anchorView
{
    _anchorView = anchorView;
    
    CGPoint relatedPoint = [_anchorView.superview convertPoint:_anchorView.frame.origin toView:nil];
    
    savedDropDownTableFrame = CGRectMake(relatedPoint.x, CGRectGetMaxY(_anchorView.bounds) + relatedPoint.y, CGRectGetWidth(_anchorView.frame), 0);
    
    self.frame = savedDropDownTableFrame;
}

#pragma mark - Actions

- (void)dropDownTableBecomeActiveFromAnchorView:(UIView *)anchorView withCompletion:(DropDownCompletionHandler)completion
{
    self.completion = completion;
    
    if (![anchorView isEqual:self.anchorView]) {
        self.anchorView = anchorView;
        self.isExpanded = NO;
    }

    if (!self.isExpanded) {
        [UIView animateWithDuration:kSlidingTime animations:^{
            CGRect newFrame = self.frame;
            newFrame.size.height = kDropDownHeight;
            self.frame = newFrame;
        }];
    } else {
        [UIView animateWithDuration:kSlidingTime animations:^{
            self.frame = savedDropDownTableFrame;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    
    self.isExpanded = !self.isExpanded;
    
    if (self.completion) {
        self.completion(self, self.isExpanded);
    }
}

@end
