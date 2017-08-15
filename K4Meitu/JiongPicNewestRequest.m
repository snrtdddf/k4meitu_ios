//
//  JiongPicNewestRequest.m
//  K4Meitu
//
//  Created by simpleem on 7/27/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "JiongPicNewestRequest.h"
#import <NSObject+YYModel.h>
#import "JiongPicNewestModel.h"
#import "RequestManager.h"
#import "Header.h"
#import "commonTools.h"
#import "GetCurrentTime.h"
#import "commonTools.h"
#import "GetCurrentTime.h"
#import "FLAnimatedImage.h"
#import <FLAnimatedImageView+WebCache.h>
#import "MBProgressHUD.h"
#import "UIButton+enLargedRect.h"
@implementation JiongPicNewestRequest

+ (void)requestCurPage:(int)curPage dataBlock:(dataBlock)block{
   
    [RequestManager getJiongPicNewsListCurPage:[NSNumber numberWithInt:curPage] pCount:@10 success:^(NSData *data) {
        NSDictionary *resDict = myJsonSerialization;
        NSLog(@"resDict:%@",resDict);
        NSMutableArray *dataArr = [NSMutableArray array];
        NSInteger maxPage = 0;
        
        if ([resDict[@"success"] boolValue]) {
            NSArray *resArr = resDict[@"res"][@"list"];
            
            NSLog(@"count:%ld",resArr.count);
            if (resArr.count != 0) {
                maxPage = [resDict[@"res"][@"maxPage"] intValue];
                
                for (NSDictionary *dict in resArr) {
                    JiongPicNewestModel *model = [JiongPicNewestModel modelWithJSON:dict];
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
+ (JiongPicNewestCell *)JiongCell:(JiongPicNewestCell *)cell dataArr:(JiongPicNewestModel *)model IndexPath:(NSIndexPath *)indexPath {
 
    cell.title.text = model.Title;
    [MBProgressHUD hideHUDForView:cell.img animated:NO];
    
    MBProgressHUD *hud = nil;
    
    hud = [MBProgressHUD showHUDAddedTo:cell.img animated:NO];
    CGFloat cellWidth = model.imgCoverWidth>IPHONE_WIDTH?IPHONE_WIDTH:model.imgCoverWidth;
    CGFloat cellHeight = model.imgCoverHeight/model.imgCoverWidth*cellWidth;
    cell.img.frame = CGRectMake(0, 0, cellWidth, cellHeight);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.consLeft.constant = (IPHONE_WIDTH - cell.img.frame.size.width)/2.0;
    cell.consRight.constant = (IPHONE_WIDTH - cell.img.frame.size.width)/2.0;
    [cell.img sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"photo"] options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        hud.mode = MBProgressHUDModeDeterminate;
        float currentProgress = (float)receivedSize/(float)expectedSize;
        hud.progress = currentProgress;
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        [MBProgressHUD hideHUDForView:cell.img animated:YES];
        [hud setRemoveFromSuperViewOnHide:YES];
        [hud removeFromSuperview];
    }];
    
    cell.date.text = [GetCurrentTime GetTimeFromTimeStamp:model.date andReturnTimeType:YYYY_MM_DD];
    [cell.likeCount setTitle:[NSString stringWithFormat:@"%d",model.likeCount] forState:UIControlStateNormal];
    [cell.dislikeCount setTitle:[NSString stringWithFormat:@"%d",model.dislikeCount] forState:UIControlStateNormal];
    [cell.cmtCount setTitle:[NSString stringWithFormat:@"%d",model.cmtCount] forState:UIControlStateNormal];
    [cell.share setTitle:[NSString stringWithFormat:@"%d",model.shareCount] forState:UIControlStateNormal];
    
    [cell.likeCount setEnlargEdgeWithTop:5 right:0 bottom:5 left:16];
    [cell.dislikeCount setEnlargEdgeWithTop:5 right:0 bottom:5 left:16];
    [cell.cmtCount setEnlargEdgeWithTop:5 right:0 bottom:5 left:16];
    [cell.share setEnlargEdgeWithTop:5 right:0 bottom:5 left:16];
    
    cell.likeCount.tag = 300 + indexPath.row;
    cell.dislikeCount.tag = 400 +indexPath.row;
    cell.share.tag = 500 + indexPath.row;
    
    cell.likeImg.image = model.isSetLike?[UIImage imageNamed:@"like_thumb_red"]:[UIImage imageNamed:@"like_thumb_gray"];
    cell.dislikeImg.image = model.isSetDislike?[UIImage imageNamed:@"dislike_thumb_red"]:[UIImage imageNamed:@"dislike_thumb_gray"];
    

    return cell;
}


+ (void)requestAddLikeOrDislikeData:(NSNumber *)Gid like:(NSNumber *)like dislike:(NSNumber *)dislike groupId:(NSString *)groupId addLikeBlock:(addLikeBlock)block{
    [RequestManager addGifPicGroupLikeId:Gid Like:like dislike:dislike groupId:groupId success:^(NSData *data) {
        NSDictionary *resDict = myJsonSerialization;
        if (requestSuccess) {
            if([resDict[@"res"][@"AlertMsg"] isEqualToString:@"like_success"]){
                [commonTools showBriefAlert:@"踩成功"];
                block(YES);
            }
        }else{
            [commonTools showBriefAlert:ErrorMsg];
            block(NO);
        }

    } failed:^(NSError *error) {
        
    }];
    if ([like isEqual:@1]) {
        [RequestManager addPicGroupLikeDataGroupId:groupId success:^(NSData *data) {
            
        } failed:^(NSError *error) {
            
        }];
    }else if([dislike isEqual:@1]){
        [RequestManager addPicGroupDislikeDataGroupId:groupId success:^(NSData *data) {
            
        } failed:^(NSError *error) {
            
        }];
    }
    

}
@end
