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
    PostMethod_NO_Indicator;
}

/**
 获取搞笑GIF的图片
 
 @param succeed <#succeed description#>
 @param failed <#failed description#>
 */
+ (void)getJiongPicNewsListCurPage:(NSNumber *)curPage pCount:(NSNumber *)pCount success:(Succeed)succeed failed:(Failed)failed{
    NSDictionary *paraDict = @{@"method":@"p.main.getGifPicNewest",
                               @"curPage":curPage,
                               @"pCount":pCount,
                               @"type":@"gaoxiaoGIF",
                               ParamDictNeed
                               };
    PostMethod;
}

/**
 获取囧图的图片
 
 @param succeed <#succeed description#>
 @param failed <#failed description#>
 */
+ (void)getJiongStaticImageCurPage:(NSNumber *)curPage pCount:(NSNumber *)pCount type:(NSString *)type success:(Succeed)succeed failed:(Failed)failed{
    NSDictionary *paraDict = @{@"method":@"p.main.getGifPicNewest",
                               @"curPage":curPage,
                               @"pCount":pCount,
                               @"type":type,
                               ParamDictNeed
                               };
    PostMethod;
}

/**
 获取吐槽图组
 
 @param succeed <#succeed description#>
 @param failed <#failed description#>
 */
+ (void)getTuCaoPicCurPage:(NSNumber *)curPage pCount:(NSNumber *)pCount success:(Succeed)succeed failed:(Failed)failed{
    NSDictionary *paraDict = @{@"method":@"p.main.getGifPicNewest",
                               @"curPage":curPage,
                               @"pCount":pCount,
                               @"type":@"tucao",
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
/**
 图组点倒
 
 @param groupId <#groupId description#>
 @param succeed <#succeed description#>
 @param failed <#failed description#>
 */
+ (void)addPicGroupDislikeDataGroupId:(NSString *)groupId  success:(Succeed)succeed failed:(Failed)failed{
    NSDictionary *paraDict = @{@"method":@"p.comment.addLike",
                               @"groupId":groupId,
                               @"userId":userID,
                               @"imgLike":@0,
                               @"imgDislike":@1,
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


+ (void)addPicGroupCommentLike:(NSNumber *)commentId cmtLike:(NSNumber *)commentLike cmtDislike:(NSNumber *)commentDislike groupId:(NSString *)groupId cmtUserId:(NSString *)cmtUserId success:(Succeed)succeed failed:(Failed)failed{
    NSDictionary *paraDict = @{@"method":@"p.comment.commentLike",
                               @"commentLike":commentLike,
                               @"commentDislike":commentDislike,
                               @"id":commentId,
                               @"groupId":groupId,
                               @"imgId":@"1",
                               @"likeUserId":userID,
                               @"userId":cmtUserId,
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
    PostMethod_NO_Indicator;
}

+ (void)getPicGroupByKeyword:(NSString *)keyword curPage:(NSNumber *)curPage pCount:(NSNumber *)pCount success:(Succeed)succeed failed:(Failed)failed{
    NSDictionary *paraDict = @{@"method":@"p.main.findKeyword",
                               @"curPage":curPage,
                               @"pCount":pCount,
                               @"keyword":keyword,
                               ParamDictNeed
                               };
    PostMethod_NO_Indicator;
}

#pragma mark ------------------------------END---------------------------------

#pragma mark
#pragma mark ------------------------------动图---------------------------------
+ (void)addGifPicGroupLikeId:(NSNumber *)Gid Like:(NSNumber *)like dislike:(NSNumber *)dislike groupId:(NSString *)groupId success:(Succeed)succeed failed:(Failed)failed{
    NSDictionary *paraDict = @{@"method":@"p.comment.addGifPicGroupLike",
                               @"like":like,
                               @"dislike":dislike,
                               @"id":Gid,
                               @"groupId":groupId,
                               @"imgId":@"1",
                               @"likeUserId":userID,
                               @"userId":@"adminadminadminadminadminadminad",
                               ParamDictNeed
                               };
    PostMethod_NO_Indicator;
    
}



#pragma mark ------------------------------END---------------------------------

#pragma mark
#pragma mark -----------------------------文章---------------------------------

+ (void)getArticleLatestCurPage:(NSNumber *)curPage pCount:(NSNumber *)pCount success:(Succeed)succeed failed:(Failed)failed{
    NSDictionary *paraDict = @{@"method":@"p.article.latest",
                               @"curPage":curPage,
                               @"pCount":pCount,
                               ParamDictNeed
                               };
    PostMethod;
}

+ (void)getArticleLatestByType:(NSString *)type subType:(NSString *)subType CurPage:(NSNumber *)curPage pCount:(NSNumber *)pCount success:(Succeed)succeed failed:(Failed)failed{
    NSDictionary *paraDict = @{@"method":@"p.article.getArticleByType",
                               @"type":type,
                               @"subType":subType,
                               @"curPage":curPage,
                               @"pCount":pCount,
                               ParamDictNeed
                               };
    PostMethod;
}

#pragma mark ------------------------------END---------------------------------
@end

