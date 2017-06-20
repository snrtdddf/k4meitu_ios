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


/**
 获取首页的图片
http://snrtdddf.hopto.org:8080/pic/api.action?method=p.main.getGroup&title=1&type=1&groupid=222&ip=192.168.1.1&channel=iOS&curPage=10&pCount=10
 @param succeed <#succeed description#>
 @param failed <#failed description#>
 */
+ (void)getMainPagePicListCurPage:(NSNumber *)curPage pCount:(NSNumber *)pCount success:(Succeed)succeed failed:(Failed)failed;

@end