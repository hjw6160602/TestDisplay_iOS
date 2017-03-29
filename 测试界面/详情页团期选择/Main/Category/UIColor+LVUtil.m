//
//  UIColor+LVUtil.m
//  Lvmm
//
//  Created by zhangxiaoxiang on 16/3/28.
//  Copyright © 2016年 Lvmama. All rights reserved.
//

#import "UIColor+LVUtil.h"
//字体颜色
NSString *const kColorTextBlack                     = @"00000064";//一号字体黑色 0,0,0
NSString *const kColorTextDarkDarkGray              = @"33333364";//列表标题字体深黑灰色 51,51,51
NSString *const kColorTextDarkGray                  = @"66666664";//二号字体黑灰色 102,102,102
NSString *const kColorTextLightGray                 = @"aaaaaa64";//三号字体灰色 170,170,170
NSString *const kColorTextWhite                     = @"ffffff64";//四号字体白色 255,255,255
NSString *const kColorTextRed                       = @"d3077564";//价格字体红色 211,7,117
NSString *const kColorTextPink                      = @"ff000064";//字体正红色 255,0,0

//主色调
NSString *const kColorMainBackground                = @"f8f8f864";//主背景色 248,248,248
NSString *const kColorMainRed                       = @"d3077564";//主色调红色 211,7,117
NSString *const kColorMainBlack                     = @"3232325f";//主色调黑色 50,50,50 透明度95%
NSString *const kColorMainWhite                     = @"ffffff64";//主色调白色 255,255,255

//辅助色
NSString *const kColorAssistBlue                    = @"5598dc64";//辅助色蓝色 85,152,220
NSString *const kColorAssistBlueGreen               = @"1dbf9364";//辅助色蓝绿色 29,191,147
NSString *const kColorAssistOrange                  = @"ff740d64";//辅助色橙色 255,116,13
NSString *const kColorAssistGreen                   = @"7bc73064";//辅助色绿色 123,199,48
NSString *const kColorAssistPurple                  = @"c672e164";//辅助色紫色 198,114,225
NSString *const kColorAssistGray                    = @"aaaaaa64";//辅助色灰色 170,170,170
NSString *const kColorAssistBackground              = @"f1f1f164";// 出境游新加颜色

NSString *const kColorLineSplitCell                 = @"dddddd64";//Cell分割线颜色 221,221,221

NSString *const kColorNavigationBarLineSplitCell    = @"b2b2b264";//导航栏分割线颜色

NSString *const kColorBackgroundCellSelected        = @"eeeeee64";//Cell选中颜色 238,238,238

NSString *const kColorBackgroundLVDialogMessage     = @"18181864";//提示框背景色
NSString *const kColorTextLVDialogMessage           = @"a3a3a364";//提示框字体颜色

NSString *const kColorBackgroundDefaultImage        = @"fafafa64";// 默认图片背景色250,250,250

NSString *const kColorBackgroundCommentNotification = @"fef3da64";// 点评通知背景颜色：黄白色 254,243,218
NSString *const kColorTextCommentNotification       = @"af813164";// 点评通知字体颜色：卡其黄色 175,129,49
NSString *const kColorTextCommentAddPicture         = @"fd732664";// 写点评添加图片字体颜色：黄色 253,115,38

NSString *const kColorTextPressForward              = @"4583D464";// 可点击跳转的文本颜色
//----------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------
//-----主色调
//主背景色
NSString *const kColorYYTMainBackground             = @"f5f5f564";//主背景色 245,245,245
//大面积使用，用于顶部导航栏、icon和特别需要强调和突出的文字
NSString *const kColorYYTMainRed                     = @"ee338864";//主色调红色 238,51,136
//用于按钮等
NSString *const kColorYYTMainOrange                  = @"ff880064";//主色调橙色 255,136,0
//用于价格等
NSString *const kColorYYTMainDarkOrange              = @"ff660064";//主色调深橙色 255,102,0
//主要文字，标题性文字
NSString *const kColorYYTMainBlack                   = @"33333364";//主色调黑色 51,51,51

//-----辅助色
//用于正文文字、icon
NSString *const kColorYYTAssistDarkGray              = @"66666664";//辅助色深灰色 102,102,102
//用于辅助，次要性文字
NSString *const kColorYYTAssistGray                  = @"99999964";//辅助色灰色 102,102,102
//用于填写信息时提示输入文字
NSString *const kColorYYTAssistLightGray             = @"aaaaaa64";//辅助色灰色 170,170,170
//用于链接等操作性文字
NSString *const kColorYYTAssistBlue                  = @"0099cc64";//辅助色蓝色 0,153,204

//-----其它
//用于分割线、按钮描边
NSString *const kColorYYTLineSplitCell               = @"dddddd64";//Cell分割线颜色 221,221,221
//用于积分标签等
NSString *const kColorYYTScoreLabel                  = @"eb483f64";//积分标签的红色 235,72,63

static NSMutableDictionary *hexadecimalColorCache = nil;

@implementation UIColor (LVUtil)

- (void)load {
    hexadecimalColorCache = [[NSMutableDictionary alloc] init];
}

+ (UIColor *)lvColorWithHexadecimal:(NSString *)hexadecimalStr {
    if ([hexadecimalStr hasPrefix:@"#"]) {
        hexadecimalStr = [hexadecimalStr substringFromIndex:1];
    }
    if ([hexadecimalStr length] == 6) {
        hexadecimalStr = [hexadecimalStr stringByAppendingString:@"64"];
    } else if ([hexadecimalStr length] < 6) {
        return [UIColor clearColor];
    }
    if ([hexadecimalColorCache objectForKey:hexadecimalStr]) {
        return [hexadecimalColorCache objectForKey:hexadecimalStr];
    }
    unsigned int red, green, blue, alpha;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexadecimalStr substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[hexadecimalStr substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[hexadecimalStr substringWithRange:range]] scanHexInt:&blue];
    range.location = 6;
    [[NSScanner scannerWithString:[hexadecimalStr substringWithRange:range]] scanHexInt:&alpha];
    
    UIColor *converColor = [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:(float)(alpha/100.0f)];
    if (converColor) {
        [hexadecimalColorCache setObject:converColor forKey:hexadecimalStr];
    }
    return converColor;
}

@end
