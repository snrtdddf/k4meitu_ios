//
//  SecPageVCRequest.h
//  K4Meitu
//
//  Created by simpleem on 7/12/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "funcBtnListView.h"
#import "SecPageHotCmtView.h"
#import "SecPageMaxRecordView.h"
#import "GroupMenuBtnModel.h"
#import "PicGroupColHeaderView.h"
typedef void(^DataBlock)(NSMutableArray *dataArr);
typedef void(^PicGroupDataBlock)(NSMutableArray *dataArr,NSInteger maxPage);
@interface SecPageVCRequest : NSObject

+ (void)requestFromKeywordList:(DataBlock)block;
+ (void)requestFromMenuBtnList:(DataBlock)block;
+ (void)requestFromPicGroupListCurPage:(NSNumber *)curPage PageCount:(NSNumber *)pageCount dataBlock:(PicGroupDataBlock)block;
+ (SecPageHotCmtView *)hotCommentViewFrame:(CGRect)frame dataArr:(NSMutableArray *)dataArr;
+ (SecPageMaxRecordView *)maxRecordViewFrame:(CGRect)frame dataModel:(GroupMenuBtnModel *)model;
+ (UIButton *)midderBannerADviewFrame:(CGRect)frame imgUrl:(NSString *)url;
+ (PicGroupColHeaderView *)colHeaderViewFrame:(CGRect)frame;

@end
