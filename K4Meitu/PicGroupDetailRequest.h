//
//  PicGroupDetailRequest.h
//  K4Meitu
//
//  Created by simpleem on 6/21/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PYPhotoBrowser.h"
#import "PicGroupDetailTitleDetailView.h"
typedef void(^DataBlock)(NSMutableArray *dataArr,NSNumber *maxPage,NSNumber *commentCount, NSNumber *likeCount);
typedef void(^isLikeBlock)(BOOL isLike);
typedef void(^addCommentBlock)(BOOL isSuccess);
typedef void(^addCommentLikeBlock)(BOOL isSuccess);

@interface PicGroupDetailRequest : NSObject

+ (void)requestData:(NSString *)groupId dataBlock:(DataBlock)block;
+ (PYPhotosView *)imgScrollView:(NSMutableArray *)imgUrls;
+ (void)requestCommentData:(NSString *)groupId CurPage:(NSNumber *)curPage pcout:(NSNumber *)pCount dataBlock:(DataBlock)block;;
+ (UIButton *)addBackBtn;
+ (PicGroupDetailTitleDetailView *)titleDetailView:(NSString *)title picCount:(int)count type:(NSString *)type date:(NSString *)date cmtCount:(int)commentCount likeCount:(int)likeCount;
+ (UILabel *)commentLab:(CGRect)frame;
+ (void)requestLikeData:(NSString *)groupId titleDetailView:(PicGroupDetailTitleDetailView *)titleDetailView;
+ (void)requestIsLikeExistGroupID:(NSString *)groupId isLike:(isLikeBlock)block;
+ (UIButton *)addCommentBtn;
+ (void)requestAddComment:(NSString *)comment imgId:(NSNumber *)imgId groupId:(NSString *)groupId resblock:(addCommentBlock)block;
+ (void)requestAddCommentLike:(NSNumber *)commentId commentLike:(NSNumber *)commentLike groupId:(NSString *)groupId cmtUserId:(NSString *)cmtUserId commentDislike:(NSNumber *)commentDislike resBlock:(addCommentLikeBlock)block;


@end
