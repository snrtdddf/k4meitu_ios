//
//  DealGoldRequestManager.h
//  DealGold
//
//  Created by simpleem on 16/9/7.
//  Copyright © 2016年 China_Gold_Infomation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^Succeed)(NSData * data);
typedef void(^Failed)(NSError *error);

// simpleem------
//typedef void(^Succeed2)(id data);

@interface DealGoldRequestManager : NSObject



/**
 获取登录状态

 @param succeed <#succeed description#>
 @param failed <#failed description#>
 */
+ (void)getLoginSign:(Succeed)succeed failed:(Failed)failed;

@end
