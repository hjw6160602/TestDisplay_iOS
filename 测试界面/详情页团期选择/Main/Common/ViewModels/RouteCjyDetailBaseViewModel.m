//
//  BaseGNYViewModel.m
//  Lvmm
//
//  Created by zhulihong on 16/8/11.
//  Copyright © 2016年 Lvmama. All rights reserved.
//

#import "RouteCjyDetailBaseViewModel.h"
#import "BaseRouteCjyDetailCell.h"

@interface RouteCjyDetailBaseViewModel()

@end

@implementation RouteCjyDetailBaseViewModel

/*!
 * 创建viewModel，后期会修改initWithData
 */
- (id)initWithCell:(UITableViewCell *)cell cellHeight:(CGFloat)cellHeight {
    self = [super init];
    if (self) {
        _tabelViewcell = cell?:[self createNouseableCell];
        _tabelViewcell.selectionStyle = UITableViewCellSelectionStyleNone;
        _cellHeight = cellHeight;
    }
    return self;
}

/*! 创建空白透明cell */
- (id)initClearSectionCellHeight:(CGFloat)height {
    return [self initWithCell:[self getClearSectionCell] cellHeight:height];
}

- (id)initWithData:(id)data {
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (UITableViewCell *)createNouseableCell {
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
}

/*!
 *  获取model的cell, 后期后修改成返回@property (nonatomic, strong) NSString *cellIdentifier;来创建cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath delegate:(id)delegate {
    if (self.tabelViewcell) {
        return self.tabelViewcell;
    } else if (self.cellIdentifer.length > 0) {
        BaseRouteCjyDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifer];
//        [cell assignViewModel:self];
        if (cell) {
            return cell;
        } else {
            NSLog(@"错误：model(%@)返回tableView(%@)没有注册cell(%@)",self, tableView,self.cellIdentifer);
        }
    } else {
        NSLog(@"错误：model(%@)返回cell为空",self);
    }
    
    return [UITableViewCell new];
}

/*!tableView点击了该model对应的cell*/
- (void)didSelectCellTableView:(UITableView *)tableView viewController:(UIViewController *)viewController {
    
}

/*!
 *  返回空的透明没有点击效果的cell
 */
- (UITableViewCell *)getClearSectionCell {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

/*! 是否显示该行数据 */
+ (BOOL)showCellWithData:(id)data {
    return true;
}

@end
