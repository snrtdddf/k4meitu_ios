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
                
                block(dataArr);
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
            if (list.count != 0) {
                for (NSDictionary *dict in list) {
                    PicGroupCommentModel *model = [[PicGroupCommentModel alloc] init];
                    model.isCmtShow = [dict[@"isCommentShow"] intValue];
                    if (model.isCmtShow == 1) {
                        model.commentId = [dict[@"id"] intValue];
                        model.groupId = dict[@"groupId"];
                        model.userId = dict[@"userId"];
                        model.imgComment = dict[@"imgComment"];
                        model.isCmtShow = [dict[@"isCommentShow"] intValue];
                        model.date = [GetCurrentTime GetTimeFromTimeStamp:[NSString stringWithFormat:@"%@",dict[@"date"]] andReturnTimeType:YYYY_MM_DD];
                        NSLog(@"date:%@",model.date);
                        [dataArr addObject:model];
                    }
                }
                
                block(dataArr);
            }else{
                PicGroupCommentModel *model = [[PicGroupCommentModel alloc] init];
                model.isCmtShow = 1;
                model.commentId = 6;
                model.imgComment = @"赞";
                model.date = [GetCurrentTime GetCurrentBeijingTimeandReturnTimeType:YYYY_MM_DD];
                
                [dataArr addObject:model];
                
                block(dataArr);
            }
        }else{
            [commonTools showBriefAlert:ErrorMsg];
        }

       
    } failed:^(NSError *error) {
        
    }];
}


+ (PYPhotosView *)imgScrollView:(NSMutableArray *)imgUrls{
    
    // 2.1 创建一个流水布局photosView(默认为流水布局)
    PYPhotosView *flowPhotosView = [PYPhotosView photosView];
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
    if (IPHONE_WIDTH>375) {
        flowPhotosView.photoWidth = SPW(116);
        flowPhotosView.photoHeight = SPW(116);
    }

    
    return flowPhotosView;
}

+ (UIButton *)addBackBtn{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(IPHONE_WIDTH*0.8, IPHONE_HEIGHT*0.70, SPW(50), SPW(50));
    
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [backBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor whiteColor];
    backBtn.alpha = 0.8;
    backBtn.layer.cornerRadius = SPW(50)/2;
    backBtn.clipsToBounds = YES;
    if (IPHONE_WIDTH>540) {
        backBtn.frame = CGRectMake(IPHONE_WIDTH*0.85, IPHONE_HEIGHT*0.70, SPW(30), SPW(30));
        backBtn.layer.cornerRadius = SPW(30)/2;
    }
    return  backBtn;
}

+ (UIView *)titleDetailView{
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"PicGroupDetailTitleDetailView" owner:nil options:nil];
    
    PicGroupDetailTitleDetailView *titleDetailView = [nibContents lastObject];
    titleDetailView.frame = CGRectMake(SPW(11), 10, IPHONE_WIDTH-SPW(11)*2, 100);
    CGFloat PHeight =  titleDetailView.frame.size.height;
    CGFloat PWidth =  titleDetailView.frame.size.width;
    
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
    
    if (IPHONE_WIDTH < 540) {
        titleDetailView.LeftSepLine.hidden = YES;
        titleDetailView.CenterSepLine.hidden = YES;
        titleDetailView.RightSepLine.hidden = YES;
    }
    
    return titleDetailView;
}

+ (UILabel *)commentLab:(CGRect)frame{
    UILabel *lab = [[UILabel alloc] initWithFrame:frame];
    lab.text = @"    精彩评论";
    lab.font = [UIFont systemFontOfSize:17];
    lab.textColor = [UIColor darkGrayColor];
    lab.backgroundColor = Gray_COLOR;
    return lab;
}


@end
