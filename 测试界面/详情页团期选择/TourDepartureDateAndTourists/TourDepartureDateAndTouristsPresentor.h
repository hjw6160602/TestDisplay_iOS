//
//  TourDepartureDateAndTouristsPresentor.h
//  测试界面
//
//  Created by 贺嘉炜 on 2017/3/29.
//  Copyright © 2017年 贺嘉炜. All rights reserved.
//

@import UIKit;

@interface TourDepartureDateAndTouristsPresentor : NSObject

@property (nonatomic, strong) NSArray *viewModels;

/**
 * @func   presentorWithTableView 类工厂方法初始化
 */
+ (instancetype)presentorWithTableView:(UITableView *)tableView;

@end
