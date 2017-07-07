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
#import "NSString+isContainEmoji.h"
#import "UIButton+enLargedRect.h"
#import <YYCache.h>
@interface PicGroupDetailVC () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (strong, nonatomic) UITableView *commentTable;
@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) PicGroupDetailTitleDetailView *titleDetailView;
@property (assign, nonatomic) CGFloat photosHeight;
@property (assign, nonatomic) int maxPage;
@property (assign, nonatomic) int curPage;
@property (strong, nonatomic)  PYPhotosView *photosView;
@property (strong, nonatomic) UILabel *commentLab;
@property (strong, nonatomic) UIButton *cmtBtn;
@property (strong, nonatomic) UIView *commentBGView;
@property (strong, nonatomic) UITextField *cmtTF;
@property (strong, nonatomic) UIView *cmtTFBGView;
@property (strong, nonatomic) YYCache *cache;
@property (strong, nonatomic) NSMutableArray *imgUrls;


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
    
    
    //[self.cache removeAllObjects];
    [self initArray];
    [self initCommentTable];
    [self addfloatBackButton];
    [self refreshData];
    
    
}

- (void)initArray{
    if (self.dataArray == nil) {
        self.dataArray = [[NSMutableArray alloc]init];
    }
    if (self.imgUrls == nil) {
        self.imgUrls = [[NSMutableArray alloc]init];
    }
    if (self.headerView == nil) {
        self.headerView = [[UIView alloc]init];
    }
    if (self.cache == nil) {
        self.cache = [YYCache cacheWithName:@"PicGroupDetail"];
    }
}

- (void)initCommentTable{
    if (self.commentTable == nil) {
         self.commentTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT-64) style:UITableViewStylePlain];
    }
    self.commentTable.delegate = self;
    self.commentTable.dataSource = self;
    [self.commentTable registerNib:[UINib nibWithNibName:@"PicGroupCommentCell" bundle:nil]forCellReuseIdentifier:@"cmtCell"];
      if ([self.cache containsObjectForKey:[NSString stringWithFormat:@"picGroupDetail%@",self.groupId]]&&[self.cache containsObjectForKey:[NSString stringWithFormat:@"picGroupDetailImgs%@",self.groupId]]) {
          
          [self.dataArray removeAllObjects];
          [self.imgUrls removeAllObjects];
          
         self.dataArray = (NSMutableArray *)[self.cache objectForKey:[NSString stringWithFormat:@"picGroupDetail%@",self.groupId]];
          NSLog(@"self.datArrayFromCache:%ld",self.dataArray.count);
         self.imgUrls = (NSMutableArray *)[self.cache objectForKey:[NSString stringWithFormat:@"picGroupDetailImgs%@",self.groupId]];
         self.maxPage = [(NSNumber *)[self.cache objectForKey:[NSString stringWithFormat:@"picGroupDetailMaxPage%@",self.groupId]] intValue];
          self.curPage = [(NSNumber *)[self.cache objectForKey:[NSString stringWithFormat:@"picGroupDetailCurPage%@",self.groupId]] intValue];
          
          if (self.photosView == nil) {
               self.photosView = [PicGroupDetailRequest imgScrollView:self.imgUrls];
          }
        [self initHeaderView:self.photosView];
        [self.commentTable reloadData];
        
      }else{
          [self requestData];
      }
    
}

- (void)requestData{

    
    
    [PicGroupDetailRequest requestData:self.groupId dataBlock:^(NSMutableArray *dataArr,NSNumber *maxPage, NSNumber *commentCount, NSNumber *likeCount) {
        myWeakSelf;
        for (PicGroupDetailModel *model in dataArr) {
            [weakSelf.imgUrls addObject:model.imgUrl];
        }
        [weakSelf.cache removeObjectForKey:[NSString stringWithFormat:@"picGroupDetailImgs%@",weakSelf.groupId]];
        [weakSelf.cache setObject:weakSelf.imgUrls forKey:[NSString stringWithFormat:@"picGroupDetailImgs%@",weakSelf.groupId]];
        
        //缩略图列表
        if (weakSelf.photosView == nil) {
            weakSelf.photosView = [PicGroupDetailRequest imgScrollView:weakSelf.imgUrls];
        }
        [weakSelf initHeaderView:weakSelf.photosView];
        [weakSelf requestCommentData:weakSelf.photosView];
        
    }];
}

