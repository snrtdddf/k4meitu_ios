//
//  JiongStaticImageRequest.m
//  K4Meitu
//
//  Created by simpleem on 8/2/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "JiongStaticImageRequest.h"
#import "RequestManager.h"
#import <NSObject+YYModel.h>
#import "commonTools.h"
@implementation JiongStaticImageRequest
+ (void)requestCurPage:(int)curPage type:(NSString *)type  dataBlock:(dataBlock)block{
    
    [RequestManager getJiongStaticImageCurPage:[NSNumber numberWithInt:curPage] pCount:@10 type:type success:^(NSData *data) {
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

@end
