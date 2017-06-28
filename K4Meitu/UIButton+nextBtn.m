//
//  UIButton+nextBtn.m
//  DealGold
//
//  Created by simpleem on 16/8/27.
//  Copyright © 2016年 China_Gold_Infomation. All rights reserved.
//

#import "UIButton+nextBtn.h"
#import "Header.h"
@implementation UIButton (nextBtn)
+ (UIButton *)footerBtn_originY:(CGFloat)Y btnTitle:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, IPHONE_WIDTH - SPW(60), 0.07 * IPHONE_HEIGHT);
    //设置按钮的阴影
    CALayer *layer = [CALayer layer];
    layer.frame =CGRectMake(0, 0, IPHONE_WIDTH - SPW(60), 0.07 * IPHONE_HEIGHT);//和btn的frame相同
    layer.backgroundColor = Pink_COLOR.CGColor;
    layer.shadowOffset = CGSizeMake(5, 5);
    layer.shadowOpacity = 0.2;//透明度
    layer.cornerRadius = 0.07 * IPHONE_HEIGHT / 2;
    [btn.layer addSublayer:layer];
    btn.layer.cornerRadius = 0.07 * IPHONE_HEIGHT / 2;
    [btn setTintColor:[UIColor whiteColor]];
    [btn setBackgroundColor:Pink_COLOR];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.center = CGPointMake(IPHONE_WIDTH / 2, Y);
   
    
    return btn;

}
@end
