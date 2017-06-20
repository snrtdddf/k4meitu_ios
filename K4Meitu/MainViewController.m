//
//  MainViewController.m
//  K4Meitu
//
//  Created by simpleem on 6/17/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "MainViewController.h"
#import "RequestManager.h"
#import "Header.h"
#import "MainPagePicCell.h"
#import "MainPagePicModel.h"
#import "GetCurrentTime.h"
#import "MainTabBarViewController.h"
#import <UIImageView+WebCache.h>
#import "MJRefresh.h"
#import "commonTools.h"
#import "mainPageRequest.h"
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *picTable;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, assign) int curPage;
@property (nonatomic, assign) int maxPage;

@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated{
    NSArray *views = self.navigationController.navigationBar.subviews;
    for (UIView *view in views) {
        if (view.tag == 1001) {
            [view setHidden:NO];
            break;
        }
    }
    UINavigationController *nav = (UINavigationController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    //  时间紧，自己百度看为什么
    MainTabBarViewController *mainTabBarVC = (MainTabBarViewController*)(nav.childViewControllers[0]);
    NSArray *array = mainTabBarVC.tabBar.subviews;
    for (UIView *view in array) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [view removeFromSuperview];
            
        }
    }
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = Black_COLOR;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addStatusBlackBackground];
    self.dataArr = [NSMutableArray array];
    self.curPage = 0;
   
    [self picTableInit];
    
    [self requestData];
    
    [self refreshData];
    
}

- (void)refreshData{
    self.picTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)loadMoreData{
    self.curPage++;
    if (self.curPage <= self.maxPage) {
        [self requestData];
    }else{
        [self.picTable.mj_footer endRefreshingWithNoMoreData];
    }
    
}

- (void)picTableInit{
    self.picTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT-SPH(74)) style:UITableViewStylePlain];;
    self.picTable.delegate = self;
    self.picTable.dataSource = self;
    self.picTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.picTable];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MainPagePicModel *model = self.dataArr[indexPath.row];
    NSLog(@"cell_height:%lf",IPHONE_WIDTH * model.imgCoverHeight/model.imgCoverWidth);
    return self.dataArr.count==0?0.01:IPHONE_WIDTH * model.imgCoverHeight/model.imgCoverWidth;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (MainPagePicCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MainPagePicModel *model = self.dataArr[indexPath.row];
    
    MainPagePicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[MainPagePicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    
    return [mainPageRequest returnMainPagePicCell:cell Model:model];
}

- (void)requestData{
    [RequestManager getMainPagePicListCurPage:[NSNumber numberWithInt:self.curPage] pCount:@10 success:^(NSData *data) {
        NSDictionary *resDict = myJsonSerialization;
        NSLog(@"resDict:%@",resDict);
        myWeakSelf;
        [weakSelf.picTable.mj_footer endRefreshing];
        
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
                    model.date = [GetCurrentTime GetTimeFromTimeStamp:[NSString stringWithFormat:@"%@",dict[@"date"]] andReturnTimeType:YYYY_MM_DD];
                    model.imgCoverName = dict[@"imgCoverName"];
                    model.imgCoverHeight = [dict[@"imgCoverHeight"] intValue];
                    model.imgCoverWidth = [dict[@"imgCoverWidth"] intValue];
                    
                    [weakSelf.dataArr addObject:model];
                    
                }
                [weakSelf.picTable reloadData];
                NSLog(@"count:%ld",weakSelf.dataArr.count);
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
