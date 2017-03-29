//
//  RouteGnyDetailImageNameCell.h
//  Lvmm
//
//  Created by zhulihong on 16/8/17.
//  Copyright © 2016年 Lvmama. All rights reserved.
//

#import "BaseRouteCjyDetailCell.h"

/* 左边图片，图片旁边文字 */
@protocol RouteCjyDetailImageNameCellDelegate <NSObject>

@required
- (UIImage *)image;
- (NSString *)title;
@optional
/*! 标题旁边灰色说明文字 */
- (NSString *)titleDetail;
/*! arrow的左边的灰色label */
- (NSString *)detailText;
/*! 右边灰色说明文字的颜色 */
- (UIColor *)detailTextColor;

@end

@interface RouteCjyDetailImageNameCell : BaseRouteCjyDetailCell

- (void)assignViewModel:(id<RouteCjyDetailImageNameCellDelegate>)model;

@end
