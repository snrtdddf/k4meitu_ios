//
//  JiongStaticImageVC.m
//  K4Meitu
//
//  Created by simpleem on 8/2/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "JiongStaticImageVC.h"
#import "Header.h"
#import "MBManager.h"
#import "MJRefresh.h"
#import "JiongStaticImageRequest.h"
@interface JiongStaticImageVC ()

@end

@implementation JiongStaticImageVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [MBManager hideAlert];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addStatusBlackBackground];
    [self addBackButton:NO];
    [self addTitleWithName:self.type wordNun:2];
    self.view.backgroundColor = lightGray_Color;
    self.curPage = 0;
    
    [self initTableView];
    [self refreshData];

}
- (void)requestData{
    myWeakSelf;
    [JiongStaticImageRequest requestCurPage:self.curPage type:self.type dataBlock:^(NSMutableArray *dataArr, NSInteger maxPage) {
        for (JiongPicNewestModel *model in dataArr) {
            [weakSelf.dataArr addObject:model];
        }
        weakSelf.maxPage = (int)maxPage;
        
        [weakSelf.picTable reloadData];
        
    }];
}

- (void)refreshData{
    myWeakSelf;
    self.picTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.curPage++;
        if (weakSelf.curPage < weakSelf.maxPage) {
            [weakSelf requestData];
            [weakSelf.picTable.mj_footer endRefreshing];
        }else{
            [weakSelf.picTable.mj_footer endRefreshingWithNoMoreData];
        }
        
    }];
    self.picTable.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        [weakSelf.picTable.mj_header endRefreshing];
        weakSelf.curPage = 0;
        [weakSelf.dataArr removeAllObjects];
        [weakSelf requestData];
    }];
}

- (void)dealloc{
    NSLog(@"%@已释放",self.title);
    [self.dataArr removeAllObjects];
    self.dataArray = nil;
    self.dataArr = nil;
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
