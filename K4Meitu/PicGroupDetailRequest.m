//
//  PicGroupDetailRequest.m
//  K4Meitu
//
//  Created by simpleem on 6/21/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "PicGroupDetailRequest.h"
#import "RequestManager.h"
#import "Header.h"
#import "commonTools.h"
#import "PicGroupDetailModel.h"
#import "GetCurrentTime.h"
#import "PicGroupCommentModel.h"
#import "UIButton+enLargedRect.h"
#import <NSObject+YYModel.h>
#import "IDMPhotoBrowser.h"
@implementation PicGroupDetailRequest

+ (void)requestData:(NSString *)groupId  dataBlock:(DataBlock)block{
    [RequestManager getMainPagePicListDetailGroupId:groupId success:^(NSData *data) {
        NSDictionary *resDict = myJsonSerialization;
        NSMutableArray *dataArr = [NSMutableArray array];
        //NSLog(@"res:%@",resDict);
        [commonTools HideActivityIndicator];
        if ([resDict[@"success"] boolValue]) {
            NSArray *list = resDict[@"res"][@"list"];
            if (list.count != 0) {
                for (NSDictionary *dict in list) {
                    PicGroupDetailModel *model = [[PicGroupDetailModel alloc] init];
                    model.groupId = dict[@"groupId"];
                    model.imgTitle = dict[@"imgTitle"];
                    model.imgWidth = [dict[@"imgWidth"] intValue];
                    model.imgHeight = [dict[@"imgHeight"] intValue];
                    model.date = [GetCurrentTime GetTimeFromTimeStamp:[NSString stringWithFormat:@"%@",dict[@"date"]] andReturnTimeType:YYYY_MM_DD];
                    model.imgContent = dict[@"imgContent"];
                    model.imgId = [dict[@"imgId"] intValue];
                    model.imgUrl = dict[@"imgUrl"];
                    [dataArr addObject:model];
                }
                
                block(dataArr,@0,@0,@0);
            }
        }else{
            [commonTools showBriefAlert:ErrorMsg];
        }
    } failed:^(NSError *error) {
        
    }];
}


+ (void)requestCommentData:(NSString *)groupId CurPage:(NSNumber *)curPage pcout:(NSNumber *)pCount dataBlock:(DataBlock)block{
    [RequestManager getPicGroupCommentGroupId:groupId CurPage:curPage pCount:pCount success:^(NSData *data) {
        NSDictionary *resDict = myJsonSerialization;
        NSMutableArray *dataArr = [NSMutableArray array];
        if ([resDict[@"success"] boolValue]) {
            NSLog(@"%@",resDict);
            NSArray *list = resDict[@"res"][@"list"];
            NSNumber *commentCount = resDict[@"res"][@"commentCount"];
            NSNumber *likeCount = resDict[@"res"][@"likeCount"];
            if (list.count != 0) {
                 NSNumber *maxPage = resDict[@"res"][@"maxPage"];
                for (NSDictionary *dict in list) {
                    PicGroupCommentModel *model = [[PicGroupCommentModel alloc] init];
                    model.isCmtShow = [dict[@"isCommentShow"] intValue];
                    if (model.isCmtShow == 1) {
                        model.commentId = [dict[@"id"] intValue];
                        model.groupId = dict[@"groupId"];
                        model.userId = dict[@"userId"];
                        model.imgComment = dict[@"imgComment"];
                        model.commentLike = [dict[@"commentLike"] intValue];
                        model.commentDislike = [dict[@"commentDislike"] intValue];
                        model.isCmtShow = [dict[@"isCommentShow"] intValue];
                        model.date = [GetCurrentTime GetTimeFromTimeStamp:[NSString stringWithFormat:@"%@",dict[@"date"]] andReturnTimeType:YYYY_MM_DD_and_HH_MM_SS];
                        NSLog(@"date:%@",model.date);
                        model.isSetCmtLike = NO;
                        model.isSetDiscmtLike = NO;
                        [dataArr addObject:model];
                    }
                }
                
                block(dataArr,maxPage,commentCount,likeCount);
            }else{
                PicGroupCommentModel *model = [[PicGroupCommentModel alloc] init];
                model.isCmtShow = 1;
                model.commentId = 6;
                model.imgComment = @"赞";
                model.date = [GetCurrentTime GetCurrentBeijingTimeandReturnTimeType:YYYY_MM_DD_and_HH_MM_SS];
                
                [dataArr addObject:model];
                
                block(dataArr,@0,@1,likeCount);
            }
        }else{
            [commonTools showBriefAlert:ErrorMsg];
        }

       
    } failed:^(NSError *error) {
        
    }];
}


