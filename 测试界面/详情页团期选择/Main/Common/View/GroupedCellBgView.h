//
//  GroupedCellBgView.h
//  Lvmm
//
//  Created by zhouyi on 13-4-2.
//  Copyright (c) 2013年 lvmama. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 @abstract cell分割线模式
 @discussion 分别为无、上、中、下、单CELL
 */
typedef NS_ENUM (NSUInteger, GroupedCellStyle) {
    GroupedCellStyle_None,
    GroupedCellStyle_Top,
    GroupedCellStyle_Middle,
    GroupedCellStyle_Bottom,
    GroupedCellStyle_Single
};

@interface GroupedCellBgView : UIView {
    GroupedCellStyle _groupedCellStyle;
    BOOL _needArrow;
    BOOL _isSelected;
    BOOL _isPlain;
}

/**
 *  @description 根据数量及当前的索引生成对应的cell分割线样式
 *  @param count 数量
 *  @param index 索引
 *  @param isPlain 左侧间隔 TRUE 0px | FALSE 10px
 *  @param needArrow 是否需要显示右侧箭头
 *  @param isSelected 是否显示选中样式
 *  @return id 实例对象GroupedCellBgView
 */
- (id)initWithFrame:(CGRect)frame withDataSourceCount:(NSUInteger)count
                                            withIndex:(NSInteger)index
                                              isPlain:(BOOL)isPlain
                                            needArrow:(BOOL)needArrow
                                           isSelected:(BOOL)isSelected;
/**
 *  @description 判断当前cell样式
 *  @param count 数量
 *  @param index 索引
 *  @return GroupedCellStyle 样式枚举
 */
+ (GroupedCellStyle)checkCellStyle:(NSUInteger)count index:(NSInteger)index;

@end
