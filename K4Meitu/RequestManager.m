//
//  RequestManager.m
//  K4Meitu
//
//  Created by simpleem on 6/17/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "RequestManager.h"
#import "Connection.h"
#import "Header.h"

#define PostMethod  myConnection;[connect PostTextURL:URLPrefix parameters:paraDict Success:^(NSData *data) { succeed(data);} andFail:^(NSError *error) { failed(error);} isIndicatorShow:YES]
#define PostMethod_NO_Indicator  myConnection;[connect PostTextURL:URLPrefix parameters:paraDict Success:^(NSData *data) { succeed(data);} andFail:^(NSError *error) { failed(error);} isIndicatorShow:NO]


@implementation RequestManager
#pragma mark 退出当前账户


/**
 用户注册
 
 @param succeed <#succeed description#>
 @param failed <#failed description#>
 */
+ (void)registerUser:(Succeed)succeed failed:(Failed)failed{
    NSDictionary *paraDict = @{@"method":@"p.user.registerUser",
                               ParamDictNeed
                               };
    PostMethod;
}


+ (void)userLogin:(Succeed)succeed failed:(Failed)failed{
    NSDictionary *paraDict = @{@"method":@"p.user.login",
                               @"userId":userId,
                               ParamDictNeed
                               };
    PostMethod;
}

#pragma mark ------------------------------END---------------------------------
@end

