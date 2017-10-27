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
#import "PicGroupDetailCell.h"
#import "IDMPhotoBrowser.h"
#import "ThirdViewController.h"
#import <YYCache.h>
#import <YYDiskCache.h>

#import "PYPhotosReaderController.h"

@interface PicGroupDetailVC () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,PYPhotosViewDelegate>
@property (strong, nonatomic) UITableView *commentTable;
@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) PicGroupDetailTitleDetailView *titleDetailView;
@property (assign, nonatomic) CGFloat photosHeight;
@property (assign, nonatomic) int maxPage;
@property (assign, nonatomic) int curPage;
@property (assign, nonatomic) int likeCount;

//@property (strong, nonatomic) PYPhotoBrowseView *photoBroseView;
@property (strong, nonatomic) PYPhotosView *photosView;

@property (strong, nonatomic) UILabel *commentLab;
@property (strong, nonatomic) UIButton *cmtBtn;
@property (strong, nonatomic) UIView *commentBGView;
@property (strong, nonatomic) UITextField *cmtTF;
@property (strong, nonatomic) UIView *cmtTFBGView;
@property (strong, nonatomic) YYDiskCache *cache;
@property (strong, nonatomic) CatZanButton *zanBtn;

@property (strong, nonatomic) NSMutableArray *imgUrls;
@property (strong, nonatomic) NSNumber *isLike; //设置成number类型，便于缓存


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
    self.isLike = @1;
    
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
        self.cache = [YYCache cacheWithName:@"PicGroupDetail"].diskCache;
        self.cache.ageLimit = 3*24*60*60;
        self.cache.costLimit = 1000556768;
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
              self.photosView.delegate = self;
          }
          [self initHeaderView:self.photosView];
          [self.commentTable reloadData];
        
      }else{
          [self requestData];
      }
    
}

- (void)requestData{

    
    myWeakSelf;
    [PicGroupDetailRequest requestData:self.groupId dataBlock:^(NSMutableArray *dataArr,NSNumber *maxPage, NSNumber *commentCount, NSNumber *likeCount) {
        [weakSelf.commentTable.mj_header endRefreshing];
        for (PicGroupDetailModel *model in dataArr) {
            [weakSelf.imgUrls addObject:model.imgUrl];
        }
        [weakSelf.cache removeObjectForKey:[NSString stringWithFormat:@"picGroupDetailImgs%@",weakSelf.groupId]];
        [weakSelf.cache setObject:weakSelf.imgUrls forKey:[NSString stringWithFormat:@"picGroupDetailImgs%@",weakSelf.groupId]];
     
        
        if (weakSelf.photosView == nil) {
            weakSelf.photosView = [PicGroupDetailRequest imgScrollView:weakSelf.imgUrls];
            weakSelf.photosView.delegate = self;
        }
        [weakSelf initHeaderView:weakSelf.photosView];
        [weakSelf requestCommentData];
        
    }];
}

