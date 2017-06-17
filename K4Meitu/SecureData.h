//
//  SecureData.h
//  GoldWallet
//
//  Created by simpleem on 16/7/29.
//  Copyright © 2016年 China_Gold_Infomation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CocoaSecurity.h"
@interface SecureData : NSObject

//AES256加密
+ (NSString *)aes256Encryption:(NSString *)str;

//AES256解密
+ (NSString *)aes256Decryption:(NSString *)str;

//md5加密
+ (NSString *)md5Encryption:(NSString *)str;

@end
