//
//  CSTUnderlinedButton.m
//  CarusselSalesTool
//
//  Created by Eugenity on 09.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTUnderlinedButton.h"

@implementation CSTUnderlinedButton

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
