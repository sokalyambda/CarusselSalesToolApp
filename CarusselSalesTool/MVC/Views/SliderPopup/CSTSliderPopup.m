//
//  CSTSliderPopup.m
//  CarusselSalesTool
//
//  Created by Eugenity on 11.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTSliderPopup.h"

@interface CSTSliderPopup ()

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation CSTSliderPopup

#pragma mark - Accessors

- (void)setValue:(CGFloat)aValue {
    _value = aValue;
    self.text = [NSString stringWithFormat:@"%4.2f", _value];
    [self setNeedsDisplay];
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
    [self.textLabel sizeToFit];
}

- (void)drawRect:(CGRect)rect {
    
    // Set the fill color
    [UIColorFromRGB(0x33CC66) setFill];
    
    // Create the path for the rounded rectanble
    CGRect roundedRect = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height * 0.8f);
    UIBezierPath *roundedRectPath = [UIBezierPath bezierPathWithRoundedRect:roundedRect cornerRadius:6.f];
    
    // Create the arrow path
    UIBezierPath *arrowPath = [UIBezierPath bezierPath];
    CGFloat midX = CGRectGetMidX(self.bounds);
    CGPoint p0 = CGPointMake(midX, CGRectGetMaxY(self.bounds));
    [arrowPath moveToPoint:p0];
    [arrowPath addLineToPoint:CGPointMake((midX - 10.f), CGRectGetMaxY(roundedRect))];
    [arrowPath addLineToPoint:CGPointMake((midX + 10.f), CGRectGetMaxY(roundedRect))];
    [arrowPath closePath];
    
    // Attach the arrow path to the buble
    [roundedRectPath appendPath:arrowPath];
    
    [roundedRectPath fill];
    
    // Draw the text
    if (self.text) {
        [self.textLabel setText:self.text];
    }
}

@end
