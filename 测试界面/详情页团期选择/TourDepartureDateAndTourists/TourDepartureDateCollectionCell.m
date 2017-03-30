//
//  TourDepartureDateCollectionCell.m
//  测试界面
//
//  Created by 贺嘉炜 on 2017/3/29.
//  Copyright © 2017年 贺嘉炜. All rights reserved.
//

#import "TourDepartureDateCollectionCell.h"
#import "UIColor+LVUtil.h"
#import "UIFont+LVUtil.h"
#import <Masonry/Masonry.h>


/** 颜色 */
#define LvmmColor(R, G, B)  [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:1.0]

@interface TourDepartureDateCollectionCell()

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@end

static CGFloat const MARGIN = 2;
static CGFloat const CornerRadius = 5.0f;
static CGFloat const BorderWidth = 0.5f;



@implementation TourDepartureDateCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    [self addSubview:self.dateLabel];
    [self addSubview:self.priceLabel];
    
    UIView *selectedBGView = [[UIView alloc] initWithFrame:self.bounds];
    selectedBGView.backgroundColor = LvmmColor(255, 240, 248);
    selectedBGView.layer.cornerRadius = CornerRadius;
    selectedBGView.layer.borderWidth = BorderWidth;
    selectedBGView.layer.borderColor = [UIColor lvColorWithHexadecimal:kColorMainRed].CGColor;
    
    UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
    bgView.layer.cornerRadius = CornerRadius;
    bgView.layer.borderWidth = BorderWidth;
    bgView.layer.borderColor = [UIColor lvColorWithHexadecimal:kColorTextLightGray].CGColor;
    
    self.selectedBackgroundView = selectedBGView;
    self.backgroundView = bgView;
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        self.dateLabel.textColor = [UIColor lvColorWithHexadecimal:kColorMainRed];
        self.priceLabel.textColor = [UIColor lvColorWithHexadecimal:kColorMainRed];
    } else{
        self.dateLabel.textColor = [UIColor lvColorWithHexadecimal:kColorTextLightGray];
        self.priceLabel.textColor = [UIColor lvColorWithHexadecimal:kColorTextDarkGray];
    }
}

- (void)setDate:(id)date{
    _date = date;
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_offset(MARGIN);
        make.right.mas_offset(-MARGIN);
        make.bottom.equalTo(self.priceLabel.mas_top);
        make.height.equalTo(self.priceLabel);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(MARGIN);
        make.bottom.right.mas_offset(-MARGIN);
        make.top.equalTo(self.dateLabel.mas_bottom);
    }];
    
    self.dateLabel.text = @"12/26 周日";
    NSString *originPriceLabelTxt = @"￥2666起";
    
    NSMutableAttributedString *attrTxt = [[NSMutableAttributedString alloc]initWithString:originPriceLabelTxt];

    [attrTxt addAttribute:NSFontAttributeName
                    value:[UIFont lvFontWithHelveticaSize:kFontForth14]
                    range:NSMakeRange(1, attrTxt.length - 2)];
    
    self.priceLabel.attributedText = attrTxt;
    
}

#pragma mark - Lazy load

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        self.dateLabel = [[UILabel alloc]init];
        self.dateLabel.font = [UIFont lvFontWithHelveticaSize:kFontSeven10];
        self.dateLabel.textColor = [UIColor lvColorWithHexadecimal:kColorTextLightGray];
        self.dateLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _dateLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        self.priceLabel = [[UILabel alloc]init];
        self.priceLabel.font = [UIFont lvFontWithHelveticaSize:kFontSeven9];
        self.priceLabel.textColor = [UIColor lvColorWithHexadecimal:kColorTextDarkGray];
        self.priceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLabel;
}
@end