+ (PYPhotosView *)imgScrollView:(NSMutableArray *)imgUrls{
    
    // 2.1 创建一个流水布局photosView(默认为流水布局)
    PYPhotosView *flowPhotosView = nil;
    flowPhotosView = [PYPhotosView photosView];
    //flowPhotosView.frame = CGRectMake(0, 40, IPHONE_WIDTH, IPHONE_HEIGHT);
    // 设置缩略图数组
    flowPhotosView.thumbnailUrls = imgUrls;
    // 设置原图地址
    flowPhotosView.originalUrls = imgUrls;
    // 设置分页指示类型
    flowPhotosView.pageType = PYPhotosViewPageTypeLabel;
    //flowPhotosView.py_centerX = weakSelf.view.py_centerX;
    flowPhotosView.py_y = 120;
    flowPhotosView.py_x = SPW(11);
    flowPhotosView.photoWidth = SPW(114);
    
    flowPhotosView.photoHeight = SPW(114);
    flowPhotosView.photoMargin = SPW(5);
    if (IPHONE_WIDTH > 540) {
        flowPhotosView.photoWidth = SPW(116);
        flowPhotosView.photoHeight = SPW(116);
    }else if(IPHONE_WIDTH == 540){
        flowPhotosView.photoWidth = SPW(115);
        flowPhotosView.photoHeight = SPW(115);
    }

    
    return flowPhotosView;
}

+ (UIButton *)addBackBtn{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(IPHONE_WIDTH*0.8, IPHONE_HEIGHT*0.70, SPW(50), SPW(50));
    
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [backBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    backBtn.backgroundColor = White_COLOR;
    backBtn.alpha = 0.95;
    backBtn.layer.cornerRadius = SPW(50)/2;
    backBtn.clipsToBounds = YES;
    backBtn.layer.borderWidth = 2;
    backBtn.layer.borderColor = S_Light_Gray.CGColor;
    if (IPHONE_WIDTH>540) {
        backBtn.frame = CGRectMake(IPHONE_WIDTH*0.85, IPHONE_HEIGHT*0.70, SPW(30), SPW(30));
        backBtn.layer.cornerRadius = SPW(30)/2;
    }
    return  backBtn;
}

+ (PicGroupDetailTitleDetailView *)titleDetailView:(NSString *)title picCount:(int)count type:(NSString *)type date:(NSString *)date cmtCount:(int)commentCount likeCount:(int)likeCount {
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"PicGroupDetailTitleDetailView" owner:nil options:nil];
    
    PicGroupDetailTitleDetailView *titleDetailView = [nibContents lastObject];
    titleDetailView.frame = CGRectMake(5, 10, IPHONE_WIDTH-10, 100);
    CGFloat PHeight =  titleDetailView.frame.size.height;
    CGFloat PWidth =  titleDetailView.frame.size.width;
    //titleDetailView.backgroundColor = S_Light_Gray;
    titleDetailView.layer.cornerRadius = SPW(5);
    titleDetailView.clipsToBounds = YES;
    
    titleDetailView.picCount.frame = CGRectMake(0,PHeight*0.7, PWidth*0.25, PHeight*0.2);
    titleDetailView.commentCount.frame =  CGRectMake(PWidth*0.25+1,PHeight*0.7, PWidth*0.25, PHeight*0.2);
    titleDetailView.likeCount.frame = CGRectMake(PWidth*0.5+2,PHeight*0.7, PWidth*0.25, PHeight*0.2);
    titleDetailView.type.frame = CGRectMake(PWidth*0.75+3,PHeight*0.7, PWidth*0.25, PHeight*0.2);
    titleDetailView.date.frame = CGRectMake(PWidth*0.1, PHeight*0.4, PWidth*0.8, PHeight*0.2);
    titleDetailView.LeftSepLine.frame = CGRectMake(PWidth*0.25, PHeight*0.7, 1, PHeight*0.2);
    titleDetailView.CenterSepLine.frame = CGRectMake(PWidth*0.5+1, PHeight*0.7, 1, PHeight*0.2);
    titleDetailView.RightSepLine.frame = CGRectMake(PWidth*0.75+2, PHeight*0.7, 1, PHeight*0.2);
    
    
    titleDetailView.picTitle.text = title;
    titleDetailView.picCount.text = [NSString stringWithFormat:@"数量(%d)",count];
    titleDetailView.type.text = [NSString stringWithFormat:@"分类(%@)",type];
    titleDetailView.date.text = date;
    titleDetailView.commentCount.text = [NSString stringWithFormat:@"评论(%d)",commentCount];
    titleDetailView.likeCount.text = [NSString stringWithFormat:@"点赞(%d)",likeCount];
    
    
    if (IPHONE_WIDTH < 540) {
        titleDetailView.LeftSepLine.hidden = YES;
        titleDetailView.CenterSepLine.hidden = YES;
        titleDetailView.RightSepLine.hidden = YES;
        if (title.length > 15 && title.length < 18) {
            titleDetailView.picTitle.font = [UIFont systemFontOfSize:15.0];
        }else if (title.length >= 18 && title.length < 20){
            titleDetailView.picTitle.font = [UIFont systemFontOfSize:14.0];
        }else if (title.length >= 20 && title.length < 23){
            titleDetailView.picTitle.font = [UIFont systemFontOfSize:13.0];
        }
    }

    
    return titleDetailView;
}

