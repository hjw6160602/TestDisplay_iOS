//
//  UIScreen+LVUtil.m
//  Pods
//
//  Created by 新闻 on 16/5/9.
//  Copyright © 2016年 Lvmama. All rights reserved.
//

#import "UIScreen+LVUtil.h"

@implementation UIScreen (LVUtil)


+ (CGFloat)lvScreenWidth {
    
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)lvScreenHeight {
    
    return [UIScreen mainScreen].bounds.size.height;
}

@end
