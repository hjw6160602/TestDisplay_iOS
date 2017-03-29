//
//  BaseGNYViewModel.h
//  Lvmm
//
//  Created by zhulihong on 16/8/11.
//  Copyright © 2016年 Lvmama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*!
 *  国内游所使用的viewModel
 */
@interface RouteCjyDetailBaseViewModel : NSObject

@property (nonatomic, strong) id data;
@property (nonatomic, copy) NSString *selectId;
/*! cell 的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/*! 该model的cellIdentifer，后期会由这个创建cell */
@property (nonatomic, copy) NSString *cellIdentifer;

@property (nonatomic, strong, readonly) UITableViewCell *tabelViewcell;
/*!
 
 * 创建viewModel，后期会只用initWithData
 */
- (id)initWithCell:(UITableViewCell *)cell cellHeight:(CGFloat)cellHeight;
/*! 创建空白透明cell */
- (id)initClearSectionCellHeight:(CGFloat)height;

/*!
 *  创建viewModel, 目前只有子类实现了该方法
 */
- (id)initWithData:(id)data;

/*!
 *  获取model的cell, 后期后修改成返回@property (nonatomic, strong) NSString *cellIdentifier;来创建cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath delegate:(id)delegate;

/*! 是否显示该行数据 */
+ (BOOL)showCellWithData:(id)data;

/*!tableView点击了该model对应的cell*/
- (void)didSelectCellTableView:(UITableView *)tableView viewController:(UIViewController *)viewController;

@end
