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
@interface SexyPicGroupTypeVC ()<UITextFieldDelegate>
@property (strong, nonatomic) YYDiskCache *cache;
@property (assign, nonatomic) int requestCount;
@property (strong, nonatomic) UITextField *searchTF;
@end

@implementation SexyPicGroupTypeVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    for (UIView *view in self.navigationController.navigationBar.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            if (view.tag == 101) {
                 [view removeFromSuperview];
            }
        }
    }
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

- (void)searchPicTFInit{
    if (self.searchTF == nil) {
        self.searchTF = [[UITextField alloc] initWithFrame:CGRectMake(IPHONE_WIDTH*0.12, 6, IPHONE_WIDTH*0.7, 30)];
    }
    self.searchTF.placeholder = @"请输入要搜索的内容";
    self.searchTF.backgroundColor = White_COLOR;
    self.searchTF.borderStyle = UITextBorderStyleRoundedRect;
    self.searchTF.layer.cornerRadius = 15;
    self.searchTF.clipsToBounds = YES;
    self.searchTF.delegate = self;
    self.searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchTF.textColor = Red_COLOR;
    [self.navigationController.navigationBar addSubview:self.searchTF];
    
    myWeakSelf;
    [self addRightButtonWithName:@"搜索" wordNum:2 actionBlock:^{
        weakSelf.curPage = 0;
        [weakSelf.dataArr removeAllObjects];
        [weakSelf.searchTF resignFirstResponder];
        if (weakSelf.searchTF.text.length > 0) {
            weakSelf.keyword = weakSelf.searchTF.text;
           [weakSelf request];
        } else {
            [commonTools showBriefAlert:@"搜索关键字为空"];
        }
        
        
    }];
    
    [self addLeftCloseBtnWithName:@"" wordNum:3];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSString *text = textField.text;
    if ([NSString isContainsEmoji:text]) {
        textField.text = @"";
        [commonTools showBriefAlert:@"请勿输入表情"];
    }else if (text.length > 7){
        [commonTools showBriefAlert:@"限制7个字符以内"];
    }
}

- (void)refreshData{
    myWeakSelf;
    
    self.picTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.curPage++;
        if (weakSelf.curPage <= weakSelf.maxPage) {
            [weakSelf requestData];
        }else{
            [weakSelf.picTable.mj_footer endRefreshingWithNoMoreData];
        }
    }];
    self.picTable.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        weakSelf.curPage = 0;
        [weakSelf.dataArr removeAllObjects];
        
        [weakSelf request];
        
    }];
    
    
}

- (void)requestData{
    
    NSLog(@"keyword=%@",self.keyword);
    
    if ((self.keyword == nil)||[self.keyword isEqualToString:@""]||[self.keyword isKindOfClass:[NSNull class]]) {
         [self searchPicTFInit];
        [self.searchTF becomeFirstResponder];
    }else{
        [self request];
    }
}

- (void)request{
    myWeakSelf;
    self.requestCount++;
    [RequestManager getPicGroupByKeyword:self.keyword curPage:[NSNumber numberWithInt:self.curPage] pCount:@10 success:^(NSData *data) {
        NSDictionary *resDict = myJsonSerialization;
        NSLog(@"resDict:%@",resDict);
        [weakSelf.picTable.mj_header endRefreshing];
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
            }else{
                [weakSelf.dataArr removeAllObjects];
                [weakSelf.picTable reloadData];
               // [commonTools showBriefAlert:@"已找到0张图片"];
                [commonTools showStatusWithMessage:@"已找到0张图片" toView:self.picTable];
            }
        }else{
            [commonTools showBriefAlert:resDict[@"ErrorMsg"]];
        }
        
    } failed:^(NSError *error) {
        
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    for (UIView *view in self.navigationController.navigationBar.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            [view removeFromSuperview];
        }
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
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
