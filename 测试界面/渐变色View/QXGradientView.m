//
//  QXGradientView.m
//  渐变色View
//
//  Created by SaiDiCaprio on 2019/7/16.
//  Copyright © 2019 贺嘉炜. All rights reserved.
//

#import "QXGradientView.h"

#define kPurpleColor            [UIColor colorWithRed:130/255.0 green: 69/255.0 blue:255/255.0 alpha:1] // 8245ff 紫色
#define kThemeRedColor          [UIColor colorWithRed:255/255.0 green: 0/255.0 blue:174/255.0 alpha:1] //#FF00AE 主题红

@implementation QXGradientView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = [UIColor clearColor];

    UIView *shadowView = [QXGradientView gradientViewWithColorArray:@[(__bridge id)kPurpleColor.CGColor, (__bridge id)kThemeRedColor.CGColor] frame:self.bounds];
    shadowView.alpha = 0.8;
    [self addSubview:shadowView];
    
    self.layer.cornerRadius = self.bounds.size.height / 2;
    self.layer.masksToBounds = YES;
}

+ (UIView *)gradientViewWithColorArray:(NSArray *)colors frame:(CGRect)frame{
    UIView *shadowView = [[UIView alloc] initWithFrame:frame];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = frame;
    gradientLayer.locations = @[@0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.colors = colors;
    [shadowView.layer addSublayer:gradientLayer];
    return shadowView;
}

@end
