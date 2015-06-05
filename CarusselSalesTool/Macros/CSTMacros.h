//
//  CSTMacros.h
//  Periop
//
//  Created by Admin on 02.10.14.
//  Copyright (c) 2014 Thinkmobiles. All rights reserved.
//

@interface CSTMacros

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
#define IS_IPHONE_4 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height < ( double )481 ) )
#define IS_IPHONE_6 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 667)
#define WEAK_SELF __weak typeof(self) weakSelf = self

#define IS_IOS7_OR_BELOW ([UIDevice currentDevice].systemVersion.floatValue < 8.0)

#pragma mark - DebugLog

#ifndef DLog
#ifdef DEBUG
#define DLog(_format_, ...) NSLog(_format_, ## __VA_ARGS__)
#else
#define DLog(_format_, ...)
#endif
#endif

@end