- (void)initHeaderView:(PYPhotosView *)photosView{
    self.headerView.frame = CGRectMake(0, 0, IPHONE_WIDTH, photosView.frame.size.height+100+SPH(65));
    self.headerView.backgroundColor = [UIColor darkGrayColor];
    if (self.titleDetailView == nil) {
        
        if ([self.cache containsObjectForKey:[NSString stringWithFormat:@"picGroupDetailCmtCount%@",self.groupId]] && [self.cache containsObjectForKey:[NSString stringWithFormat:@"picGroupDetailLikeCount%@",self.groupId]]) {
            NSNumber *cmtCount = (NSNumber *)[self.cache objectForKey:[NSString stringWithFormat:@"picGroupDetailCmtCount%@",self.groupId]];
            NSNumber *likeCount = (NSNumber *)[self.cache objectForKey:[NSString stringWithFormat:@"picGroupDetailLikeCount%@",self.groupId]];
            self.titleDetailView = nil;
            self.titleDetailView = [PicGroupDetailRequest titleDetailView:self.picTitle picCount:self.picCount type:self.type date:self.picDate cmtCount:[cmtCount intValue] likeCount:[likeCount intValue]];
            [self.headerView addSubview:self.titleDetailView];
        }else{
            self.titleDetailView = nil;
            self.titleDetailView = [PicGroupDetailRequest titleDetailView:self.picTitle picCount:self.picCount type:self.type date:self.picDate cmtCount:0 likeCount:0];
            [self.headerView addSubview:self.titleDetailView];
        }
        
        
    }
    if (self.commentBGView == nil) {
        //commentBGView
        self.commentBGView = [[UIView alloc] initWithFrame:CGRectMake(0, photosView.frame.size.height+100+SPH(25), IPHONE_WIDTH, SPH(40))];
        self.commentBGView.backgroundColor = S_Light_Gray;
        if (self.commentLab == nil) {
            self.commentLab = [PicGroupDetailRequest commentLab:CGRectMake(IPHONE_WIDTH*0.05, 0, IPHONE_WIDTH*0.4, SPH(40))];
            [self.commentBGView addSubview:self.commentLab];
        }
        
        
        //添加“发表评论”按钮
        if (self.cmtBtn == nil) {
            self.cmtBtn = [PicGroupDetailRequest addCommentBtn];
        }
        self.cmtBtn.frame = CGRectMake(IPHONE_WIDTH*0.75, SPH(40)*0.1, IPHONE_WIDTH*0.25, SPH(40)*0.8);
        [self.cmtBtn addTarget:self action:@selector(cmtBtnClick) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(IPHONE_WIDTH*0.75-SPH(40)*0.8, SPH(40)*0.1, SPH(40)*0.8, SPH(40)*0.8)];
        img.image = [UIImage imageNamed:@"writeComment"];
        [self.commentBGView addSubview:img];
        [self.commentBGView addSubview:self.cmtBtn];
        [self.commentBGView bringSubviewToFront:self.cmtBtn];
        
        //添加到tableViewHeaderView
        [self.headerView addSubview:self.commentBGView];
        [self.headerView addSubview:photosView];
        self.commentTable.tableHeaderView = self.headerView;
        
        //self.view添加tableView
        [self.view addSubview:self.commentTable];
        [self.view sendSubviewToBack:self.commentTable];
        self.photosHeight = photosView.frame.size.height;
        self.photosHeight = self.photosHeight*0.83;
    }
    

}

