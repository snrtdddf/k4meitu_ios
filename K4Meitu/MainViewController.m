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
#import "MainPagePicModel.h"
#import "GetCurrentTime.h"
#import "MainTabBarViewController.h"
#import <UIImageView+WebCache.h>
#import "MJRefresh.h"
#import "commonTools.h"
#import "mainPageRequest.h"
#import "MainPicGroupCell.h"
#import "PicGroupDetailVC.h"
#import "SexyPicGroupTypeVC.h"
#import <YYCache.h>
#import <YYDiskCache.h>

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) YYDiskCache *cache;
@property (assign, nonatomic) int requestCount;
@property (strong, nonatomic) UIButton *searchBtn;



@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UINavigationController *nav = (UINavigationController*)[UIApplication sharedApplication].keyWindow.rootViewController;

    MainTabBarViewController *mainTabBarVC = (MainTabBarViewController*)(nav.childViewControllers[0]);
    NSArray *array = mainTabBarVC.tabBar.subviews;
    for (UIView *view in array) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [view removeFromSuperview];
           
        }
    }
    array = nil;
    mainTabBarVC = nil;
    nav = nil;
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = Black_COLOR;
    
    [self initSearchView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addStatusBlackBackground];
    
    
    self.curPage = 0;
    
    [self picTableInit];
    
    [self requestData];
    
    [self refreshData];
    
}

- (void)initSearchView{
    if (self.searchBtn == nil) {
        self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    self.searchBtn.frame = CGRectMake(10, 8, IPHONE_WIDTH-20, 28);
    self.searchBtn.backgroundColor = White_COLOR;
    self.searchBtn.layer.cornerRadius = 14;
    self.searchBtn.clipsToBounds = YES;
    self.searchBtn.tag = 101;
    [self.searchBtn setTitle:@"🔍搜索" forState:UIControlStateNormal];
    [self.searchBtn setTitleColor:lightGray_Color forState:UIControlStateNormal];
    [self.searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:self.searchBtn];
}

- (void)searchBtnClick{
    SexyPicGroupTypeVC *vc = [[SexyPicGroupTypeVC alloc] init];
    //vc.keyword = @"妹子";
   
    [self.navigationController pushViewController:vc animated:NO];
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
        
        [weakSelf requestData];
        //[weakSelf.picTable.mj_header endRefreshing];
    }];
    
  
}

- (void)picTableInit{
    if (self.picTable == nil) {
        self.picTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT-SPH(74)) style:UITableViewStylePlain];
    }
    self.picTable.delegate = self;
    self.picTable.dataSource = self;
    self.picTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.picTable registerNib:[UINib nibWithNibName:@"MainPicGroupCell" bundle:nil] forCellReuseIdentifier:@"picGroupCell"];
    [self.view addSubview:self.picTable];
    
    if (self.cache == nil) {
        self.cache = [YYCache cacheWithName:[NSString stringWithFormat:@"mainPageCache%@",self.keyword]].diskCache;
        self.cache.ageLimit = 3*24*60*60;
        self.cache.costLimit = 500556768;
    }
    
    if (self.dataArr == nil) {
        self.dataArr = [[NSMutableArray alloc] init];
    }
    if ([self.cache containsObjectForKey:@"dataArr"]) {
        self.dataArr = (NSMutableArray *)[self.cache objectForKey:@"dataArr"];
        [self.picTable reloadData];
    }

        //[self.dataArr removeAllObjects];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MainPagePicModel *model = self.dataArr[indexPath.row];
    
    return self.dataArr.count==0?0.01:IPHONE_WIDTH * model.imgCoverHeight/model.imgCoverWidth;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (MainPicGroupCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.dataArr != 0) {
        MainPagePicModel *model = self.dataArr[indexPath.row];
        
        MainPicGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"picGroupCell"];
        if (cell == nil) {
            cell = [[MainPicGroupCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"picGroupCell"];
        }
        cell = [mainPageRequest returnMainPicGroupCell:cell Model:model];
        if ([cell.title.text containsString:self.keyword]) {
            //RGBACOLOR(232, 93, 243, 1)
            cell.title.attributedText = [commonTools setKeywordStyle:cell.title.text keyword:self.keyword Color:RGBACOLOR(248, 48, 146, 1) font:[UIFont systemFontOfSize:22.0f]];
        }
        
        return cell;
    }
    return NULL;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MainPagePicModel *model = self.dataArr[indexPath.row];
  
   
    PicGroupDetailVC *vc = [[PicGroupDetailVC alloc] init];
    
    [vc setGroupId:model.groupId];
    [vc setPicCount:model.count];
    [vc setPicTitle:model.title];
    [vc setType:model.type];
    [vc setPicDate:model.date];
    
    [self.navigationController pushViewController:vc animated:YES];
    vc = nil;
}

- (void)requestData{
    
     myWeakSelf;
    self.requestCount++;
    
    [RequestManager getMainPagePicListCurPage:[NSNumber numberWithInt:self.curPage] pCount:@10 success:^(NSData *data) {
        NSDictionary *resDict = myJsonSerialization;
        NSLog(@"resDict:%@",resDict);
        [weakSelf.picTable.mj_header endRefreshing];
        [weakSelf.picTable.mj_footer endRefreshing];
        
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
                    model.vip = [dict[@"vip"] intValue];
                    
                    [weakSelf.dataArr addObject:model];
                    
                }
                NSLog(@"count:%ld",weakSelf.dataArr.count);
                [weakSelf.picTable reloadData];
                [weakSelf.cache removeObjectForKey:@"dataArr"];
                [weakSelf.cache setObject:weakSelf.dataArr forKey:@"dataArr"];
            }
        }else{
            [commonTools showBriefAlert:resDict[@"ErrorMsg"]];
        }
    } failed:^(NSError *error) {
        
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.searchBtn removeFromSuperview];
    self.searchBtn = nil;
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
