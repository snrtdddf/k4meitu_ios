//
//  UIView+line.h
//  1
//
//  Created by YL on 16-08-15.
//  @深圳市黄金资讯集团_iOS
//  @版权所有  禁止传播
//  @级别：绝密
//  Copyright © 2016年 SHENZHEN China Gold Infomation Group. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS(NSUInteger, GYLineType) {
    GYLineTypeNone    = 0,
    GYLineTypeTop     = 1,
    GYLineTypeLeft    = 1<<1,
    GYLineTypeBottom  = 1<<2,
    GYLineTypeRight   = 1<<3
};



@interface UIView (Line)
- (void)addLineWithLineType:(GYLineType)type;

@end
