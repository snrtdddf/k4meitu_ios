//
//  PicGroupDetailVC.m
//  K4Meitu
//
//  Created by simpleem on 6/21/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "PicGroupDetailVC.h"
#import "Header.h"
#import "PYPhotoBrowser.h"
#import "PicGroupDetailRequest.h"
#import "PicGroupDetailModel.h"
#import "PicGroupCommentModel.h"
#import "PicGroupCommentCell.h"
#import "GetCurrentTime.h" 
#import "PicGroupDetailTitleView.h"
#import "commonTools.h"
#import "MJRefresh.h"
@interface PicGroupDetailVC () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (strong, nonatomic) UITableView *commentTable;
@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UIView *titleDetailView;
@property (assign, nonatomic) CGFloat photosHeight;
@property (strong, nonatomic) UITextField *commentTF;
@property (assign, nonatomic) int maxPage;
@property (assign, nonatomic) int curPage;
@property (strong, nonatomic)  PYPhotosView *photosView;
@property (strong, nonatomic) UILabel *commentLab;


@end

@implementation PicGroupDetailVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackButton:NO];
    [self addStatusBlackBackground];
    [self addTitleWithName:@"套图" wordNun:4];
    self.view.backgroundColor = [UIColor darkGrayColor];
    self.curPage = 0;
    self.dataArray = [NSMutableArray array];
    self.headerView = [[UIView alloc]init];
    
    [self initCommentTable];
    [self requestData];
    [self addfloatBackButton];
    [self refreshData];
    
}

- (void)requestData{

    [PicGroupDetailRequest requestData:self.groupId dataBlock:^(NSMutableArray *dataArr,NSNumber *maxPage) {
        myWeakSelf;
        NSMutableArray *imgUrls = nil;
        imgUrls = [[NSMutableArray alloc] init];
        for (PicGroupDetailModel *model in dataArr) {
            [imgUrls addObject:model.imgUrl];
        }
        
        //缩略图列表
        weakSelf.photosView = [PicGroupDetailRequest imgScrollView:imgUrls];
        
        [weakSelf requestCommentData:weakSelf.photosView];
        
    }];
}

- (void)requestCommentData:(PYPhotosView *)photosView{
    [PicGroupDetailRequest requestCommentData:@"2222017970" CurPage:[NSNumber numberWithInt:self.curPage] pcout:@10 dataBlock:^(NSMutableArray *dataArr, NSNumber *maxPage) {
        myWeakSelf;
        [weakSelf.dataArray addObjectsFromArray:dataArr];
        weakSelf.maxPage = [maxPage intValue];
        NSLog(@"count_CUR:%ld",dataArr.count);
        weakSelf.headerView.frame = CGRectMake(0, 0, IPHONE_WIDTH, photosView.frame.size.height+100+SPH(60));
        weakSelf.headerView.backgroundColor = [UIColor darkGrayColor];
        if (weakSelf.titleDetailView == nil) {
             weakSelf.titleDetailView = [PicGroupDetailRequest titleDetailView:weakSelf.picTitle picCount:weakSelf.picCount type:weakSelf.type date:weakSelf.picDate cmtCount:10 likeCount:20];
            [weakSelf.headerView addSubview:weakSelf.titleDetailView];
        }
        if (weakSelf.commentLab == nil) {
            weakSelf.commentLab = [PicGroupDetailRequest commentLab:CGRectMake(0, photosView.frame.size.height+100+SPH(20), IPHONE_WIDTH, SPH(40))];
             [weakSelf.headerView addSubview:weakSelf.commentLab];
             [weakSelf.headerView addSubview:photosView];
            weakSelf.commentTable.tableHeaderView = weakSelf.headerView;
            [weakSelf.view addSubview:weakSelf.commentTable];
            [weakSelf.view sendSubviewToBack:weakSelf.commentTable];
            weakSelf.photosHeight = photosView.frame.size.height;
            weakSelf.photosHeight = weakSelf.photosHeight*0.83;
        }
       
        [weakSelf.commentTable reloadData];
        
    }];

}

- (void)refreshData{
    self.commentTable.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        myWeakSelf;
        [weakSelf.commentTable.mj_header endRefreshing];
        weakSelf.curPage = 0;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf requestData];
    }];
    
    self.commentTable.mj_footer  = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        myWeakSelf;
        weakSelf.curPage++;
        if (weakSelf.curPage <= weakSelf.maxPage) {
            [weakSelf.commentTable.mj_footer endRefreshing];
            [weakSelf requestCommentData:weakSelf.photosView];
        }else{
            [weakSelf.commentTable.mj_footer endRefreshingWithNoMoreData];
        }

    }];
    
}

- (void)initCommentTable{
    self.commentTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT-64) style:UITableViewStylePlain];
    self.commentTable.delegate = self;
    self.commentTable.dataSource = self;
    [self.commentTable registerNib:[UINib nibWithNibName:@"PicGroupCommentCell" bundle:nil]forCellReuseIdentifier:@"commentCell"];
   
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PicGroupCommentModel *model = self.dataArray[indexPath.row];
    CGSize labelSize = {0,0};
    labelSize = [model.imgComment sizeWithFont:[UIFont systemFontOfSize:15.0f] constrainedToSize:CGSizeMake(IPHONE_WIDTH*0.9, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];

    return labelSize.height + SPH(80);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count != 0 ? self.dataArray.count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"commentCell";
    PicGroupCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[PicGroupCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (self.dataArray.count != 0) {
        PicGroupCommentModel *model = self.dataArray[indexPath.row];
        cell.userName.text = model.userId.length == 32?[NSString stringWithFormat:@"用户:***%@",[model.userId substringFromIndex:28]]:@"游客:****";
        cell.userName.numberOfLines = 0;
        [cell.userName sizeToFit];
        cell.date.text = model.date;
        cell.commentFloor.text = [NSString stringWithFormat:@"第%ld楼",indexPath.row+1];
        cell.comment.text = model.imgComment;
    }

    return cell;
}
- (void)addfloatBackButton{

    UIButton *backBtn = [PicGroupDetailRequest addBackBtn];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    [self.view bringSubviewToFront:backBtn];
}

- (void)backBtnClick{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
