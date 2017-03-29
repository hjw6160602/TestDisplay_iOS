//
//  BaseRouteGnyDetailCell.h
//  Lvmm
//
//  Created by zhulihong on 16/8/18.
//  Copyright © 2016年 Lvmama. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseRouteCjyDetailCell : UITableViewCell

- (void)assignViewModel:(id)model;
/*! cell的高度默认44 */
+ (CGFloat)heightForViewModel:(id)data;

@property (nonatomic, assign) BOOL arrow;

@end
