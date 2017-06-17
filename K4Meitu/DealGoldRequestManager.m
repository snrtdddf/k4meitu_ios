//
//  DealGoldRequestManager.m
//  DealGold
//
//  Created by simpleem on 16/9/7.
//  Copyright © 2016年 China_Gold_Infomation. All rights reserved.
//

#import "DealGoldRequestManager.h"
#import "Connection.h"
#import "Header.h"

#define PostMethod  myConnection;[connect PostTextURL:URLPrefix parameters:paraDict Success:^(NSData *data) { succeed(data);} andFail:^(NSError *error) { failed(error);} isIndicatorShow:YES]
#define PostMethod_NO_Indicator  myConnection;[connect PostTextURL:URLPrefix parameters:paraDict Success:^(NSData *data) { succeed(data);} andFail:^(NSError *error) { failed(error);} isIndicatorShow:NO]
#define PostMethodDG  myConnection;[connect PostTextURL:URLPrefixDealGold parameters:paraDict Success:^(NSData *data) { succeed(data);} andFail:^(NSError *error) { failed(error);} isIndicatorShow:YES]
#define PostMethodDG_NO_Indicator  myConnection;[connect PostTextURL:URLPrefixDealGold parameters:paraDict Success:^(NSData *data) { succeed(data);} andFail:^(NSError *error) { failed(error);} isIndicatorShow:NO]

@implementation DealGoldRequestManager
#pragma mark
#pragma mark -------------------------个人信息接口-----------------------------------
#pragma mark 退出当前账户


+ (void)registerUser:(Succeed)succeed failed:(Failed)failed{
    
}


+ (void)getLoginSign:(Succeed)succeed failed:(Failed)failed{
    NSDictionary *paramDict = @{@"method":@"p.user.login",
                                @"channel":APPCHANNEL,
                                @"ip":getIpAddress
                                };
}

#pragma mark ------------------------------END---------------------------------
@end


