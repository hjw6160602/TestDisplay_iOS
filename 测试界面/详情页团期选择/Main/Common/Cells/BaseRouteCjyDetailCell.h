//
//  BaseRouteGnyDetailCell.h
//  Lvmm
//
//  Created by zhulihong on 16/8/18.
//  Copyright © 2016年 Lvmama. All rights reserved.
//

#import <UIKit/UIKit.h>

// 使用方法assignViewModel赋值给cell时检查有没有遵循cellProtocol协议
#define ViewModelConformsToProtocolAssign(model, protocolName) if (![model conformsToProtocol:@protocol(protocolName)]) {\
NSLog(@"assignViewModel:中model(%@)没有遵循协议protocolName",model);\
return;\
}
// 使用方法heightForViewModel中检查有没有遵循cellProtocol协议
#define ViewModelConformsToProtocolHeight(model, protocolName) if (![model conformsToProtocol:@protocol(protocolName)]) {\
NSLog(@"heightForViewModel:中model(%@)没有遵循协议protocolName",model);\
return 0;\
}

@interface BaseRouteCjyDetailCell : UITableViewCell

- (void)assignViewModel:(id)model;
/*! cell的高度默认44 */
+ (CGFloat)heightForViewModel:(id)data;

@property (nonatomic, assign) BOOL arrow;

@end
