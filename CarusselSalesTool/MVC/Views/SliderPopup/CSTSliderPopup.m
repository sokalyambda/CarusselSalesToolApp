//
//  CSTSliderPopup.m
//  CarusselSalesTool
//
//  Created by Eugenity on 11.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTSliderPopup.h"

static CGFloat const kArrowLength = 10.f;
static CGFloat const kCornerRadius = 6.f;

@interface CSTSliderPopup ()

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (strong, nonatomic) NSString *text;

@end

@implementation CSTSliderPopup

#pragma mark - Accessors

- (void)setValue:(CGFloat)aValue {
    _value = aValue;
    self.text = [NSString stringWithFormat:@"%li", (long)_value];
}

- (void)setText:(NSString *)text
{
    _text = text;
    self.textLabel.text = _text;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    
    // Set the fill color
    [UIColorFromRGB(0x33CC66) setFill];
    
    // Create the path for the rounded rectanble
    CGRect roundedRect = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) * 0.8f);
    UIBezierPath *roundedRectPath = [UIBezierPath bezierPathWithRoundedRect:roundedRect cornerRadius:kCornerRadius];
    
    // Create the arrow path
    UIBezierPath *arrowPath = [UIBezierPath bezierPath];
    CGFloat midX = CGRectGetMidX(self.bounds);
    CGPoint middleBottomPoint = CGPointMake(midX, CGRectGetMaxY(self.bounds));
    [arrowPath moveToPoint:middleBottomPoint];
    [arrowPath addLineToPoint:CGPointMake((midX - kArrowLength), CGRectGetMaxY(roundedRect))];
    [arrowPath addLineToPoint:CGPointMake((midX + kArrowLength), CGRectGetMaxY(roundedRect))];
    [arrowPath closePath];
    
    // Attach the arrow path to the buble
    [roundedRectPath appendPath:arrowPath];
    
    [roundedRectPath fill];
}

@end
