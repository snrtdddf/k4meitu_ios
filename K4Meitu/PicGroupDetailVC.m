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
#import "CatZanButton.h"
@interface PicGroupDetailVC () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (strong, nonatomic) UITableView *commentTable;
@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) PicGroupDetailTitleDetailView *titleDetailView;
@property (assign, nonatomic) CGFloat photosHeight;
@property (strong, nonatomic) UITextField *commentTF;
@property (assign, nonatomic) int maxPage;
@property (assign, nonatomic) int curPage;
@property (strong, nonatomic)  PYPhotosView *photosView;
@property (strong, nonatomic) UILabel *commentLab;
@property (strong, nonatomic) UIButton *cmtBtn;
@property (strong, nonatomic) UIView *commentBGView;
@property (strong, nonatomic) UITextField *cmtTF;
@property (strong, nonatomic) UIView *cmtTFBGView;


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

    [PicGroupDetailRequest requestData:self.groupId dataBlock:^(NSMutableArray *dataArr,NSNumber *maxPage, NSNumber *commentCount, NSNumber *likeCount) {
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
    [PicGroupDetailRequest requestCommentData:self.groupId CurPage:[NSNumber numberWithInt:self.curPage] pcout:@10 dataBlock:^(NSMutableArray *dataArr, NSNumber *maxPage, NSNumber *commentCount, NSNumber *likeCount) {
        myWeakSelf;
        [weakSelf.dataArray addObjectsFromArray:dataArr];
        weakSelf.maxPage = [maxPage intValue];
        
        weakSelf.headerView.frame = CGRectMake(0, 0, IPHONE_WIDTH, photosView.frame.size.height+100+SPH(65));
        weakSelf.headerView.backgroundColor = [UIColor darkGrayColor];
        if (weakSelf.titleDetailView == nil) {
             weakSelf.titleDetailView = [PicGroupDetailRequest titleDetailView:weakSelf.picTitle picCount:weakSelf.picCount type:weakSelf.type date:weakSelf.picDate cmtCount:[commentCount intValue] likeCount:[likeCount intValue]];
            [weakSelf.headerView addSubview:weakSelf.titleDetailView];
        }
        if (weakSelf.commentBGView == nil) {
            //commentBGView
            weakSelf.commentBGView = [[UIView alloc] initWithFrame:CGRectMake(0, photosView.frame.size.height+100+SPH(25), IPHONE_WIDTH, SPH(40))];
            weakSelf.commentBGView.backgroundColor = S_Light_Gray;
            weakSelf.commentLab = [PicGroupDetailRequest commentLab:CGRectMake(IPHONE_WIDTH*0.05, 0, IPHONE_WIDTH*0.4, SPH(40))];
            [weakSelf.commentBGView addSubview:weakSelf.commentLab];
            
            //添加“发表评论”按钮
            weakSelf.cmtBtn = [PicGroupDetailRequest addCommentBtn];
            weakSelf.cmtBtn.frame = CGRectMake(IPHONE_WIDTH*0.75, SPH(40)*0.1, IPHONE_WIDTH*0.25, SPH(40)*0.8);
            [weakSelf.cmtBtn addTarget:self action:@selector(cmtBtnClick) forControlEvents:UIControlEventTouchUpInside];
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(IPHONE_WIDTH*0.75-SPH(40)*0.8, SPH(40)*0.1, SPH(40)*0.8, SPH(40)*0.8)];
            img.image = [UIImage imageNamed:@"writeComment"];
            [weakSelf.commentBGView addSubview:img];
            [weakSelf.commentBGView addSubview:weakSelf.cmtBtn];
            [weakSelf.commentBGView bringSubviewToFront:weakSelf.cmtBtn];
            
            //添加到tableViewHeaderView
             [weakSelf.headerView addSubview:weakSelf.commentBGView];
             [weakSelf.headerView addSubview:photosView];
            weakSelf.commentTable.tableHeaderView = weakSelf.headerView;
            
            //self.view添加tableView
            [weakSelf.view addSubview:weakSelf.commentTable];
            [weakSelf.view sendSubviewToBack:weakSelf.commentTable];
            weakSelf.photosHeight = photosView.frame.size.height;
            weakSelf.photosHeight = weakSelf.photosHeight*0.83;
        }
       
        [weakSelf.commentTable reloadData];
        
    }];

}

