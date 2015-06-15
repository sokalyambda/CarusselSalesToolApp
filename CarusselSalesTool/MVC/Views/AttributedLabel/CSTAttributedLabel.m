//
//  CSTAttributedLabel.m
//  CarusselSalesTool
//
//  Created by Eugenity on 04.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTAttributedLabel.h"

@implementation CSTAttributedLabel

- (void)setText:(NSString *)text withAttributedWordsCount:(NSUInteger)wordsCount withColor:(UIColor *)color
{
    NSRange wordRange = NSMakeRange(0, wordsCount);
    NSArray *firstWords = [[text componentsSeparatedByString:@" "] subarrayWithRange:wordRange];
    
    __block NSUInteger allCharactersCount = 0;
    
    [firstWords enumerateObjectsUsingBlock:^(NSString *string, NSUInteger idx, BOOL *stop) {
        allCharactersCount += string.length;
    }];
    
    NSMutableAttributedString *attText =
    [[NSMutableAttributedString alloc]
     initWithString:text];
    [attText addAttribute:NSForegroundColorAttributeName
                      value:color
                      range:NSMakeRange(0, allCharactersCount)];
    [self setAttributedText:attText];
}

@end
