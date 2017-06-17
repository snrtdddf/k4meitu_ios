//
//  SecureData.m
//  GoldWallet
//
//  Created by simpleem on 16/7/29.
//  Copyright © 2016年 China_Gold_Infomation. All rights reserved.
//

#import "SecureData.h"
@implementation SecureData

/*
 CocoaSecurityResult *sha256 = [CocoaSecurity sha256:@"com.24k.www"];
 sha256.hexLower = @"812a867b1a481559d441b6af4381aa05d41563d5671d889bece5bb29200f2756";
 
 
 CocoaSecurityResult *md5 = [CocoaSecurity md5:@"com.24k.www"];
 md5.hexLower = @"05e878eaaefc205e1b130545472aa230";
 */



//AES256加密
+ (NSString *)aes256Encryption:(NSString *)str{
    CocoaSecurityResult *aes256 = [CocoaSecurity aesEncrypt:str
                                                    hexKey:@"812a867b1a481559d441b6af4381aa05d41563d5671d889bece5bb29200f2756"
                                                         hexIv:@"05e878eaaefc205e1b130545472aa230"];
    
    return aes256.base64;
}

//AES256解密
+ (NSString *)aes256Decryption:(NSString *)str{
    CocoaSecurityResult *aes256Decrypt = [CocoaSecurity aesDecryptWithBase64:str
                                                                      hexKey:@"812a867b1a481559d441b6af4381aa05d41563d5671d889bece5bb29200f2756"
                                                                       hexIv:@"05e878eaaefc205e1b130545472aa230"];
    
    return aes256Decrypt.utf8String;
}

//md5加密
+ (NSString *)md5Encryption:(NSString *)str{
    CocoaSecurityResult *md5 = [CocoaSecurity md5:str];
    return md5.hexLower;
}
@end
