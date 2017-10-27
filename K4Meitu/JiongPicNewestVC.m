//
//  JiongPicNewestVC.m
//  K4Meitu
//
//  Created by simpleem on 7/26/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "JiongPicNewestVC.h"
#import "Header.h"
#import "commonTools.h"
#import "MJRefresh.h"
#import "JiongPicNewestCell.h"
#import "JiongPicNewestRequest.h"
#import "PicGroupDetailRequest.h"
#import <SDImageCache.h>
@interface JiongPicNewestVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JiongPicNewestVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackButton:NO];
    [self addStatusBlackBackground];
    [self addTitleWithName:@"搞笑GIF" wordNun:4];
    self.view.backgroundColor = lightGray_Color;
    self.curPage = 0;
    
    [self initTableView];
    [self requestData];
    [self refreshData];
    NSLog(@"groupId = %@ **** title = %@",self.groupId,self.Title);
}

- (void)initTableView{
    if (self.picTable == nil) {
        self.picTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT-SPH(74)) style:UITableViewStylePlain];
    }
    self.picTable.delegate = self;
    self.picTable.dataSource = self;
    self.picTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.picTable registerNib:[UINib nibWithNibName:@"JiongPicNewestCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.picTable];
    
    if (self.dataArr == nil) {
        self.dataArr = [[NSMutableArray alloc] init];
    }

}
- (void)refreshData{
    myWeakSelf;
    self.picTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.curPage++;
        if (weakSelf.curPage < weakSelf.maxPage) {
            [weakSelf requestData];
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

- (void)requestData{
    myWeakSelf;
    if (self.dataArr == nil) {
        self.dataArr = [NSMutableArray array];
    }
    [JiongPicNewestRequest requestCurPage:self.curPage dataBlock:^(NSMutableArray *dataArr, NSInteger maxPage) {
        
        //[weakSelf.dataArr addObject:dataArr];
        for (JiongPicNewestModel *model in dataArr) {
            [weakSelf.dataArr addObject:model];
        }
        //weakSelf.dataArr = dataArr;
        weakSelf.maxPage = (int)maxPage;
        
        [weakSelf.picTable reloadData];
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JiongPicNewestModel *model = self.dataArr[indexPath.row];
    
    return 50+model.imgCoverHeight;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   // return self.dataArr.count;
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JiongPicNewestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (self == nil) {
        cell = [[JiongPicNewestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    JiongPicNewestModel *model = self.dataArr[indexPath.row];
    cell = [JiongPicNewestRequest JiongCell:cell dataArr:model IndexPath:(NSIndexPath *)indexPath];
    [cell.likeCount addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.dislikeCount addTarget:self action:@selector(dislikeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.cmtCount addTarget:self action:@selector(cmtBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.share addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    
}


- (void)likeBtnClick:(UIButton *)btn{
   JiongPicNewestModel *model = self.dataArr[btn.tag - 300];
    
    myWeakSelf;
    [JiongPicNewestRequest requestAddLikeOrDislikeData:model.Gid like:@1 dislike:@0 groupId:model.groupId addLikeBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            model.isSetLike = YES;
            model.likeCount += 1;
            model.isSetDislike = NO;
            [weakSelf.dataArray replaceObjectAtIndex:btn.tag - 300 withObject:model];
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:btn.tag - 300 inSection:0];
            
            [weakSelf.picTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}

- (void)dislikeBtnClick:(UIButton *)btn{
    JiongPicNewestModel *model = self.dataArr[btn.tag - 400];
   
    myWeakSelf;
    [JiongPicNewestRequest requestAddLikeOrDislikeData:model.Gid like:@0 dislike:@1 groupId:model.groupId addLikeBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            model.isSetDislike = YES;
            model.dislikeCount += 1;
            model.isSetLike = NO;
            [weakSelf.dataArray replaceObjectAtIndex:btn.tag - 400 withObject:model];
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:btn.tag - 400 inSection:0];
            [weakSelf.picTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}
- (void)cmtBtnClick:(UIButton *)btn{
    
}

- (void)shareBtnClick:(UIButton *)btn{
    
    myWeakSelf;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        JiongPicNewestModel *model = weakSelf.dataArr[btn.tag - 500];
        //分享的标题
        NSString *textToShare = model.Title;
        //分享的图片
        UIImage *imageToShare = [UIImage imageNamed:@"tmp0262246a"];
        //分享的url
        NSURL *urlToShare = [NSURL URLWithString:model.imgUrl];
        //在这里呢 如果想分享图片 就把图片添加进去  文字什么的通上
        NSArray *activityItems = @[textToShare,imageToShare, urlToShare];
        UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
        //不出现在活动项目
        activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
        [weakSelf presentViewController:activityVC animated:YES completion:nil];
       
        // 分享之后的回调
        activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
            if (completed) {
                NSLog(@"completed");
                //分享 成功
            } else  {
                NSLog(@"cancled");
                //分享 取消
            }
        };
  
        
    });
}



- (void)viewWillDisappear:(BOOL)animated{
    [[SDImageCache sharedImageCache] clearMemory];

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
