//
//  SexyPicGroupTypeVC.m
//  K4Meitu
//
//  Created by simpleem on 8/11/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "SexyPicGroupTypeVC.h"
#import "Header.h"
#import "RequestManager.h"
#import "MJRefresh.h"
#import "MainPagePicModel.h"
#import "commonTools.h"
#import "GetCurrentTime.h"
#import <YYCache.h>
#import <YYDiskCache.h>
@interface SexyPicGroupTypeVC ()
@property (strong, nonatomic) YYDiskCache *cache;
@property (assign, nonatomic) int requestCount;
@end

@implementation SexyPicGroupTypeVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = lightGray_Color;
    [self addStatusBlackBackground];
    [self addBackButton:NO];
    [self addTitleWithName:self.keyword wordNun:2];
    
    self.curPage = 0;
    if (self.cache == nil) {
        self.cache = [YYCache cacheWithName:[NSString stringWithFormat:@"mainPageCache%@",self.keyword]].diskCache;
        self.cache.ageLimit = 3*24*60*60;
        self.cache.costLimit = 100556768;
    }
}

- (void)requestData{
    myWeakSelf;
    
    self.requestCount++;

    
    [RequestManager getPicGroupByKeyword:self.keyword curPage:[NSNumber numberWithInt:self.curPage] pCount:@10 success:^(NSData *data) {
        NSDictionary *resDict = myJsonSerialization;
        NSLog(@"resDict:%@",resDict);
        
        [weakSelf.picTable.mj_footer endRefreshing];
        //清除缓存
        if (weakSelf.requestCount == 1) {
            [weakSelf.dataArr removeAllObjects];
        }
        
        if ([resDict[@"success"] boolValue]) {
            NSArray *resArr = resDict[@"res"][@"list"];
            
            NSLog(@"count:%ld",resArr.count);
            if (resArr.count != 0) {
                weakSelf.maxPage = [resDict[@"res"][@"maxPage"] intValue];
                
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
                    
                    [weakSelf.dataArr addObject:model];
                    [weakSelf.cache setObject:weakSelf.dataArr forKey:@"dataArr"];
                }
                [weakSelf.picTable reloadData];
                NSLog(@"count:%ld",weakSelf.dataArr.count);
                [weakSelf.cache setObject:weakSelf.dataArr forKey:@"dataArr"];
            }
        }else{
            [commonTools showBriefAlert:resDict[@"ErrorMsg"]];
        }

    } failed:^(NSError *error) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