+ (UILabel *)commentLab:(CGRect)frame{
    UILabel *lab = [[UILabel alloc] initWithFrame:frame];
    lab.text = @"精彩评论";
    lab.font = [UIFont systemFontOfSize:17];
    lab.textColor = [UIColor darkGrayColor];
    //lab.backgroundColor = S_Light_Gray;
    return lab;
}


+ (void)requestLikeData:(NSString *)groupId  titleDetailView:(PicGroupDetailTitleDetailView *)titleDetailView{
    [RequestManager addPicGroupLikeDataGroupId:groupId success:^(NSData *data) {
        
        NSDictionary *resDict = myJsonSerialization;
        if (requestSuccess) {
            if([resDict[@"res"][@"AlertMsg"] isEqualToString:@"like_success"]){
                [commonTools showBriefAlert:@"点赞成功"];
               titleDetailView.likeCount.text = [NSString stringWithFormat:@"点赞(%d)",[[[titleDetailView.likeCount.text componentsSeparatedByString:@"("][1] componentsSeparatedByString:@")"][0] intValue]+1];
            }
        }else{
            [commonTools showBriefAlert:ErrorMsg];
        }
        
    } failed:^(NSError *error) {
        
    }];
}


+ (void)requestIsLikeExistGroupID:(NSString *)groupId isLike:(isLikeBlock)block{
    [RequestManager isPicGroupLikeExistGroupId:groupId success:^(NSData *data) {
        NSDictionary *resDict = myJsonSerialization;
        if (requestSuccess) {
            BOOL isLiked = [resDict[@"res"][@"isLiked"] boolValue];
            block(isLiked);
        }else{
            block(false);
        }
    } failed:^(NSError *error) {
        
    }];
}

+ (UIButton *)addCommentBtn{
    UIButton *cmtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cmtBtn.frame = CGRectMake(0, 0, IPHONE_WIDTH*0.2, SPH(40)*0.8);
    [cmtBtn setTitle:@"发表评论" forState:UIControlStateNormal];
    cmtBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    cmtBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [cmtBtn setEnlargEdgeWithTop:0 right:0 bottom:0 left:SPH(40)*0.8];
    [cmtBtn setTitleColor:[UIColor colorWithRed:10/255.0f green:122/255.0f blue:255/255.0f alpha:1] forState:UIControlStateNormal];

    return cmtBtn;
}


+ (void)requestAddComment:(NSString *)comment imgId:(NSNumber *)imgId groupId:(NSString *)groupId resblock:(addCommentBlock)block{
    [RequestManager addPicGroupComment:comment imgId:imgId groupId:groupId success:^(NSData *data) {
        NSDictionary *resDict = myJsonSerialization;
        if (requestSuccess) {
            if ([resDict[@"res"][@"AlertMsg"] isEqualToString:@"comment_success"]) {
                block(YES);
            }else{
                [commonTools showBriefAlert:@"未知错误"];
                block(NO);
            }
        }else{
            [commonTools showBriefAlert:ErrorMsg];
            block(NO);
        }
    } failed:^(NSError *error) {
        
    }];
}


+ (void)requestAddCommentLike:(NSNumber *)commentId commentLike:(NSNumber *)commentLike commentDislike:(NSNumber *)commentDislike resBlock:(addCommentLikeBlock)block{
    [RequestManager addPicGroupCommentLike:commentId cmtLike:commentLike cmtDislike:commentDislike success:^(NSData *data) {
        NSDictionary *resDict = myJsonSerialization;
        if (requestSuccess) {
            if ([resDict[@"res"][@"success"] boolValue]) {
                block(YES);
            }else{
                block(NO);
            }
        }else{
            [commonTools showBriefAlert:ErrorMsg];
            block(NO);
        }
    } failed:^(NSError *error) {
        
    }];
}



















@end
