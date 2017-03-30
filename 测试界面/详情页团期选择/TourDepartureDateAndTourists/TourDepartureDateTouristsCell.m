//
//  TourDepartureDateTouristsCell.m
//  测试界面
//
//  Created by 贺嘉炜 on 2017/3/30.
//  Copyright © 2017年 贺嘉炜. All rights reserved.
//

#import "TourDepartureDateTouristsCell.h"
#import "RouteCjyNumControlView.h"
#import "GroupedCellBgView.h"
#import <Masonry/Masonry.h>

@interface TourDepartureDateTouristsCell()

@property (nonatomic, strong) RouteCjyNumControlView *adultNumControl;

@property (nonatomic, strong) RouteCjyNumControlView *childNumControl;

@end

static CGFloat const MARGIN = 10;

@implementation TourDepartureDateTouristsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.backgroundView = [[GroupedCellBgView alloc] initWithFrame:CGRectZero withDataSourceCount:1 withIndex:0 isPlain:true needArrow:false isSelected:false];
    [self.contentView addSubview:self.adultNumControl];
    [self.contentView addSubview:self.childNumControl];
    
    [self.adultNumControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(MARGIN);
    }];
    
    [self.childNumControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(MARGIN);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeZero);
    }];
    
}

#pragma mark - Lazy load

- (RouteCjyNumControlView *)adultNumControl {
    if (!_adultNumControl) {
        self.adultNumControl = [[RouteCjyNumControlView alloc]init];
        
    }
    return _adultNumControl;
}

- (RouteCjyNumControlView *)childNumControl {
    if (!_childNumControl) {
        self.childNumControl = [[RouteCjyNumControlView alloc]init];
        
        
        
    }
    return _childNumControl;
}



@end
