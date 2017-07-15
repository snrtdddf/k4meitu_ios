//
//  SecPageVCRequest.m
//  K4Meitu
//
//  Created by simpleem on 7/12/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "SecPageVCRequest.h"
#import <NSObject+YYModel.h>
#import "RequestManager.h"
#import "Header.h"
#import "GroupKeywordModel.h"
#import "GroupMenuBtnModel.h"
#import <UIImageView+WebCache.h>
@implementation SecPageVCRequest
+ (void)requestFromKeywordList:(DataBlock)block{
    [RequestManager getKeyWordListIsOrderByCount:@"NO" CurPage:@0 pCount:@10 success:^(NSData *data) {
        NSMutableArray *dataArr = [NSMutableArray array];
        NSDictionary *resDict = myJsonSerialization;
        NSArray *resArr = resDict[@"res"][@"list"];
        if (resArr.count != 0) {
            for (NSDictionary *dict in resArr) {
                GroupKeywordModel *model = [GroupKeywordModel modelWithJSON:dict];
                [dataArr addObject:model];
            }
            block(dataArr);
        }
    } failed:^(NSError *error) {
        
    }];
}

+ (void)requestFromMenuBtnList:(DataBlock)block{
    [RequestManager getGroupMenuBtnSuccess:^(NSData *data) {
        NSMutableArray *dataArr = [NSMutableArray array];
        NSMutableArray *scrollAdArr = [NSMutableArray array];
        NSMutableArray *menuBtnArr = [NSMutableArray array];
        NSMutableArray *maxRecordArr = [NSMutableArray array];
        
        NSDictionary *resDict = myJsonSerialization;
        NSArray *resArr = resDict[@"res"][@"list"];
        
        if (resArr.count != 0) {
            for (NSDictionary *dict in resArr) {
                GroupMenuBtnModel *model = [GroupMenuBtnModel modelWithJSON:dict];
                if ([model.type isEqualToString:@"menuBtn"]) {
                    [menuBtnArr addObject:model];
                }else if ([model.type isEqualToString:@"scrollAD"]){
                    [scrollAdArr addObject:model.titleImgUrl];
                }else if ([model.type isEqualToString:@"maxRecord"]){
                    [maxRecordArr addObject:model];
                }
            }
            [dataArr addObject:menuBtnArr];
            [dataArr addObject:scrollAdArr];
            [dataArr addObject:maxRecordArr];
            block(dataArr);
           
        }

    } failed:^(NSError *error) {
        
    }];
}

+ (SecPageHotCmtView *)hotCommentViewFrame:(CGRect)frame{
   
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"SecPageHotCmtView" owner:nil options:nil];
    
    SecPageHotCmtView *hotCmtView = [nibContents lastObject];
    hotCmtView.frame = frame;
    hotCmtView.hotCmtLab1.layer.borderColor = Red_COLOR.CGColor;
    hotCmtView.hotCmtLab2.layer.borderColor = Red_COLOR.CGColor;
    hotCmtView.hotCmtLab1.layer.borderWidth = 1;
    hotCmtView.hotCmtLab2.layer.borderWidth = 1;
    hotCmtView.hotCmtLab1.layer.cornerRadius = 3;
    hotCmtView.hotCmtLab2.layer.cornerRadius = 3;
    hotCmtView.hotCmtLab1.clipsToBounds = YES;
    hotCmtView.hotCmtLab2.clipsToBounds = YES;
    hotCmtView.hotCmtLab1.textColor = Red_COLOR;
    hotCmtView.hotCmtLab2.textColor = Red_COLOR;
    
    return hotCmtView;
}

+ (SecPageMaxRecordView *)maxRecordViewFrame:(CGRect)frame dataModel:(GroupMenuBtnModel *)model{
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"SecPageMaxRecordView" owner:nil options:nil];
    
    SecPageMaxRecordView *maxRecordView = [nibContents lastObject];
    maxRecordView.frame = frame;
    maxRecordView.title.text = model.title;
    maxRecordView.subTitle.text = model.subTitle;
    [maxRecordView.titleImg sd_setImageWithURL:[NSURL URLWithString:model.titleImgUrl] placeholderImage:[UIImage imageNamed:@"photo"]];
    [maxRecordView.smallImg sd_setImageWithURL:[NSURL URLWithString:model.imgUrl1] placeholderImage:[UIImage imageNamed:@"photo"]];
    [maxRecordView.bigImg sd_setImageWithURL:[NSURL URLWithString:model.imgUrl2] placeholderImage:[UIImage imageNamed:@"photo"]];
    
    return maxRecordView;
}

@end
