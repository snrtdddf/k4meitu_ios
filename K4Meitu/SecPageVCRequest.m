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
#import "commonTools.h"
#import "CCPScrollView.h"
#import "MainPagePicModel.h"
#import "GetCurrentTime.h"
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
        NSMutableArray *hotCmtArr = [NSMutableArray array];
        NSMutableArray *maxRecordArr = [NSMutableArray array];
        NSMutableArray *bannerADArr = [NSMutableArray array];
        NSMutableArray *hotCmtSubArr1 = [[NSMutableArray alloc] init];
        NSMutableArray *hotCmtSubArr2 = [[NSMutableArray alloc] init];
        
        NSDictionary *resDict = myJsonSerialization;
        NSArray *resArr = resDict[@"res"][@"list"];
        NSLog(@"resD:%@",resDict);
        if (resArr.count != 0) {
            for (NSDictionary *dict in resArr) {
                GroupMenuBtnModel *model = [GroupMenuBtnModel modelWithJSON:dict];
                if ([model.type isEqualToString:@"menuBtn"]) {
                    [menuBtnArr addObject:model];
                }else if ([model.type isEqualToString:@"scrollAD"]){
                    [scrollAdArr addObject:model.titleImgUrl];
                }else if ([model.type isEqualToString:@"hotComment"]){
                    if ([model.groupId isEqualToString:@"1"]) {
                        [hotCmtSubArr1 addObject:model];
                    }else if([model.groupId isEqualToString:@"2"]){
                        [hotCmtSubArr2 addObject:model];
                    }
                }else if ([model.type isEqualToString:@"maxRecord"]){
                    [maxRecordArr addObject:model];
                }else if ([model.type isEqualToString:@"bannerAD"]){
                    if (IPHONE_WIDTH <= 540) {
                        if ([model.title isEqualToString:@"iPhone"]) {
                            [bannerADArr removeAllObjects];
                            [bannerADArr addObject:model];
                        }
                    }else{
                        if ([model.title isEqualToString:@"iPad"]) {
                            [bannerADArr removeAllObjects];
                            [bannerADArr addObject:model];
                        }
                    }
                }
            }
            [hotCmtArr addObject:hotCmtSubArr1];
            [hotCmtArr addObject:hotCmtSubArr2];
            [dataArr addObject:scrollAdArr];
            [dataArr addObject:menuBtnArr];
            [dataArr addObject:hotCmtArr];
            [dataArr addObject:maxRecordArr];
            [dataArr addObject:bannerADArr];
            
            block(dataArr);
           
        }

    } failed:^(NSError *error) {
        
    }];
}

+ (void)requestFromPicGroupListCurPage:(NSNumber *)curPage PageCount:(NSNumber *)pageCount dataBlock:(PicGroupDataBlock)block{
    
    [RequestManager getMainPagePicListCurPage:curPage pCount:pageCount success:^(NSData *data) {
        NSDictionary *resDict = myJsonSerialization;
        if ([resDict[@"success"] boolValue]) {
            NSArray *resArr = resDict[@"res"][@"list"];
            NSMutableArray *dataArr = [NSMutableArray array];
            NSLog(@"count:%ld",resArr.count);
            if (resArr.count != 0) {
                NSInteger maxPage = [resDict[@"res"][@"maxPage"] intValue];
                
                for (NSDictionary *dict in resArr) {
                    MainPagePicModel *model = [[MainPagePicModel alloc] init];
                    model.groupId = dict[@"groupId"];
                    model.title = dict[@"title"];
                    model.count = [dict[@"count"] intValue];
                    model.type  = dict[@"type"];
                    model.imgUrl = dict[@"imgUrl"];
                    model.date = [GetCurrentTime GetTimeFromTimeStamp:[NSString stringWithFormat:@"%@",dict[@"date"]] andReturnTimeType:YYYY_MM_DD_and_HH_MM_SS];
                    model.imgCoverName = dict[@"imgCoverName"];
                    model.imgCoverHeight = [dict[@"imgCoverHeight"] intValue];
                    model.imgCoverWidth = [dict[@"imgCoverWidth"] intValue];
                    
                    [dataArr addObject:model];
                }
                block(dataArr,maxPage);
            }
        }else{
            [commonTools showBriefAlert:resDict[@"ErrorMsg"]];
        }
    } failed:^(NSError *error) {
        
    }];
   

}

