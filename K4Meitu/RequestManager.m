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
 获取囧图的图片
 
 @param succeed <#succeed description#>
 @param failed <#failed description#>
 */
+ (void)getJiongPicNewsListCurPage:(NSNumber *)curPage pCount:(NSNumber *)pCount success:(Succeed)succeed failed:(Failed)failed{
    NSDictionary *paraDict = @{@"method":@"p.main.getGifPicNewest",
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
    NSLog(@"a&&&&&%@",paraDict);

}


/**
 图组点赞

 @param groupId <#groupId description#>
 @param succeed <#succeed description#>
 @param failed <#failed description#>
 */
+ (void)addPicGroupLikeDataGroupId:(NSString *)groupId  success:(Succeed)succeed failed:(Failed)failed{
    NSDictionary *paraDict = @{@"method":@"p.comment.addLike",
                               @"groupId":groupId,
                               @"userId":userID,
                               @"imgLike":@1,
                               @"imgDislike":@0,
                               @"imgId":@1,
                               ParamDictNeed
                               };
    PostMethod_NO_Indicator;

}


+ (void)isPicGroupLikeExistGroupId:(NSString *)groupId success:(Succeed)succeed failed:(Failed)failed{
    NSDictionary *paraDict = @{@"method":@"p.comment.isLikeExist",
                               @"groupId":groupId,
                               @"userId":userID,
                               ParamDictNeed
                               };
    PostMethod_NO_Indicator;
}


+ (void)addPicGroupComment:(NSString *)comment imgId:(NSNumber *)imgId groupId:(NSString *)groupId success:(Succeed)succeed failed:(Failed)failed{
    NSDictionary *paraDict = @{@"method":@"p.comment.addComment",
                               @"groupId":groupId,
                               @"userId":userID,
                               @"imgId":imgId,
                               @"imgComment":comment,
                               ParamDictNeed
                               };
    PostMethod_NO_Indicator;
}


+ (void)addPicGroupCommentLike:(NSNumber *)commentId cmtLike:(NSNumber *)commentLike cmtDislike:(NSNumber *)commentDislike success:(Succeed)succeed failed:(Failed)failed{
    NSDictionary *paraDict = @{@"method":@"p.comment.commentLike",
                               @"commentLike":commentLike,
                               @"commentDislike":commentDislike,
                               @"id":commentId,
                               ParamDictNeed
                               };
    PostMethod_NO_Indicator;
}

+ (void)getKeyWordListIsOrderByCount:(NSString *)orderByCount CurPage:(NSNumber *)curPage pCount:(NSNumber *)pCount success:(Succeed)succeed failed:(Failed)failed{
    NSDictionary *paraDict = @{@"method":@"p.main.keywordList",
                               @"curPage":curPage,
                               @"pCount":pCount,
                               @"orderByCount":@"NO",
                               ParamDictNeed
                               };
    PostMethod_NO_Indicator;
}

+ (void)getGroupMenuBtnSuccess:(Succeed)succeed failed:(Failed)failed{
    NSDictionary *paraDict = @{@"method":@"p.main.getMenuBtn",
                               ParamDictNeed
                               };
    PostMethod;
}
#pragma mark ------------------------------END---------------------------------
@end