- (void)requestCommentData:(PYPhotosView *)photosView{
    
    
    [PicGroupDetailRequest requestCommentData:self.groupId CurPage:[NSNumber numberWithInt:self.curPage] pcout:@10 dataBlock:^(NSMutableArray *dataArr, NSNumber *maxPage, NSNumber *commentCount, NSNumber *likeCount) {
        myWeakSelf;
        
        [weakSelf.dataArray addObjectsFromArray:dataArr];
        [weakSelf.cache setObject:commentCount forKey:[NSString stringWithFormat:@"picGroupDetailCmtCount%@",weakSelf.groupId] withBlock:^{
            
        }];
        [weakSelf.cache setObject:likeCount forKey:[NSString stringWithFormat:@"picGroupDetailLikeCount%@",weakSelf.groupId] withBlock:^{
            
        }];
        [weakSelf.cache setObject:maxPage forKey:[NSString stringWithFormat:@"picGroupDetailMaxPage%@",weakSelf.groupId] withBlock:^{
            
        }];
        [weakSelf.cache setObject:weakSelf.dataArray forKey:[NSString stringWithFormat:@"picGroupDetail%@",weakSelf.groupId] withBlock:^{
            
        }];
        
        
        weakSelf.maxPage = [maxPage intValue];
        //weakSelf.titleDetailView = nil;
//        weakSelf.titleDetailView = [PicGroupDetailRequest titleDetailView:weakSelf.picTitle picCount:weakSelf.picCount type:weakSelf.type date:weakSelf.picDate cmtCount:[commentCount intValue] likeCount:[likeCount intValue]];
        weakSelf.titleDetailView.commentCount.text = [NSString stringWithFormat:@"评论(%@)",commentCount];
        weakSelf.titleDetailView.likeCount.text = [NSString stringWithFormat:@"点赞(%@)",likeCount];
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
        
        UIButton *btn = nil;
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
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
    
    if (![NSString isContainsEmoji:self.cmtTF.text]) {
        if (self.cmtTF.text.length <= 150) {
            
            PicGroupCommentModel *model = [[PicGroupCommentModel alloc]init];
            model.commentId = 999999999;
            model.isCmtShow = 1;
            model.groupId = self.groupId;
            model.userId = userID;
            model.imgComment = self.cmtTF.text;
            model.commentLike = 0;
            model.commentDislike = 0;
            model.date = [GetCurrentTime GetCurrentBeijingTimeandReturnTimeType:YYYY_MM_DD_and_HH_MM_SS];
            model.isSetCmtLike = NO;
            model.isSetDiscmtLike = NO;
            
            [self.dataArray insertObject:model atIndex:0];
            [self.cache setObject:self.dataArray forKey:[NSString stringWithFormat:@"picGroupDetail%@",self.groupId] withBlock:^{
                
            }];
            //缓存评论数
             NSNumber *cmtCount = (NSNumber *)[self.cache objectForKey:[NSString stringWithFormat:@"picGroupDetailCmtCount%@",self.groupId]];
            cmtCount = [NSNumber numberWithInt:[cmtCount intValue] + 1];
            [self.cache setObject:cmtCount forKey:[NSString stringWithFormat:@"picGroupDetailCmtCount%@",self.groupId] withBlock:^{
            }];
             self.titleDetailView.commentCount.text = [NSString stringWithFormat:@"评论(%@)",cmtCount];
            [self.commentTable reloadData];
            //添加评论
            [PicGroupDetailRequest requestAddComment:self.cmtTF.text imgId:@1 groupId:self.groupId resblock:^(BOOL isSuccess) {
                myWeakSelf;
                if (isSuccess) {
                    [weakSelf.cmtTF resignFirstResponder];
                    [weakSelf.cmtTFBGView removeFromSuperview];
                    weakSelf.cmtTFBGView = nil;
                    weakSelf.cmtTF = nil;
                
                    weakSelf.titleDetailView.commentCount.text = [NSString stringWithFormat:@"评论(%d)",[[[ weakSelf.titleDetailView.commentCount.text componentsSeparatedByString:@"("][1] componentsSeparatedByString:@")"][0] intValue]];
                    weakSelf.maxPage = [(NSNumber *)[weakSelf.cache objectForKey:[NSString stringWithFormat:@"picGroupDetailMaxPage%@",self.groupId]] intValue];
                }else{
                    [weakSelf.dataArray removeLastObject];
                    [weakSelf.cache setObject:weakSelf.dataArray forKey:[NSString stringWithFormat:@"picGroupDetail%@",self.groupId] withBlock:^{
                        
                    }];
                }
            }];
        }else{
            [commonTools showBriefAlert:@"评论字数不能大于150字"];
        }
    }else{
        [commonTools showBriefAlert:@"评论不能输入表情"];
    }
    
}

#pragma mark ---------------------------END-----------------------------------

- (void)refreshData{
    self.commentTable.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        myWeakSelf;
        [weakSelf.commentTable.mj_header endRefreshing];
        weakSelf.curPage = 0;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.imgUrls removeAllObjects];
        [weakSelf.cache removeAllObjects];
        [weakSelf requestData];
    }];
    
    self.commentTable.mj_footer  = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        myWeakSelf;
        weakSelf.curPage++;
        if (weakSelf.curPage <= weakSelf.maxPage) {
            [weakSelf.commentTable.mj_footer endRefreshing];
            [weakSelf requestCommentData:weakSelf.photosView];
            [weakSelf.cache setObject:[NSNumber numberWithInt:weakSelf.curPage] forKey:[NSString stringWithFormat:@"picGroupDetailCurPage%@",weakSelf.groupId] withBlock:^{
                
            }];
        }else{
            [weakSelf.commentTable.mj_footer endRefreshingWithNoMoreData];
        }

    }];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.dataArray.count == 0) {
        return SPH(80);
    }
    
    PicGroupCommentModel *model = self.dataArray[indexPath.row];
    CGSize labelSize = {0,0};
    labelSize = [model.imgComment sizeWithFont:[UIFont systemFontOfSize:15.0f] constrainedToSize:CGSizeMake(IPHONE_WIDTH*0.9, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];

    return labelSize.height + SPH(80);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count != 0 ? self.dataArray.count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    PicGroupCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cmtCell"];
    if (cell == nil) {
        cell = [[PicGroupCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cmtCell"];
    }
    if (self.dataArray.count != 0) {
        PicGroupCommentModel *model = self.dataArray[indexPath.row];
        cell.userName.text = model.userId.length == 32?[NSString stringWithFormat:@"用户:***%@",[model.userId substringFromIndex:28]]:@"游客:****";
        cell.userName.numberOfLines = 0;
        [cell.userName sizeToFit];
        cell.date.text = model.date;
        cell.cmtLikeCount.text = [NSString stringWithFormat:@"%d",model.commentLike];
        cell.cmtDislikeCount.text = [NSString stringWithFormat:@"%d",model.commentDislike];
        cell.commentFloor.text = [NSString stringWithFormat:@"第%ld楼",indexPath.row+1];
        cell.comment.text = model.imgComment;
        
        [cell.cmtDislikeBtn addTarget:self action:@selector(cmtDislikeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.cmtDislikeBtn setEnlargEdgeWithTop:10 right:10 bottom:25 left:30];
        [cell.cmtDislikeBtn setImage:[UIImage imageNamed:model.isSetDiscmtLike?@"dislike_thumb_red":@"dislike_thumb_gray"] forState:UIControlStateNormal];
        cell.cmtDislikeBtn.tag = 100+indexPath.row;
        
        [cell.cmtLikeBtn addTarget:self action:@selector(cmtLikeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.cmtLikeBtn setImage:[UIImage imageNamed:model.isSetCmtLike?@"like_thumb_red":@"like_thumb_gray"] forState:UIControlStateNormal];
        [cell.cmtLikeBtn setEnlargEdgeWithTop:10 right:10 bottom:25 left:25];
        cell.cmtLikeBtn.tag = 1000+indexPath.row;

        
    }

    return cell;
}

- (void)cmtDislikeBtnClick:(UIButton *)btn{
    PicGroupCommentModel *model = self.dataArray[btn.tag-100];
    model.commentDislike += 1;
    model.isSetDiscmtLike = YES;
    model.isSetCmtLike = NO;
    [self.dataArray replaceObjectAtIndex:btn.tag - 100 withObject:model];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:btn.tag - 100 inSection:0];
    [self.cache setObject:self.dataArray forKey:[NSString stringWithFormat:@"picGroupDetail%@",self.groupId] withBlock:^{
        
    }];
    if (model.commentId != 999999999) {
        [PicGroupDetailRequest requestAddCommentLike:[NSNumber numberWithInt:model.commentId] commentLike:@0 commentDislike:@1 resBlock:^(BOOL isSuccess) {
            if (isSuccess) {
                myWeakSelf;
                [commonTools showBriefAlert:@"踩成功"];
                [weakSelf.commentTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            }else{
                
            }
        }];
    }else{
        [commonTools showBriefAlert:@"不能踩自己的评论"];
    }
    
    
}
- (void)cmtLikeBtnClick:(UIButton *)btn{
   
    
    PicGroupCommentModel *model = self.dataArray[btn.tag-1000];
    model.commentLike += 1;
    model.isSetCmtLike = YES;
    model.isSetDiscmtLike = NO;
    [self.dataArray replaceObjectAtIndex:btn.tag - 1000 withObject:model];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:btn.tag - 1000 inSection:0];
    [self.cache setObject:self.dataArray forKey:[NSString stringWithFormat:@"picGroupDetail%@",self.groupId] withBlock:^{
        
    }];
    
    
    if (model.commentId != 999999999) {
        [PicGroupDetailRequest requestAddCommentLike:[NSNumber numberWithInt:model.commentId] commentLike:@1 commentDislike:@0 resBlock:^(BOOL isSuccess) {
            if (isSuccess) {
                myWeakSelf;
                [commonTools showBriefAlert:@"顶成功"];
                [weakSelf.commentTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            }else{
                
            }
        }];
    } else {
        [commonTools showBriefAlert:@"不能给自己评论点赞"];
    }
}

- (void)addfloatBackButton{

//    UIButton *backBtn = [PicGroupDetailRequest addBackBtn];
//    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:backBtn];
//    [self.view bringSubviewToFront:backBtn];
    
    [PicGroupDetailRequest requestIsLikeExistGroupID:self.groupId isLike:^(BOOL isLike) {
        CatZanButton *zanBtn = nil;
        
       zanBtn =[[CatZanButton alloc] init];
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
