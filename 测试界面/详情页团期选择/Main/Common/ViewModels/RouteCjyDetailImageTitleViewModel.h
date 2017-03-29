//
//  RouteGnyDetailImageTitleViewModel.h
//  Lvmm
//
//  Created by zhulihong on 16/8/17.
//  Copyright © 2016年 Lvmama. All rights reserved.
//

#import "RouteCjyDetailBaseViewModel.h"
#import "RouteCjyDetailImageNameCell.h"

@interface RouteCjyDetailImageTitleViewModel : RouteCjyDetailBaseViewModel<RouteCjyDetailImageNameCellDelegate>

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *titleDetail;//标题旁边灰色说明文字
@property (nonatomic, copy) NSString *detailText;//右边灰色说明文字
@property (nonatomic, strong) UIColor *detailTextColor;//右边灰色说明文字的颜色

@property (nonatomic, assign) BOOL arrow;
@property (nonatomic, strong) UIView *cellBackgroudView;

- (id)initWithImage:(UIImage *)image
              title:(NSString *)title
         detailText:(NSString *)detailText
              arrow:(BOOL)arrow;

@end
