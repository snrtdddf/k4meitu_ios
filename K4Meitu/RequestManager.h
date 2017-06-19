//
//  RequestManager.h
//  K4Meitu
//
//  Created by simpleem on 6/17/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^Succeed)(NSData * data);
typedef void(^Failed)(NSError *error);


@interface RequestManager : NSObject


/**
 用户注册
 
 @param succeed <#succeed description#>
 @param failed <#failed description#>
 */
+ (void)registerUser:(Succeed)succeed failed:(Failed)failed;


/**
 获取登录状态
 
 @param succeed <#succeed description#>
 @param failed <#failed description#>
 */
+ (void)userLogin:(Succeed)succeed failed:(Failed)failed;


@end
