//
//  GroupedCellBgView.m
//  Lvmm
//
//  Created by zhouyi on 13-4-2.
//  Copyright (c) 2013年 lvmama. All rights reserved.
//

#import "GroupedCellBgView.h"
#import "UIColor+LVUtil.h"
#import "UIScreen+LVUtil.h"

@implementation GroupedCellBgView

+ (GroupedCellStyle)checkCellStyle:(NSUInteger)count index:(NSInteger)index {
    if (count > 0) {
        if (count > 1) {
            if (index == 0) {
                return GroupedCellStyle_Top;
            }
            if (index == count - 1) {
                return GroupedCellStyle_Bottom;
            }
            return GroupedCellStyle_Middle;
        }
        return GroupedCellStyle_Single;
    }
    return GroupedCellStyle_None;
}

- (id)initWithFrame:(CGRect)frame withDataSourceCount:(NSUInteger)count
                                            withIndex:(NSInteger)index
                                              isPlain:(BOOL)isPlain
                                            needArrow:(BOOL)needArrow
                                           isSelected:(BOOL)isSelected {
    
    _groupedCellStyle = [GroupedCellBgView checkCellStyle:count index:index];
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen lvScreenWidth], CGRectGetHeight(frame))];
    self.backgroundColor = [UIColor clearColor];
    
    if (self) {
        _needArrow = needArrow;
        _isSelected = isSelected;
        _isPlain = isPlain;
        [self setNeedsDisplay];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef _context = UIGraphicsGetCurrentContext();
    CGColorRef _contextColor = [UIColor lvColorWithHexadecimal:(_isSelected ? kColorBackgroundCellSelected : kColorMainWhite)].CGColor;
    CGContextBeginPath(_context);
    CGContextSetFillColorWithColor(_context, _contextColor);//设置颜色
    CGContextFillRect(_context, CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height));
    CGContextStrokePath(_context);
    
    CGFloat minx = CGRectGetMinX(rect) + (_isPlain ? 0 : 10);
    CGFloat maxx = CGRectGetMaxX(rect);
    CGFloat miny = CGRectGetMinY(rect);
    CGFloat maxy = CGRectGetMaxY(rect);
    
    switch (_groupedCellStyle) {
        case GroupedCellStyle_Top:
        {
            CGContextSetStrokeColorWithColor(_context, [UIColor lvColorWithHexadecimal:kColorLineSplitCell].CGColor);
            
            CGContextBeginPath(_context);
            CGContextMoveToPoint(_context, minx, miny);
            CGContextAddLineToPoint(_context, maxx, miny);
            CGContextStrokePath(_context);
            
            CGContextBeginPath(_context);
            CGContextMoveToPoint(_context, minx + 10, maxy);
            CGContextAddLineToPoint(_context, maxx, maxy);
            CGContextStrokePath(_context);
        }
            break;
        case GroupedCellStyle_Middle:
        {
            CGContextSetStrokeColorWithColor(_context, [UIColor lvColorWithHexadecimal:kColorLineSplitCell].CGColor);
            
            CGContextBeginPath(_context);
            CGContextMoveToPoint(_context, minx + 10, maxy);
            CGContextAddLineToPoint(_context, maxx, maxy);
            CGContextStrokePath(_context);
        }
            break;
        case GroupedCellStyle_Bottom:
        {
            CGContextSetStrokeColorWithColor(_context, [UIColor lvColorWithHexadecimal:kColorLineSplitCell].CGColor);
            
            CGContextBeginPath(_context);
            CGContextMoveToPoint(_context, minx, maxy);
            CGContextAddLineToPoint(_context, maxx, maxy);
            CGContextStrokePath(_context);
        }
            break;
        case GroupedCellStyle_Single:
        {
            minx = CGRectGetMinX(rect);
            CGContextSetStrokeColorWithColor(_context, [UIColor lvColorWithHexadecimal:kColorLineSplitCell].CGColor);
            
            CGContextBeginPath(_context);
            CGContextMoveToPoint(_context, minx, miny);
            CGContextAddLineToPoint(_context, maxx, miny);
            CGContextStrokePath(_context);
            
            CGContextBeginPath(_context);
            CGContextMoveToPoint(_context, minx, maxy);
            CGContextAddLineToPoint(_context, maxx, maxy);
            CGContextStrokePath(_context);
        }
            break;
        case GroupedCellStyle_None:
            break;
        default:
            break;
            
    }
    
    // 箭头
    if (_needArrow) {
        UIImage *arrowImage = [UIImage imageNamed:@"cellArrow.png" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil];
        UIGraphicsPushContext(_context);
        CGFloat instance = _isPlain ? 0 : -10;
        [arrowImage drawInRect:CGRectMake(maxx - 20 + instance, (maxy - 15) / 2.0, 10, 15)];
        UIGraphicsPopContext();
    }

}

@end
