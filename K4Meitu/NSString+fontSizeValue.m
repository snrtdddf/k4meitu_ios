//
//  NSString+fontSizeValue.m
//  GoldWallet
//
//  Created by simpleem on 16/10/12.
//  Copyright © 2016年 China_Gold_Infomation. All rights reserved.
//

#import "NSString+fontSizeValue.h"

@implementation NSString (fontSizeValue)
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
