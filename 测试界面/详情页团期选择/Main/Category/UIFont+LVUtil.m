//
//  UIFont+LVUtil.m
//  Lvmm
//
//  Created by zhangxiaoxiang on 16/3/28.
//  Copyright © 2016年 Lvmama. All rights reserved.
//

#import "UIFont+LVUtil.h"
//字体大小
float const kFontNumFirst36  = 36.0f;
float const kFontNumFirst21  = 21.0f;
float const kFontFirst20  = 20.0f;
float const kFontFirst19  = 19.0f;
float const kFontFirst18  = 18.0f;
float const kFontSecond17  = 17.0f;
float const kFontSecond16 = 16.0f;
float const kFontThird15  = 15.0f;
float const kFontForth14  = 14.0f;
float const kFontFifth12  = 12.0f;
float const kFontSix11    = 11.0f;
float const kFontSeven10  = 10.0f;
float const kFontSeven9   = 9.0f;
float const kFontPrice19  = 19.0f;
float const kFontPrice14  = 14.0f;
float const kFontPrice13  = 13.0f;

@implementation UIFont (LVUtil)

+ (UIFont *)lvFontWithHelveticaSize:(CGFloat)size {
    return [UIFont fontWithName:@"Helvetica" size:size];
}

+ (UIFont *)lvFontWithHelveticaBoldSize:(CGFloat)size {
    return [UIFont fontWithName:@"Helvetica-Bold" size:size];
}

@end
