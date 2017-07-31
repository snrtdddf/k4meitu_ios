//
//  RequestManager.h
//  K4Meitu
//
//  Created by simpleem on 6/17/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Header.h"
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
+ (void)getMainPagePicListCurPage:(NSNumber *)curPage pCount:(NSNumber *)pCount requestBlock;


/**
 获取图组图片详情

 @param groupId 图组Id
 @param succeed <#succeed description#>
 @param failed <#failed description#>
 */
+ (void)getMainPagePicListDetailGroupId:(NSString *)groupId requestBlock;


/**
 获取评论

 @param groupId <#groupId description#>
 @param curPage <#curPage description#>
 @param pCount <#pCount description#>
 @param succeed <#succeed description#>
 @param failed <#failed description#>
 */
+ (void)getPicGroupCommentGroupId:(NSString *)groupId CurPage:(NSNumber *)curPage pCount:(NSNumber *)pCount requestBlock;


/**
 点赞

 @param groupId <#groupId description#>
 @param succeed <#succeed description#>
 @param failed <#failed description#>
 */
+ (void)addPicGroupLikeDataGroupId:(NSString *)groupId  requestBlock;


/**
 是否已经点赞

 @param groupId <#groupId description#>
 */
+ (void)isPicGroupLikeExistGroupId:(NSString *)groupId requestBlock;


/**
 图组添加评论

 @param comment <#comment description#>
 @param imgId <#imgId description#>
 @param groupId <#groupId description#>
 */
+ (void)addPicGroupComment:(NSString *)comment imgId:(NSNumber *)imgId groupId:(NSString *)groupId requestBlock;


/**
 评论点赞

 @param commentId <#commentId description#>
 @param commentLike <#commentLike description#>
 @param commentDislike <#cmtDislike description#>
 */
+ (void)addPicGroupCommentLike:(NSNumber *)commentId cmtLike:(NSNumber *)commentLike cmtDislike:(NSNumber *)commentDislike requestBlock;


/**
 获取keyword列表

 @param orderByCount <#orderByCount description#>
 @param curPage <#curPage description#>
 @param pCount <#pCount description#>
 */
+ (void)getKeyWordListIsOrderByCount:(NSString *)orderByCount CurPage:(NSNumber *)curPage pCount:(NSNumber *)pCount requestBlock;


/**
 获取菜单按钮

 @param succeed <#succeed description#>
 @param failed <#failed description#>
 */
+ (void)getGroupMenuBtnSuccess:(Succeed)succeed failed:(Failed)failed;

/**
 获取囧图的图片
 
 @param succeed <#succeed description#>
 @param failed <#failed description#>
 */
+ (void)getJiongPicNewsListCurPage:(NSNumber *)curPage pCount:(NSNumber *)pCount requestBlock;
@end
