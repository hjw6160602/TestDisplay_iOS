//
//  ViewController.h
//  结构体赋值
//
//  Created by 贺嘉炜 on 2017/6/8.
//  Copyright © 2017年 贺嘉炜. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef struct RouteProductVisitInfo{
    int adultQuantity; // 成人数
    int childQuantity; // 儿童数
    int quantity;      // 份数
    const char *specDate;    // 访问日期
}VisitInfo;

@interface ViewController : UIViewController


@end

