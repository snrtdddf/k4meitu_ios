//
//  UILabel+LineSpace.h
//  company
//
//  Created by YL on 16-08-15.
//  @深圳市黄金资讯集团_iOS
//  @版权所有  禁止传播
//  @级别：绝密
//  Copyright © 2016年 SHENZHEN China Gold Infomation Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LineSpace)
//设置行间距的方法
-(void)setLineSpace : (CGFloat)spaceCout WithLabel :(UILabel *) label  WithText:(NSString *)text;
@end
