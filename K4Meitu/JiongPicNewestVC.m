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
@interface JiongPicNewestVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *picTable;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, assign) int curPage;
@property (nonatomic, assign) int maxPage;
@end

@implementation JiongPicNewestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackButton:NO];
    [self addStatusBlackBackground];
    [self addTitleWithName:@"今日囧图" wordNun:4];
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
    
    if (self.dataArray == nil) {
        self.dataArr = [[NSMutableArray alloc] init];
    }

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
        weakSelf.dataArr = dataArr;
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
    cell = [JiongPicNewestRequest JiongCell:cell dataArr:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
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
