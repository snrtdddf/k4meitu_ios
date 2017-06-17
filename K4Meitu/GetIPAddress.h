//
//  GetIPAddress.h
//  GoldWallet
//
//  Created by simpleem on 16/7/27.
//  Copyright © 2016年 China_Gold_Infomation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetIPAddress : NSObject
+ (NSString *)getIPAddress:(BOOL)preferIPv4;

+ (BOOL)isValidatIP:(NSString *)ipAddress;

+ (NSDictionary *)getIPAddresses;
@end
