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
+ (JiongPicNewestCell *)JiongCell:(JiongPicNewestCell *)cell dataArr:(JiongPicNewestModel *)model{
 
    cell.title.text = model.Title;
    [MBProgressHUD hideHUDForView:cell.img animated:YES];
    MBProgressHUD *hud = nil;
    hud = [MBProgressHUD showHUDAddedTo:cell.img animated:YES];
    
    cell.img.frame = CGRectMake(0, 0, model.imgCoverWidth, model.imgCoverHeight);
    cell.consLeft.constant = (IPHONE_WIDTH - model.imgCoverWidth)/2.0;
    cell.consRight.constant = (IPHONE_WIDTH - model.imgCoverWidth)/2.0;
    [cell.img sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"photo"] options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        hud.mode = MBProgressHUDModeDeterminate;
        float currentProgress = (float)receivedSize/(float)expectedSize;
        hud.progress = currentProgress;
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        [MBProgressHUD hideHUDForView:cell.img animated:YES];
        [hud setRemoveFromSuperViewOnHide:YES];
    }];
    
    cell.date.text = [GetCurrentTime GetTimeFromTimeStamp:model.date andReturnTimeType:YYYY_MM_DD];
    [cell.likeCount setTitle:[NSString stringWithFormat:@"%d",model.likeCount] forState:UIControlStateNormal];
    [cell.dislikeCount setTitle:[NSString stringWithFormat:@"%d",model.dislikeCount] forState:UIControlStateNormal];
    [cell.cmtCount setTitle:[NSString stringWithFormat:@"%d",model.cmtCount] forState:UIControlStateNormal];
    [cell.share setTitle:[NSString stringWithFormat:@"%d",model.shareCount] forState:UIControlStateNormal];
    
   // cell.separatorInset = UIEdgeInsetsMake(20, 0, 0, 0);//上左下右 就可以通过设置这四个参数来设置分割线了
    
    return cell;
}









@end
