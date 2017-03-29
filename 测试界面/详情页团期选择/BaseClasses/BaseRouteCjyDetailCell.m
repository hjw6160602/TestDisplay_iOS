//
//  BaseRouteGnyDetailCell.m
//  Lvmm
//
//  Created by zhulihong on 16/8/18.
//  Copyright © 2016年 Lvmama. All rights reserved.
//

#import "BaseRouteCjyDetailCell.h"
#import "Masonry.h"

@interface BaseRouteCjyDetailCell ()

@property (nonatomic, strong) UIImageView *arrowImageView;

@end

@implementation BaseRouteCjyDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)assignViewModel:(id)model {
    
}

/*! cell的高度 */
+ (CGFloat)heightForViewModel:(id)data {
    return 44;
}

- (void)setArrow:(BOOL)arrow {
    _arrow = arrow;
    self.arrowImageView.hidden = !arrow;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellArrow" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil]];
        _arrowImageView.hidden = true;
        [self.contentView addSubview:_arrowImageView];
        [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-10);
        }];
    }
    [self.contentView bringSubviewToFront:_arrowImageView];
    
    return  _arrowImageView;
}

@end
