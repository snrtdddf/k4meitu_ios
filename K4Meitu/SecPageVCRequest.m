//
//  SecPageVCRequest.m
//  K4Meitu
//
//  Created by simpleem on 7/12/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "SecPageVCRequest.h"
#import <NSObject+YYModel.h>
#import <YYDiskCache.h>
#import "RequestManager.h"
#import "Header.h"
#import "GroupKeywordModel.h"
#import "GroupMenuBtnModel.h"
#import <UIImageView+WebCache.h>
#import "commonTools.h"
#import "CCPScrollView.h"
#import "MainPagePicModel.h"
#import "GetCurrentTime.h"
#import "SDCycleScrollView.h"
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
                    [hotCmtArr addObject:model];
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

+ (SecPageHotCmtView *)hotCommentViewFrame:(CGRect)frame dataArr:(NSMutableArray *)dataArr cycleScrollView:(SDCycleScrollView *)cycleScrollView{
   
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"SecPageHotCmtView" owner:nil options:nil];
    
    SecPageHotCmtView *hotCmtView = [nibContents lastObject];
    hotCmtView.frame = frame;
    
    //取标题数据
   
    NSMutableArray *imgUrls = [NSMutableArray array];
    NSMutableArray *titles = [NSMutableArray array];
    for (GroupMenuBtnModel *model in dataArr) {
        [imgUrls addObject:model.titleImgUrl];
        [titles addObject:model.subTitle];
    }
    //网络加载 --- 创建带标题的图片轮播器
    
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.showPageControl = NO;
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
   // cycleScrollView.bannerImageViewContentMode = UIViewContentModeCenter;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    cycleScrollView.autoScrollTimeInterval = 3.0;
    cycleScrollView.titleLabelTextColor = Black_COLOR;
    cycleScrollView.titleLabelBackgroundColor = [UIColor whiteColor];
    cycleScrollView.titleLabelTextAlignment = NSTextAlignmentLeft;
    cycleScrollView.titleLabelTextFont = [UIFont systemFontOfSize:12.0f];
    cycleScrollView.titleLabelHeight = 22;
    //cycleScrollView.imageURLStringsGroup = imgUrls;
    cycleScrollView.titlesGroup = titles;
    cycleScrollView.onlyDisplayText = YES;

    [hotCmtView.scrollImg addSubview:cycleScrollView];
    
    return hotCmtView;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"-点击了第%ld张图片", (long)index);
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


+ (NSDictionary *)funcBtnControllerDictionary{
    /*
     @"搞笑GIF":@{
                @"className":@"JiongPicNewestVC",
                @"property":@{@"groupId":@"22220172999",
                            @"Title":@"第一个controller"
                },
                @"method":@"requestData"
     }
     */
    NSDictionary *dict = @{
                           @"搞笑GIF":@{
                                   @"className":@"JiongPicNewestVC"
                                   },
                           @"囧图":@{
                                   @"className":@"JiongStaticImageVC"
                                   },
                           @"吐槽":@{
                                   @"className":@"TuCaoPicVC"
                                   }
                           };
    return dict;
}
@end
