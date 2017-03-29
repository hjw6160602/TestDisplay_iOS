//
//  UIColor+LVUtil.h
//  Lvmm
//
//  Created by zhangxiaoxiang on 16/3/28.
//  Copyright © 2016年 Lvmama. All rights reserved.
//

#import <UIKit/UIKit.h>
//字体颜色
extern NSString *const kColorTextBlack;
extern NSString *const kColorTextDarkDarkGray;
extern NSString *const kColorTextDarkGray;
extern NSString *const kColorTextLightGray;
extern NSString *const kColorTextWhite;
extern NSString *const kColorTextRed;
extern NSString *const kColorTextPink;

//主色调
extern NSString *const kColorMainBackground;
extern NSString *const kColorMainRed;
extern NSString *const kColorMainBlack;
extern NSString *const kColorMainWhite;

//辅助色
extern NSString *const kColorAssistBlue;
extern NSString *const kColorAssistBlueGreen;
extern NSString *const kColorAssistOrange;
extern NSString *const kColorAssistGreen;
extern NSString *const kColorAssistPurple;
extern NSString *const kColorAssistGray;
extern NSString *const kColorAssistBackground;

extern NSString *const kColorLineSplitCell;

extern NSString *const kColorNavigationBarLineSplitCell;

extern NSString *const kColorBackgroundCellSelected;

extern NSString *const kColorBackgroundLVDialogMessage;
extern NSString *const kColorTextLVDialogMessage;

extern NSString *const kColorBackgroundDefaultImage;

extern NSString *const kColorBackgroundCommentNotification;
extern NSString *const kColorTextCommentNotification;
extern NSString *const kColorTextCommentAddPicture;
extern NSString *const kColorTextPressForward;


//-----主色调
//主背景色
extern NSString *const kColorYYTMainBackground;
//大面积使用，用于顶部导航栏、icon和特别需要强调和突出的文字
extern NSString *const kColorYYTMainRed;
//用于按钮等
extern NSString *const kColorYYTMainOrange;
//用于价格等
extern NSString *const kColorYYTMainDarkOrange;
//主要文字，标题性文字
extern NSString *const kColorYYTMainBlack;

//-----辅助色
//用于正文文字、icon
extern NSString *const kColorYYTAssistDarkGray;
//用于辅助，次要性文字
extern NSString *const kColorYYTAssistGray;
//用于填写信息时提示输入文字
extern NSString *const kColorYYTAssistLightGray;
//用于链接等操作性文字
extern NSString *const kColorYYTAssistBlue;
//-----其它
//用于分割线、按钮描边
extern NSString *const kColorYYTLineSplitCell;
//用于积分标签等
extern NSString *const kColorYYTScoreLabel;

@interface UIColor (LVUtil)

+ (UIColor *)lvColorWithHexadecimal:(NSString *)hexadecimalStr;

@end
