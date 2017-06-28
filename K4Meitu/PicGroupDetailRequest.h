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
typedef void(^DataBlock)(NSMutableArray *dataArr,NSNumber *maxPage);

@interface PicGroupDetailRequest : NSObject

+ (void)requestData:(NSString *)groupId dataBlock:(DataBlock)block;
+ (PYPhotosView *)imgScrollView:(NSMutableArray *)imgUrls;
+ (void)requestCommentData:(NSString *)groupId CurPage:(NSNumber *)curPage pcout:(NSNumber *)pCount dataBlock:(DataBlock)block;;
+ (UIButton *)addBackBtn;
+ (UIView *)titleDetailView:(NSString *)title picCount:(int)count type:(NSString *)type date:(NSString *)date cmtCount:(int)commentCount likeCount:(int)likeCount;
+ (UILabel *)commentLab:(CGRect)frame;

@end
