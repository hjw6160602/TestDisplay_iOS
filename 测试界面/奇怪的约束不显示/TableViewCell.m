//
//  TableViewCell.m
//  测试界面
//
//  Created by 贺嘉炜 on 2017/6/22.
//  Copyright © 2017年 贺嘉炜. All rights reserved.
//

#import "TableViewCell.h"
#import "Masonry.h"

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    UIView *left = [[UIView alloc] init];
    left.backgroundColor = [UIColor cyanColor];
    
    UIView *right = [[UIView alloc] init];
    right.backgroundColor = [UIColor redColor];
    
    [self.contentView addSubview:left];
    [self.contentView addSubview:right];
    
    [left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.mas_equalTo(10);
        make.centerY.equalTo(self.contentView);
    }];

    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(0);
        make.width.mas_equalTo(40);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

@end
