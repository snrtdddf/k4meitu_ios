//
//  SecPageVC1.m
//  K4Meitu
//
//  Created by simpleem on 7/6/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "SecPageVC1.h"
#import "Header.h"
#import "ThirdTujianCell.h"
#import "ThirdTujianMutiPicCell.h"
#import "ArticleLatestRequest.h"
#import "ArticleModel.h"
#import "commonTools.h"
#import "ArticleLatestDetailVC.h"
#import "MJRefresh.h"
@interface SecPageVC1 ()<UITableViewDelegate,UITableViewDataSource>



@end

@implementation SecPageVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initTableView];
    [self requestData];
    [self refreshData];
}

- (void)initTableView{
    
    if (self.scroll == nil) {
        self.scroll = [[UIScrollView alloc] init];
    }
    self.scroll.frame = CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT);
    self.scroll.showsVerticalScrollIndicator = NO;
    self.scroll.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scroll];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"ThirdTujianCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ThirdTujianMutiPicCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [self.scroll addSubview:self.tableView];
    
    self.scroll.contentSize = CGSizeMake(IPHONE_WIDTH, CGRectGetMaxY(self.tableView.frame)+172);
    
    if (self.dataArr == nil) {
        self.dataArr = [[NSMutableArray alloc] init];
    }
}

- (void)refreshData{
    myWeakSelf;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.curPage++;
        if (weakSelf.curPage < weakSelf.maxPage) {
            [weakSelf requestData];
            [weakSelf.tableView.mj_footer endRefreshing];
        }else{
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    }];
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        [weakSelf.tableView.mj_header endRefreshing];
        weakSelf.curPage = 0;
        [weakSelf.dataArr removeAllObjects];
        [weakSelf requestData];
    }];

}

- (void)requestData{
    
    myWeakSelf;
    [ArticleLatestRequest requestCurPage:self.curPage pCount:10 dataBlock:^(NSMutableArray *dataArr, NSInteger maxPage) {
        for (ArticleModel *model in dataArr) {
            [weakSelf.dataArr addObject:model];
        }
        weakSelf.maxPage = (int)maxPage;
        
        [weakSelf.tableView reloadData];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ArticleModel *model = self.dataArr[indexPath.row];
    NSArray *imgs = [model.imgUrl componentsSeparatedByString:@"||"];
    if (imgs.count < 3) {
        return 100;
    }else{
        return 145;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ArticleModel *model = self.dataArr[indexPath.row];
    NSArray *imgs = [model.imgUrl componentsSeparatedByString:@"||"];
    if (imgs.count < 3) {
        ThirdTujianCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[ThirdTujianCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        NSString *str = model.title;
        NSString *imgurl =[imgs[0] componentsSeparatedByString:@"("][0];
        [commonTools sd_setImg:cell.img imgUrl:imgurl placeHolderImgName:@"photo"];
        cell.Title.text = [str stringByAppendingString:@"\n\n"];
        
        return cell;

    }else{
        ThirdTujianMutiPicCell *mutiPicCell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (mutiPicCell == nil) {
            mutiPicCell = [[ThirdTujianMutiPicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        }
        NSString *str = model.title;
        
        mutiPicCell.Title.text = [str stringByAppendingString:@"\n"];
        
        mutiPicCell.img_1.frame = CGRectMake(IPHONE_WIDTH<=375?8:(IPHONE_WIDTH-119*3)/2, CGRectGetMaxY(mutiPicCell.Title.frame)+10,  IPHONE_WIDTH<=375?(IPHONE_WIDTH-18)/3:118, 75);
        NSString *img_1_url = [imgs[0] componentsSeparatedByString:@"("][0];
        [commonTools sd_setImg:mutiPicCell.img_1 imgUrl:img_1_url placeHolderImgName:@"photo"];
        mutiPicCell.img_1.contentMode = UIViewContentModeScaleToFill;
        
        mutiPicCell.img_2.frame = CGRectMake(CGRectGetMaxX(mutiPicCell.img_1.frame)+1, CGRectGetMaxY(mutiPicCell.Title.frame)+10,  IPHONE_WIDTH<=375?(IPHONE_WIDTH-18)/3:118, 75);
        NSString *img_2_url = [imgs[1] componentsSeparatedByString:@"("][0];
        [commonTools sd_setImg:mutiPicCell.img_2 imgUrl:img_2_url placeHolderImgName:@"photo"];
         mutiPicCell.img_2.contentMode = UIViewContentModeScaleToFill;
        
        mutiPicCell.img_3.frame = CGRectMake(CGRectGetMaxX(mutiPicCell.img_2.frame)+1, CGRectGetMaxY(mutiPicCell.Title.frame)+10,  IPHONE_WIDTH<=375?(IPHONE_WIDTH-18)/3:118, 75);
        NSString *img_3_url = [imgs[2] componentsSeparatedByString:@"("][0];
        [commonTools sd_setImg:mutiPicCell.img_3 imgUrl:img_3_url placeHolderImgName:@"photo"];
         mutiPicCell.img_3.contentMode = UIViewContentModeScaleToFill;
        return mutiPicCell;

    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ArticleModel *model = self.dataArr[indexPath.row];
    ArticleLatestDetailVC *vc = [[ArticleLatestDetailVC alloc] init];
    vc.articleModel = model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)dealloc{
    NSLog(@"controller-(推荐)-已经释放");
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
