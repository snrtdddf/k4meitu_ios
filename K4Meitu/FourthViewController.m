//
//  FourthViewController.m
//  K4Meitu
//
//  Created by simpleem on 6/17/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "FourthViewController.h"
#import <SDImageCache.h>
#import "MainTabBarViewController.h"
#import "Header.h"
#import <YYDiskCache.h>
#import <YYCache.h>
#import "MJRefresh.h"
#import "FourthPageCell.h"
#import "FourthPageCell_1.h"
#import "FourthPageRequest.h"
#import "FourthPageHeaderView.h"
#import "commonTools.h"
#import "MBProgressHUD.h"
@interface FourthViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UIScrollView *scroll;
@property (strong, nonatomic) YYDiskCache *cache;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *menuArr;
@property (strong, nonatomic) FourthPageHeaderView *headerBgView;
@property (assign, nonatomic) CGFloat cacheSize;

@end

@implementation FourthViewController
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
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = Black_COLOR;
    [self.navigationController.navigationBar removeFromSuperview];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addStatusBlackBackground];
    
    [self initCache];
    [self initHeaderView];
    [self initScrollView];
    [self initTableView];
    [self requestData];
    [self getCacheSize];
}

- (void)initHeaderView{
    self.headerBgView = [[FourthPageHeaderView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT*0.4)];
}

- (void)initCache{
    if (self.cache == nil) {
        self.cache = [YYCache cacheWithName:@"FourthPage"].diskCache;
        self.cache.ageLimit = 3*24*60*60;
        self.cache.costLimit = 100556768;
    }
}

- (void)initScrollView{
    if (self.scroll == nil) {
        self.scroll = [[UIScrollView alloc] init];
    }
    self.scroll.frame = CGRectMake(0, -64, IPHONE_WIDTH, IPHONE_HEIGHT);
    self.scroll.showsVerticalScrollIndicator = NO;
    self.scroll.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scroll];
    
    myWeakSelf;
    self.scroll.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        [weakSelf.scroll.mj_header endRefreshing];
        
    }];
}

- (void)initTableView{
        if (self.tableView == nil) {
            self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT) style:UITableViewStylePlain];
        }
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    
        if (IPHONE_WIDTH <= 540) {
            [self.tableView registerNib:[UINib nibWithNibName:@"FourthPageCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        }else{
            [self.tableView registerNib:[UINib nibWithNibName:@"FourthPageCell_1" bundle:nil] forCellReuseIdentifier:@"cell1"];
        }
    
        self.tableView.tableHeaderView = self.headerBgView;
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.scroll addSubview:self.tableView];
    
        
        if (self.menuArr == nil) {
            self.menuArr = [[NSMutableArray alloc] initWithArray:@[
                                                                   @[@"share",@"设置"],                                                                   
                                                                   @[@"share",@"收藏"],
                                                                   @[@"share",@"分享"],
                                                                   @[@"share",@"清除缓存"],
                                                                   @[@"share",@"意见反馈"],
                                                                   @[@"share",@"关于我们"]
                                                                   ]];
        }
    
    
        if ([self.cache containsObjectForKey:@"dataArr"]) {
            self.menuArr = (NSMutableArray *)[self.cache objectForKey:@"dataArr"];
            [self.tableView reloadData];
        }

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return IPHONE_WIDTH <= 540?40:60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.menuArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (IPHONE_WIDTH <= 540) {
        FourthPageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[FourthPageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.img.image = [UIImage imageNamed:self.menuArr[indexPath.row][0]];
        cell.title.text = self.menuArr[indexPath.row][1];
        cell.titleDetail.hidden = YES;
        if ([cell.title.text isEqualToString:@"清除缓存"]) {
            if (self.cacheSize > 100) {
                cell.titleDetail.hidden = NO;
                cell.titleDetail.text = [NSString stringWithFormat:@"%.1fM",self.cacheSize];
            }
        }
        return cell;
    }else{
        FourthPageCell_1 *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (cell == nil) {
            cell = [[FourthPageCell_1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        }
        cell.img.image = [UIImage imageNamed:self.menuArr[indexPath.row][0]];
        cell.title.text = self.menuArr[indexPath.row][1];
        cell.titleDetail.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([cell.title.text isEqualToString:@"清除缓存"]) {
            if (self.cacheSize > 100) {
                cell.titleDetail.hidden = NO;
                cell.titleDetail.text = [NSString stringWithFormat:@"%.1fM",self.cacheSize];
            }
        }

        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.menuArr[indexPath.row][1] isEqualToString:@"清除缓存"] ) {
        [self clearCache];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (IPHONE_WIDTH <= 540) {
        if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 40, 0, 0)];
        }
    }else{
        if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, -10, 0, 0)];
        }
    }
    
}

- (void)getCacheSize{
    
    myWeakSelf;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        weakSelf.cacheSize = [weakSelf getCacheSizeAtPath:[weakSelf getCachesPath]];
        [weakSelf.tableView reloadData];
    });
}

- (void)requestData{
   
}


- (void)clearCache{
    NSString *path = [self getCachesPath];
    NSLog(@"%lf",[self getCacheSizeAtPath:path]);
    
    [MBProgressHUD hideHUDForView:self.scroll animated:NO];
    
    MBProgressHUD *hud = nil;
    hud = [MBProgressHUD showHUDAddedTo:self.scroll animated:NO];
    hud.mode = MBProgressHUDModeIndeterminate;
   
    
    myWeakSelf;
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        
        [MBProgressHUD hideHUDForView:weakSelf.scroll animated:YES];
        [hud setRemoveFromSuperViewOnHide:YES];
        [hud removeFromSuperview];
        [commonTools showBriefAlert:@"清除完成"];
        weakSelf.cacheSize = 0;
        [weakSelf.tableView reloadData];
    }];
    [[SDImageCache sharedImageCache] clearMemory];
    [self clearCacheAtPath:path];
    //[[SDImageCache sharedImageCache] clearDisk];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)getCachesPath{
    // 获取Caches目录路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask,YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    //NSString *filePath = [cachesDir stringByAppendingPathComponent:@"myCache"];
    return cachesDir;
}

-(float)getCacheSizeAtPath:(NSString*)folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];//从前向后枚举器
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSLog(@"fileName ==== %@",fileName);
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        NSLog(@"fileAbsolutePath ==== %@",fileAbsolutePath);
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    NSLog(@"folderSize ==== %lld",folderSize);
    return folderSize/(1024.0*1024.0);
}
-(long long)fileSizeAtPath:(NSString*)filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

-(void)clearCacheAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
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