- (void)cmtBtnClick{
    if (self.cmtTFBGView == nil) {
        self.cmtTFBGView = [[UIView alloc] initWithFrame:CGRectMake(0, IPHONE_HEIGHT*0.9-64, IPHONE_WIDTH, IPHONE_HEIGHT*0.1)];
        self.cmtTFBGView.backgroundColor = S_Light_Gray;
        if (self.cmtTF == nil) {
            self.cmtTF = [[UITextField alloc] init];
        }
        self.cmtTF.frame = CGRectMake(IPHONE_WIDTH*0.05, IPHONE_HEIGHT*0.1*0.2, IPHONE_WIDTH*0.7, IPHONE_HEIGHT*0.1*0.6);
        self.cmtTF.borderStyle = UITextBorderStyleRoundedRect;
        [self.cmtTF addTarget:self action:@selector(cmtTFClick) forControlEvents:UIControlEventEditingChanged];
        self.cmtTF.placeholder = @"请输入评论";
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(IPHONE_WIDTH*0.8, IPHONE_HEIGHT*0.1*0.25, IPHONE_WIDTH*0.15, IPHONE_HEIGHT*0.1*0.5);
        btn.backgroundColor = [UIColor colorWithRed:10/255.0f green:122/255.0f blue:255/255.0f alpha:1];
        [btn setTitleColor:White_COLOR forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [btn setTitle:@"评论" forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5;
        btn.clipsToBounds = YES;
        [btn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.cmtTFBGView addSubview:btn];
        [self.cmtTFBGView addSubview:self.cmtTF];
        [self.view addSubview:self.cmtTFBGView];
        [self.view bringSubviewToFront:self.cmtTFBGView];
        
        [self.cmtTF becomeFirstResponder];
    }
    
}

#pragma mark -----------------------UITextField Action----------------------


- (void)cmtTFClick{
    
}

- (void)commitBtnClick{
    [PicGroupDetailRequest requestAddComment:self.cmtTF.text imgId:@1 groupId:self.groupId resblock:^(BOOL isSuccess) {
        myWeakSelf;
        if (isSuccess) {
            [weakSelf.cmtTF resignFirstResponder];
            [weakSelf.cmtTFBGView removeFromSuperview];
            weakSelf.cmtTFBGView = nil;
            weakSelf.cmtTF = nil;
            [commonTools showBriefAlert:@"评论成功"];
            weakSelf.curPage = 0;
            [weakSelf.dataArray removeAllObjects];
            [weakSelf requestData];
           
        }
    }];
}

#pragma mark ---------------------------END-----------------------------------

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

//    UIButton *backBtn = [PicGroupDetailRequest addBackBtn];
//    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:backBtn];
//    [self.view bringSubviewToFront:backBtn];
    
    [PicGroupDetailRequest requestIsLikeExistGroupID:self.groupId isLike:^(BOOL isLike) {
            CatZanButton *zanBtn=[[CatZanButton alloc] init];
        zanBtn.frame =  CGRectMake(IPHONE_WIDTH*0.8, IPHONE_HEIGHT*0.70, SPW(50), SPW(50));
        if (IPHONE_WIDTH>540) {
            zanBtn.frame =  CGRectMake(IPHONE_WIDTH*0.85, IPHONE_HEIGHT*0.75, SPW(30), SPW(30));
        }
        [self.view addSubview:zanBtn];

        if (isLike) {
            [zanBtn setIsZan:YES];
            zanBtn.enabled = NO;
        }else{
            [zanBtn setType:CatZanButtonTypeFirework];
            
            [zanBtn setClickHandler:^(CatZanButton *zanButton) {
                myWeakSelf;
                if (zanButton.isZan) {
                    [PicGroupDetailRequest requestLikeData:weakSelf.groupId titleDetailView:weakSelf.titleDetailView];
                }
            }];
        }
    }];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
