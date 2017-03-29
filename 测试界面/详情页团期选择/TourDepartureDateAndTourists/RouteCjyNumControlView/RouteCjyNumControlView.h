//
//  RouteCjyNumControlView.h
//  测试界面
//
//  Created by 贺嘉炜 on 2017/3/29.
//  Copyright © 2017年 贺嘉炜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RouteCjyNumControlView : UIView
/** 当前的个数 */
@property (nonatomic, assign, readonly)NSInteger num;
/** 最小不能少于 */
@property (nonatomic, assign, readonly)NSInteger minNum;

@end
