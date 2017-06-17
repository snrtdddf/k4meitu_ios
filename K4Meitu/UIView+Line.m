//
//  UIView+line.m
//  1
//
//  Created by YL on 16-08-15.
//  @深圳市黄金资讯集团_iOS
//  @版权所有  禁止传播
//  @级别：绝密
//  Copyright © 2016年 SHENZHEN China Gold Infomation Group. All rights reserved.
//

#import "UIView+Line.h"
#define color [UIColor colorWithRed:245.f/255.f green:246.f/255.f blue:247.f/255.f alpha:1]
@implementation UIView (Line)
- (void)addLineWithLineType:(GYLineType)type
{
    if (type & GYLineTypeTop) {
        
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = color.CGColor;
        layer.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), 1);
        [self.layer addSublayer:layer];
    }
    
    if (type & GYLineTypeLeft) {
        
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = color.CGColor;
        layer.frame = CGRectMake(0, 0, 1, CGRectGetHeight(self.bounds));
        [self.layer addSublayer:layer];
    }
    
    if (type & GYLineTypeBottom) {
        
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = color.CGColor;
        layer.frame = CGRectMake(0, CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), 1);
        [self.layer addSublayer:layer];
    }
    
    if (type & GYLineTypeRight) {
        
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = color.CGColor;
        layer.frame = CGRectMake(CGRectGetWidth(self.bounds), 0, 1, CGRectGetHeight(self.bounds));
        [self.layer addSublayer:layer];
    }
    
}

@end
