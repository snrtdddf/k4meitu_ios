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


/**
 获取登录状态
 
 @param succeed <#succeed description#>
 @param failed <#failed description#>
 */
+ (void)userLogin:(Succeed)succeed failed:(Failed)failed{
    NSDictionary *paraDict = @{@"method":@"p.user.login",
                               @"userId":userID,
                               ParamDictNeed
                               };
    PostMethod;
}

/**
 获取首页的图片
 
 @param succeed <#succeed description#>
 @param failed <#failed description#>
 */
+ (void)getMainPagePicListCurPage:(NSNumber *)curPage pCount:(NSNumber *)pCount success:(Succeed)succeed failed:(Failed)failed{
    NSDictionary *paraDict = @{@"method":@"p.main.getGroup",
                               @"curPage":curPage,
                               @"pCount":pCount,
                               ParamDictNeed
                               };
    PostMethod;
}


/**
 获取图组图片详情
 
 @param groupId 图组Id
 @param succeed <#succeed description#>
 @param failed <#failed description#>
 */
+ (void)getMainPagePicListDetailGroupId:(NSString *)groupId success:(Succeed)succeed failed:(Failed)failed{
    NSDictionary *paraDict = @{@"method":@"p.main.getGroupDetail",
                               @"groupId":groupId,
                                ParamDictNeed
                               };
    PostMethod;
}

/**
 获取评论
 
 @param groupId <#groupId description#>
 @param curPage <#curPage description#>
 @param pCount <#pCount description#>
 @param succeed <#succeed description#>
 @param failed <#failed description#>
 */
+ (void)getPicGroupCommentGroupId:(NSString *)groupId CurPage:(NSNumber *)curPage pCount:(NSNumber *)pCount success:(Succeed)succeed failed:(Failed)failed{
    NSDictionary *paraDict = @{@"method":@"p.comment.getComment",
                               @"groupId":groupId,
                               @"curPage":curPage,
                               @"pCount":pCount,
                               ParamDictNeed
                               };
    PostMethod_NO_Indicator;

}

#pragma mark ------------------------------END---------------------------------
@end

