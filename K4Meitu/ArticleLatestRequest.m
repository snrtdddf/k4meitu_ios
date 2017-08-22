//
//  ArticleLatestRequest.m
//  K4Meitu
//
//  Created by simpleem on 8/21/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "ArticleLatestRequest.h"
#import "RequestManager.h"
#import "Header.h"
#import "commonTools.h"
#import "ArticleModel.h"
#import <NSObject+YYModel.h>
@implementation ArticleLatestRequest
+ (void)requestCurPage:(int)curPage pCount:(int)pCount dataBlock:(dataBlock)block{
    [RequestManager getArticleLatestCurPage:[NSNumber numberWithInt:curPage] pCount:[NSNumber numberWithInt:pCount] success:^(NSData *data) {
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
                    ArticleModel *model = [ArticleModel modelWithJSON:dict];
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