- (void)initHeaderView:(PYPhotosView *)photosView{
    self.headerView.frame = CGRectMake(0, 0, IPHONE_WIDTH, photosView.frame.size.height+100+SPH(65));
    self.headerView.backgroundColor = [UIColor darkGrayColor];
    if (self.titleDetailView == nil) {
        
        if ([self.cache containsObjectForKey:[NSString stringWithFormat:@"picGroupDetailCmtCount%@",self.groupId]] &&
            [self.cache containsObjectForKey:[NSString stringWithFormat:@"picGroupDetailLikeCount%@",self.groupId]]) {
            NSNumber *cmtCount = (NSNumber *)[self.cache objectForKey:[NSString stringWithFormat:@"picGroupDetailCmtCount%@",self.groupId]];
            NSNumber *likeCount = (NSNumber *)[self.cache objectForKey:[NSString stringWithFormat:@"picGroupDetailLikeCount%@",self.groupId]];
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

- (void)requestCommentData{
    
    myWeakSelf;
    [PicGroupDetailRequest requestCommentData:self.groupId CurPage:[NSNumber numberWithInt:self.curPage] pcout:@10 dataBlock:^(NSMutableArray *dataArr, NSNumber *maxPage, NSNumber *commentCount, NSNumber *likeCount) {
        [weakSelf.commentTable.mj_footer endRefreshing];
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

        weakSelf.titleDetailView.commentCount.text = [NSString stringWithFormat:@"评论(%@)",commentCount];
        weakSelf.titleDetailView.likeCount.text = [NSString stringWithFormat:@"点赞(%@)",likeCount];
        weakSelf.likeCount = [likeCount intValue];
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
             myWeakSelf;
            [PicGroupDetailRequest requestAddComment:self.cmtTF.text imgId:@1 groupId:self.groupId resblock:^(BOOL isSuccess) {
                if (isSuccess) {
                    [weakSelf.cmtTF resignFirstResponder];
                    [weakSelf.cmtTFBGView removeFromSuperview];
                    weakSelf.cmtTFBGView = nil;
                    weakSelf.cmtTF = nil;
                
                    weakSelf.titleDetailView.commentCount.text = [NSString stringWithFormat:@"评论(%d)",[[[ weakSelf.titleDetailView.commentCount.text componentsSeparatedByString:@"("][1] componentsSeparatedByString:@")"][0] intValue]];
                    weakSelf.maxPage = [(NSNumber *)[weakSelf.cache objectForKey:[NSString stringWithFormat:@"picGroupDetailMaxPage%@",weakSelf.groupId]] intValue];
                }else{
                    [weakSelf.dataArray removeLastObject];
                    [weakSelf.cache setObject:weakSelf.dataArray forKey:[NSString stringWithFormat:@"picGroupDetail%@",weakSelf.groupId] withBlock:^{
                        
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
    myWeakSelf;
    self.commentTable.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        
        
        weakSelf.curPage = 0;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.imgUrls removeAllObjects];
        [weakSelf.cache removeAllObjects];
        [weakSelf requestData];
    }];
    self.commentTable.mj_footer  = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.curPage++;
        if (weakSelf.curPage <= weakSelf.maxPage) {
            
            [weakSelf requestCommentData];
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
        cell.userName.text = model.userId.length == 32?[NSString stringWithFormat:@"用户:***%@",[model.userId substringFromIndex:28]]:@"系统管理员";
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
        if (model.commentId == 999999999 || [model.userId isEqualToString:userID]) {
            cell.cmtLikeBtn.hidden = YES;
            cell.cmtLikeBtn.enabled = NO;
            cell.cmtLikeCount.hidden = YES;
            cell.cmtDislikeBtn.enabled = NO;
            cell.cmtDislikeCount.hidden = YES;
            cell.cmtDislikeBtn.hidden = YES;
        }

        
    }

    return cell;
}

- (void)cmtDislikeBtnClick:(UIButton *)btn{
    PicGroupCommentModel *model = self.dataArray[btn.tag-100];
    
    myWeakSelf;
    if (model.commentId != 999999999) {
        if (model.userId != userID) {
            [PicGroupDetailRequest requestAddCommentLike:[NSNumber numberWithInt:model.commentId] commentLike:@0 groupId:model.groupId cmtUserId:model.userId commentDislike:@1 resBlock:^(BOOL isSuccess) {
                if (isSuccess) {
                    [commonTools showBriefAlert:@"踩成功"];
                    model.commentDislike += 1;
                    model.isSetDiscmtLike = YES;
                    model.isSetCmtLike = NO;
                    [weakSelf.dataArray replaceObjectAtIndex:btn.tag - 100 withObject:model];
                    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:btn.tag - 100 inSection:0];
                    [weakSelf.cache setObject:self.dataArray forKey:[NSString stringWithFormat:@"picGroupDetail%@",self.groupId] withBlock:^{
                        
                    }];
                    [weakSelf.commentTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                }
            }];
        }else{//不能给自己点赞
            [commonTools showBriefAlert:@"不能踩自己的评论"];
        }
    }else{
        [commonTools showBriefAlert:@"不能踩自己的评论"];
    }
    
    
}
- (void)cmtLikeBtnClick:(UIButton *)btn{
   
    
    PicGroupCommentModel *model = self.dataArray[btn.tag-1000];
    
 
    if (model.commentId != 999999999) {
        myWeakSelf;
        if (model.userId != userID) {
            [PicGroupDetailRequest requestAddCommentLike:[NSNumber numberWithInt:model.commentId] commentLike:@1 groupId:model.groupId cmtUserId:model.userId commentDislike:@0 resBlock:^(BOOL isSuccess) {
                if (isSuccess) {
                    [commonTools showBriefAlert:@"点赞成功"];
                    model.commentLike += 1;
                    model.isSetCmtLike = YES;
                    model.isSetDiscmtLike = NO;
                    [weakSelf.dataArray replaceObjectAtIndex:btn.tag - 1000 withObject:model];
                    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:btn.tag - 1000 inSection:0];
                    [weakSelf.commentTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                    [weakSelf.cache setObject:weakSelf.dataArray forKey:[NSString stringWithFormat:@"picGroupDetail%@",self.groupId] withBlock:^{
                        
                    }];

                }
            }];
        }else{//不能给自己点赞
            [commonTools showBriefAlert:@"不能踩自己的评论"];
        }
    } else {
        [commonTools showBriefAlert:@"不能给自己评论点赞"];
    }
}

- (void)addfloatBackButton{

    //初始化赞btn
    if (self.zanBtn == nil) {
        self.zanBtn =[[CatZanButton alloc] init];
    }
    self.zanBtn.frame =  CGRectMake(IPHONE_WIDTH*0.8, IPHONE_HEIGHT*0.70, SPW(50), SPW(50));
    if (IPHONE_WIDTH>540) {
        self.zanBtn.frame =  CGRectMake(IPHONE_WIDTH*0.85, IPHONE_HEIGHT*0.75, SPW(30), SPW(30));
    }
    [self.view addSubview:self.zanBtn];
    
    //判断缓存里是否存有点赞的状态
    if ([self.cache containsObjectForKey:[NSString stringWithFormat:@"picGroupDetailIsLike%@",self.groupId]]) {
        NSNumber *isLike = (NSNumber *)[self.cache objectForKey:[NSString stringWithFormat:@"picGroupDetailIsLike%@",self.groupId]];
        if ([isLike isEqualToNumber:@1]) {
            [self.zanBtn setIsZan:YES];
            self.zanBtn.enabled = NO;
        }else{
            [self.zanBtn setIsZan:NO];
            self.zanBtn.enabled = YES;
            [self zanBtnHandler:self.zanBtn];
        }
    } else {
        myWeakSelf;
        [PicGroupDetailRequest requestIsLikeExistGroupID:self.groupId isLike:^(BOOL isLike) {
            if (isLike) {
                [weakSelf.zanBtn setIsZan:YES];
                weakSelf.zanBtn.enabled = NO;
                [weakSelf.cache setObject:@1 forKey:[NSString stringWithFormat:@"picGroupDetailIsLike%@",weakSelf.groupId]];
            }else{
                [weakSelf.cache setObject:@0 forKey:[NSString stringWithFormat:@"picGroupDetailIsLike%@",weakSelf.groupId]];
                [weakSelf.zanBtn setType:CatZanButtonTypeFirework];
                [weakSelf zanBtnHandler:weakSelf.zanBtn];
            }
        }];

    }
}

- (void)zanBtnHandler:(CatZanButton *)zanBtn{
     myWeakSelf;
    [zanBtn setClickHandler:^(CatZanButton *zanButton) {
        if (zanButton.isZan) {
            //缓存赞的个数
            weakSelf.likeCount++;
            [weakSelf.cache setObject:[NSNumber numberWithInt:weakSelf.likeCount] forKey:[NSString stringWithFormat:@"picGroupDetailLikeCount%@",weakSelf.groupId]];
            //缓存已经点赞的状态
            [weakSelf.cache setObject:@1 forKey:[NSString stringWithFormat:@"picGroupDetailIsLike%@",weakSelf.groupId]];
            //同步到服务器
            [PicGroupDetailRequest requestLikeData:weakSelf.groupId titleDetailView:weakSelf.titleDetailView];
        }
    }];

}


//图片已经显示时调用
- (void)photosView:(PYPhotosView *)photosView didShowWithPhotos:(NSArray<PYPhoto *> *)photos index:(NSInteger)index{
    /*
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 40)];
    lab.backgroundColor = Red_COLOR;
    lab.text = @"哈哈哈哈哈哈";
   
    
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for(UIWindow * tmpWin in windows)
    {
        NSLog(@"%lf",tmpWin.windowLevel);
        if (tmpWin.windowLevel == 2000.000000) {
            [tmpWin addSubview:lab];
        }
    }
     */
    NSLog(@"已经显示%ld",index);
}
- (void)photosView:(PYPhotosView *)photosView didHiddenWithPhotos:(NSArray<PYPhoto *> *)photos index:(NSInteger)index{
    NSLog(@"已经隐藏%ld",index);
    
}


- (void)dealloc{
   
    self.titleDetailView = nil;
    self.commentTable = nil;
    self.headerView = nil;
    self.cache = nil;
    self.commentLab = nil;
    self.cmtBtn = nil;
    self.cmtTFBGView = nil;
    self.commentBGView = nil;
    self.imgUrls = nil;
    self.cmtTF = nil;
    self.zanBtn = nil;
    self.photosView = nil;
    NSLog(@"dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self.cache trimToCost:50556768];
    NSLog(@"内存警告");
}



@end
