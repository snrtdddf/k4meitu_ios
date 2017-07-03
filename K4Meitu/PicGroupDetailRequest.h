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
@interface PicGroupDetailRequest : NSObject

+ (void)requestData:(NSString *)groupId dataBlock:(DataBlock)block;
+ (PYPhotosView *)imgScrollView:(NSMutableArray *)imgUrls;
+ (void)requestCommentData:(NSString *)groupId CurPage:(NSNumber *)curPage pcout:(NSNumber *)pCount dataBlock:(DataBlock)block;;
+ (UIButton *)addBackBtn;
+ (PicGroupDetailTitleDetailView *)titleDetailView:(NSString *)title picCount:(int)count type:(NSString *)type date:(NSString *)date cmtCount:(int)commentCount likeCount:(int)likeCount;
+ (UILabel *)commentLab:(CGRect)frame;
+ (UITextField *)commentTF:(CGRect)frame;
+ (void)requestLikeData:(NSString *)groupId titleDetailView:(PicGroupDetailTitleDetailView *)titleDetailView;
+ (void)requestIsLikeExistGroupID:(NSString *)groupId isLike:(isLikeBlock)block;
@end
