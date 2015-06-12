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

static CGFloat const kPaddingFromArrow = 5.f;
static CGFloat const kPopUpAppearanceTime = .25f;

@interface CSTCustomSlider ()

@property (assign, nonatomic, readonly) CGRect thumbRect;

@end

@implementation CSTCustomSlider

#pragma mark - Accessors

- (CGRect)thumbRect
{
    CGRect trackRect = [self trackRectForBounds:self.bounds];
    CGRect thumbRect = [self thumbRectForBounds:self.bounds
                                      trackRect:trackRect
                                          value:self.value];
    CGRect convertedRect = [self convertRect:thumbRect toView:self.superview];
    return convertedRect;
}

- (CSTSliderPopup *)popupView
{
    if (!_popupView) {
        [self addTarget:self action:@selector(updatePopoverFrame) forControlEvents:UIControlEventValueChanged];
        _popupView = [CSTSliderPopup makeFromXibWithFileOwner:self];
        [self updatePopoverFrame];
        _popupView.alpha = 0;
        [self.superview addSubview:_popupView];
    }
    
    return _popupView;
}

- (void)setValue:(float)value
{
    [super setValue:value];
    [self updatePopoverFrame];
}

#pragma mark - Actions

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self updatePopoverFrame];
    [self showPopUpView:YES];
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self showPopUpView:NO];
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self showPopUpView:NO];
    [super touchesCancelled:touches withEvent:event];
}

- (void)updatePopoverFrame
{
    self.popupView.center = CGPointMake(CGRectGetMidX(self.thumbRect), CGRectGetMidY(self.thumbRect) - CGRectGetHeight(self.thumbRect) - kPaddingFromArrow);
    self.popupView.value = self.value;
}

- (void)showPopUpView:(BOOL)show
{
    WEAK_SELF;
    if (show) {
        [UIView animateWithDuration:kPopUpAppearanceTime animations:^{
            weakSelf.popupView.alpha = 1.f;
        }];
    } else {
        [UIView animateWithDuration:kPopUpAppearanceTime animations:^{
            weakSelf.popupView.alpha = 0.f;
        }];
    }
}

@end
