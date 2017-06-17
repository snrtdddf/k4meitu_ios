//
//  UILabel+LineSpace.m
//  company
//
//  Created by YL on 16-08-15.
//  @深圳市黄金资讯集团_iOS
//  @版权所有  禁止传播
//  @级别：绝密
//  Copyright © 2016年 SHENZHEN China Gold Infomation Group. All rights reserved.
//

#import "UILabel+LineSpace.h"

@implementation UILabel (LineSpace)
-(void)setLineSpace :  (CGFloat)spaceCout WithLabel :(UILabel *)label   WithText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:spaceCout];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    label.attributedText = attributedString;
 
    [label sizeToFit];

}
@end
