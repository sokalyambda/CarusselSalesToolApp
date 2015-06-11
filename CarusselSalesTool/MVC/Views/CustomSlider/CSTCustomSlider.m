//
//  CSTCustomSlider.m
//  CarusselSalesTool
//
//  Created by Eugenity on 03.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTCustomSlider.h"
#import "CSTSliderPopup.h"
#import "UIView+MakeFromXib.h"

@implementation CSTCustomSlider

#pragma mark - Accessors

- (CGRect)thumbRect
{
    CGRect trackRect = [self trackRectForBounds:self.bounds];
    CGRect thumbRect = [self thumbRectForBounds:self.bounds
                                   trackRect:trackRect
                                       value:self.value];
    return thumbRect;
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

- (void)commonInit
{
    self.popupView = [CSTSliderPopup makeFromXib];
    self.popupView.backgroundColor = [UIColor clearColor];
    self.popupView.alpha = 0.0;
    [self addSubview:self.popupView];
}

#pragma mark - Actions

- (void)fadePopupViewInAndOut:(BOOL)aFadeIn
{
    WEAK_SELF;
    [UIView animateWithDuration:.5f animations:^{
        if (aFadeIn) {
            weakSelf.popupView.alpha = 1.f;
        } else {
            weakSelf.popupView.alpha = 0.f;
        }
    }];
}

- (void)positionAndUpdatePopupView
{
    CGRect thumbRect = self.thumbRect;
    CGRect popupRect = CGRectOffset(thumbRect, 0.f, -(thumbRect.size.height * 1.5f));
    self.popupView.frame = CGRectInset(popupRect, -20.f, -10.f);
    self.popupView.value = self.value;
}

#pragma mark - UIControl touch event tracking

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    // Fade in and update the popup view
    CGPoint touchPoint = [touch locationInView:self];
    // Check if the knob is touched. Only in this case show the popup-view
    if (CGRectContainsPoint(self.thumbRect, touchPoint)) {
        [self positionAndUpdatePopupView];
        [self fadePopupViewInAndOut:YES];
    }
    return [super beginTrackingWithTouch:touch withEvent:event];
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    // Update the popup view as slider knob is being moved
    [self positionAndUpdatePopupView];
    return [super continueTrackingWithTouch:touch withEvent:event];
}

- (void)cancelTrackingWithEvent:(UIEvent *)event
{
    [super cancelTrackingWithEvent:event];
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    // Fade out the popoup view
    [self fadePopupViewInAndOut:NO];
    [super endTrackingWithTouch:touch withEvent:event];
}

@end
