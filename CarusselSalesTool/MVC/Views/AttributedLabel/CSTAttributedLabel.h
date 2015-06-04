//
//  CSTAttributedLabel.h
//  CarusselSalesTool
//
//  Created by Eugenity on 04.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSTAttributedLabel : UILabel

- (void)setText:(NSString *)text withAttributedWordsCount:(NSUInteger)wordsCount withColor:(UIColor *)color;

@end
