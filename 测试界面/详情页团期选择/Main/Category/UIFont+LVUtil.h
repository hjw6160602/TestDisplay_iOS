//
//  UIFont+LVUtil.h
//  Lvmm
//
//  Created by zhangxiaoxiang on 16/3/28.
//  Copyright © 2016年 Lvmama. All rights reserved.
//

#import <UIKit/UIKit.h>
//字体大小
extern float const kFontNumFirst36;
extern float const kFontNumFirst21;
extern float const kFontFirst20;
extern float const kFontFirst19;
extern float const kFontFirst18;
extern float const kFontSecond17;
extern float const kFontSecond16;
extern float const kFontThird15;
extern float const kFontForth14;
extern float const kFontForth13;
extern float const kFontFifth12;
extern float const kFontSix11;
extern float const kFontSeven10;
extern float const kFontSeven9;
extern float const kFontPrice19;
extern float const kFontPrice14;
extern float const kFontPrice13;

@interface UIFont (LVUtil)

/**
 生成普通UIFont

 @param size 字体大小
 @return UIFont
 */
+ (UIFont *)lvFontWithHelveticaSize:(CGFloat)size;

/**
 生成粗体UIFont

 @param size 粗体字体大小
 @return UIFont
 */
+ (UIFont *)lvFontWithHelveticaBoldSize:(CGFloat)size;

@end
