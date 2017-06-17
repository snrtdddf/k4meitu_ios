//
//  NSString+fontSizeValue.h
//  GoldWallet
//
//  Created by simpleem on 16/10/12.
//  Copyright © 2016年 China_Gold_Infomation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (fontSizeValue)
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
@end