+ (SecPageHotCmtView *)hotCommentViewFrame:(CGRect)frame dataArr:(NSMutableArray *)dataArr{
   
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
    hotCmtView.cmtView1.frame = CGRectMake(0, 2, IPHONE_WIDTH*0.65, 20);
    hotCmtView.cmtView2.frame = CGRectMake(0, 24, IPHONE_WIDTH*0.65, 20);
    
    CCPScrollView *ccpView1 = [[CCPScrollView alloc] initWithFrame:CGRectMake(0, 0, hotCmtView.cmtView1.frame.size.width, hotCmtView.cmtView1.frame.size.height)];
    CCPScrollView *ccpView2 = [[CCPScrollView alloc] initWithFrame:CGRectMake(0, 0, hotCmtView.cmtView2.frame.size.width, hotCmtView.cmtView2.frame.size.height)];
   
    
    //取标题数据
    NSMutableArray *arr1 = dataArr[0];
    NSMutableArray *arr2 = dataArr[1];
    NSMutableArray *titleArr1 = [NSMutableArray array];
    for (GroupMenuBtnModel *model in dataArr[0]) {
        [titleArr1 addObject:model.subTitle];
    }
    NSMutableArray *titleArr2 = [NSMutableArray array];
    for (GroupMenuBtnModel *model in dataArr[1]) {
        [titleArr2 addObject:model.subTitle];
    }
    
    GroupMenuBtnModel *model1 = arr1[0];
    hotCmtView.hotCmtLab1.text = model1.title;
    GroupMenuBtnModel *model2 = arr2[0];
    hotCmtView.hotCmtLab2.text = model2.title;
    
    ccpView1.titleArray = titleArr1;
    ccpView2.titleArray = titleArr2;
    ccpView1.titleFont = 13;
    ccpView1.titleColor = [UIColor blackColor];
    ccpView2.titleFont = 13;
    ccpView2.titleColor = [UIColor blackColor];
    [ccpView1 clickTitleLabel:^(NSInteger index,NSString *titleString) {
        NSLog(@"%@--%ld",titleString,index);
    }];
    [ccpView2 clickTitleLabel:^(NSInteger index,NSString *titleString) {
        NSLog(@"%@--%ld",titleString,index);
    }];
    [hotCmtView.cmtView1 addSubview:ccpView1];
    [hotCmtView.cmtView2 addSubview:ccpView2];

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
    maxRecordView.smallImg.contentMode = UIViewContentModeScaleAspectFill;
    maxRecordView.smallImg.clipsToBounds = YES;
    [maxRecordView.bigImg sd_setImageWithURL:[NSURL URLWithString:model.imgUrl2] placeholderImage:[UIImage imageNamed:@"photo"]];
    
    return maxRecordView;
}

+ (UIButton *)midderBannerADviewFrame:(CGRect)frame imgUrl:(NSString *)url{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    //300*70
    if ([url hasPrefix:@"http"]) {
        [commonTools sd_setImg:img imgUrl:url placeHolderImgName:@"photo"];
    }else{
        img.image = [UIImage imageNamed:@"test1.jpg"];
    }
    
    [btn addSubview:img];
    return btn;
}

+ (PicGroupColHeaderView *)colHeaderViewFrame:(CGRect)frame{
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"PicGroupColHeaderView" owner:nil options:nil];
    PicGroupColHeaderView *colHeaderView = [nibContents lastObject];
    colHeaderView.frame = frame;
    
    return colHeaderView;
}

@end
