//
//  RouteCjyNumControlView.m
//  测试界面
//
//  Created by 贺嘉炜 on 2017/3/29.
//  Copyright © 2017年 贺嘉炜. All rights reserved.
//

#import "RouteCjyNumControlView.h"
#import "UIColor+LVUtil.h"
#import "UIFont+LVUtil.h"

@interface RouteCjyNumControlView()
@property (strong, nonatomic) UIButton *minusBtn;
@property (strong, nonatomic) UIButton *plusBtn;
@property (strong, nonatomic) UILabel *numLabel;
@end

@implementation RouteCjyNumControlView


- (instancetype)initWithFrame:(CGRect)frame {
    CGFloat x = CGRectGetMinX(frame);
    CGFloat y = CGRectGetMinY(frame);
    self = [super initWithFrame:CGRectMake(x, y, 90, 25)];
    if (self) {
        _num = 1;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.minusBtn];
    [self addSubview:self.numLabel];
    [self addSubview:self.plusBtn];
    
    [self.minusBtn addTarget:self action:@selector(minusBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.plusBtn addTarget:self action:@selector(plusBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
}

/**
 * @func   控件代理赋值
 *
 * @note   在手机屏幕上绘制该控件时会调用该方法
 */
//- (void)drawRect:(CGRect)rect {
//    //    id FatherController = [self viewController];
//    //    self.delegate = FatherController;
//    NSObject *obj = (NSObject *)self.delegate;
//    if ([obj respondsToSelector:@selector(numControlView:)])
//        [self.delegate numControlView:self];
//}

/**
 * @func   当减号被点击
 */
- (void)minusBtnOnClick:(UIButton *)sender{
    int num = self.numLabel.text.intValue;
    if (num > 1) {
        num--;
        self.numLabel.text = [NSString stringWithFormat:@"%d",num];
    }
    _num = num;
}

/**
 * @func   当加号被点击
 */
- (void)plusBtnOnClick:(UIButton *)sender{
    int num = self.numLabel.text.intValue;
    num++;
    self.numLabel.text = [NSString stringWithFormat:@"%d",num];
    _num = num;
}

#pragma mark - Lazy load
- (UIButton *)minusBtn {
    if (!_minusBtn) {
        self.minusBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
        [self.minusBtn setImage:[UIImage imageNamed:@"minusButtonNormal" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
        [self.minusBtn setImage:[UIImage imageNamed:@"minusButtonDisable" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] forState:UIControlStateDisabled];
    }
    return _minusBtn;
}

- (UIButton *)plusBtn {
    if (!_plusBtn) {
        self.plusBtn = [[UIButton alloc]initWithFrame:CGRectMake(65, 0, 25, 25)];
        [self.plusBtn setImage:[UIImage imageNamed:@"plusButtonNormal" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
        [self.plusBtn setImage:[UIImage imageNamed:@"plusButtonDisable" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] forState:UIControlStateDisabled];
    }
    return _plusBtn;
}

- (UILabel *)numLabel {
    if (!_numLabel) {
        self.numLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 40, 25)];
        self.numLabel.layer.borderWidth = 0.5f;
        self.numLabel.layer.borderColor = [UIColor lvColorWithHexadecimal:kColorTextLightGray].CGColor;
        self.numLabel.textColor = [UIColor lvColorWithHexadecimal:kColorMainRed];
        self.numLabel.text = [NSString stringWithFormat:@"%ld", _num];
        self.numLabel.font = [UIFont lvFontWithHelveticaSize:kFontFifth12];
        self.numLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _numLabel;
}

@end
