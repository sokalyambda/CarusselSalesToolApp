//
//  CSTUnderlinedButton.m
//  CarusselSalesTool
//
//  Created by Eugenity on 09.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTUnderlinedButton.h"

@implementation CSTUnderlinedButton

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
    self.titleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:12.f];
    self.titleLabel.textColor = UIColorFromRGB(0x858585);
}

- (void)drawRect:(CGRect)rect
{
    CGFloat descender = self.titleLabel.font.descender;
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    // set to same color as text
    CGContextSetStrokeColorWithColor(contextRef, self.titleLabel.textColor.CGColor);
    
    CGContextMoveToPoint(contextRef, rect.origin.x, rect.origin.y + rect.size.height + descender);
    
    CGContextAddLineToPoint(contextRef, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height + descender);
    
    CGContextClosePath(contextRef);
    
    CGContextDrawPath(contextRef, kCGPathStroke);
}


@end
