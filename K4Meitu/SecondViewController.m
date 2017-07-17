//
//  SecondViewController.m
//  K4Meitu
//
//  Created by simpleem on 6/17/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "SecondViewController.h"
#import "Header.h"
#import "MainTabBarViewController.h"
#import "secPagePicGroupTypeVC.h"
#import "funcBtnListView.h"
#import "GroupKeywordModel.h"
#import "SDCycleScrollView.h"
#import <UIImageView+WebCache.h>
#import "SecPageVCRequest.h"
#import "SecPageHotCmtView.h"
#import "SecPageMaxRecordView.h"
@interface SecondViewController ()<funcBtnListDelegate,SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) funcBtnListView *funcBtnView;
@property (strong, nonatomic) NSMutableArray *funcBtnArray;
@property (strong, nonatomic) NSMutableArray *picUrlList;
@property (strong, nonatomic) NSMutableArray *maxRecordArray;
@property (strong, nonatomic) NSMutableArray *bannerADArray;
@property (strong, nonatomic) NSMutableArray *hotCmtArray;
@property (strong, nonatomic) SecPageHotCmtView *hotCommentView;
@property (strong, nonatomic) SDCycleScrollView *cycleScrollView;
@property (strong, nonatomic) SecPageMaxRecordView *maxRecordView;
@property (strong, nonatomic) UICollectionView *collection;

@property (strong, nonatomic) UIButton *bannerADBtn;

@property (strong, nonatomic) UIScrollView *scroll;


@end

@implementation SecondViewController

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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addStatusBlackBackground];
    self.view.backgroundColor = S_Light_Gray;
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(100, 600, 50, 50);
//    btn.backgroundColor = [UIColor lightGrayColor];
//    [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    [self initScrollView];
    [self initAdView];
    [self initFunctionBtnView];
    
    [SecPageVCRequest requestFromMenuBtnList:^(NSMutableArray *dataArr) {
        
    }];
}

- (void)initScrollView{
    if (self.scroll == nil) {
        self.scroll = [[UIScrollView alloc] init];
    }
    self.scroll.frame = CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT);
    self.scroll.showsVerticalScrollIndicator = NO;
    self.scroll.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scroll];
}

-(void)initAdView{
    
    if (self.picUrlList == nil) {
        self.picUrlList = [[NSMutableArray alloc] init];
    }
    for(int i=1; i<=4; i++){
        NSString *url = [NSString stringWithFormat:@"http://14.103.207.146:8081/project/11120171041/%d.jpg",i];
        
        [self.picUrlList addObject:url];
    }
    /************** 网络请求轮播 ****************/
    //网络加载 --- 创建带标题的图片轮播器
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, SPH(150)) delegate:self placeholderImage:[UIImage imageNamed:@"photo"]];
    self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.cycleScrollView.currentPageDotColor = [UIColor redColor];
    self.cycleScrollView.pageDotColor = [UIColor lightGrayColor];
    self.cycleScrollView.pageControlDotSize = CGSizeMake(8, 8);
    self.cycleScrollView.delegate = self;
    self.cycleScrollView.bannerImageViewContentMode = UIViewContentModeCenter;
    self.cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    self.cycleScrollView.autoScrollTimeInterval = 3.0;
    self.cycleScrollView.imageURLStringsGroup = self.picUrlList;
    //自定义分页控件小圆标颜色
    [self.scroll addSubview:self.cycleScrollView];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        myWeakSelf;
//        weakSelf.cycleScrollView.imageURLStringsGroup = weakSelf.picUrlList;
//    });
//
    
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
}

- (void)initFunctionBtnView{
    
    [SecPageVCRequest requestFromMenuBtnList:^(NSMutableArray *dataArr) {
        myWeakSelf;

        //取数据
        weakSelf.picUrlList = dataArr[0];
        weakSelf.funcBtnArray = dataArr[1];
        weakSelf.hotCmtArray = dataArr[2];
        weakSelf.maxRecordArray = dataArr[3];
        weakSelf.bannerADArray = dataArr[4];
        //menuBtn
        NSInteger row =  weakSelf.funcBtnArray.count%4!=0 ?
         weakSelf.funcBtnArray.count/4 + 1 :
         weakSelf.funcBtnArray.count/4;
        if (weakSelf.funcBtnView == nil) {
             weakSelf.funcBtnView = [[funcBtnListView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(weakSelf.cycleScrollView.frame)+5, IPHONE_WIDTH, 60*row) funcBtnList:weakSelf.funcBtnArray CountPerline:5];
        }

        weakSelf.funcBtnView.delegate = weakSelf;
        [weakSelf.scroll addSubview:weakSelf.funcBtnView];
        
        
        //scrollAD
        weakSelf.cycleScrollView.imageURLStringsGroup = weakSelf.picUrlList;
        
        //hotComment
        [weakSelf initHotCmtView:CGRectMake(0, CGRectGetMaxY(weakSelf.funcBtnView.frame)+5, IPHONE_WIDTH, 70) dataArr:weakSelf.hotCmtArray];

        //maxRecordView
        [weakSelf initMaxRecordView];
        
        //middleBannerImg
        GroupMenuBtnModel * model= nil;
        if (weakSelf.bannerADArray.count != 0) {
           model = weakSelf.bannerADArray[0];
        }
        weakSelf.bannerADBtn = [SecPageVCRequest midderBannerADviewFrame:CGRectMake(0, CGRectGetMaxY(weakSelf.maxRecordView.frame)+5, IPHONE_WIDTH, 70) imgUrl:model.titleImgUrl];
        [weakSelf.bannerADBtn addTarget:self action:@selector(bannerADBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [weakSelf.scroll addSubview:weakSelf.bannerADBtn];
        
        //collectionView
        [weakSelf initCollectionViewWithFrame:CGRectMake(0, CGRectGetMaxY(weakSelf.bannerADBtn.frame), IPHONE_WIDTH, 114*2+20)];
        
        
        weakSelf.scroll.contentSize = CGSizeMake(IPHONE_WIDTH, CGRectGetMaxY(weakSelf.collection.frame)+64);

    }];
    
    
}

//功能按钮的点击事件
- (void)funcBtnAction:(UIButton *)btn{
    
    GroupKeywordModel *model = self.funcBtnArray[btn.tag-1000];
    NSLog(@"点击了:%@",model.keyword);
    
}

- (void)bannerADBtnClick{
    NSLog(@"bannerAD");
}

- (void)initHotCmtView:(CGRect)frame dataArr:(NSMutableArray *)dataArr{
    
    self.hotCommentView  = [SecPageVCRequest hotCommentViewFrame:frame dataArr:dataArr];
    [self.hotCommentView.cmtBtn1 addTarget:self action:@selector(hotCmtBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.hotCommentView.cmtBtn1.tag = 101;
    [self.hotCommentView.cmtBtn2 addTarget:self action:@selector(hotCmtBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.hotCommentView.cmtBtn2.tag = 102;
    [self.scroll addSubview:self.hotCommentView];
}

- (void)hotCmtBtnClick:(UIButton *)btn{
    if (btn.tag == 101) {
        NSLog(@"101");
    }else{
        NSLog(@"102");
    }
}


- (void)initMaxRecordView{
    for (int i=0; i<2; i++) {
        for (int j=0; j<2; j++) {
            if (IPHONE_WIDTH <= 540) {
                self.maxRecordView = [SecPageVCRequest maxRecordViewFrame:CGRectMake(IPHONE_WIDTH/2*j, CGRectGetMaxY(self.hotCommentView.frame)+101*i+5, IPHONE_WIDTH/2-1, 100) dataModel:self.maxRecordArray[i*2 + j]];
                self.maxRecordView.btn.tag = 200 + i*2 + j;
                [self.maxRecordView.btn addTarget:self action:@selector(maxBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            }else{
                self.maxRecordView = [SecPageVCRequest maxRecordViewFrame:CGRectMake(IPHONE_WIDTH/4*(j+i*2), CGRectGetMaxY(self.hotCommentView.frame)+5, IPHONE_WIDTH/4-4, 124) dataModel:self.maxRecordArray[i*2 + j]];
                self.maxRecordView.btn.tag = 200 + i*2 + j;
                [self.maxRecordView.btn addTarget:self action:@selector(maxBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            }
            [self.scroll addSubview:self.maxRecordView];
        }
    }
    
}
- (void)maxBtnClick:(UIButton *)btn{
    NSLog(@"%ld",btn.tag-200);
}


- (void)btnclick{
    [self.navigationController pushViewController:[[secPagePicGroupTypeVC alloc] init] animated:YES];
}

- (void)initCollectionViewWithFrame:(CGRect)frame{
    //此处必须要有创见一个UICollectionViewFlowLayout的对象
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    //同一行相邻两个cell的最小间距
    layout.minimumInteritemSpacing = 5;
    //最小两行之间的间距
    layout.minimumLineSpacing = 5;
    
    self.collection=[[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
    self.collection.backgroundColor=[UIColor whiteColor];
    self.collection.delegate=self;
    self.collection.dataSource=self;
    //这个是横向滑动
    layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    [self.scroll addSubview: self.collection];
    
    UINib *cellNib=[UINib nibWithNibName:@"PicGroupCollectionCell" bundle:nil];
    [self.collection registerNib:cellNib forCellWithReuseIdentifier:@"colCell"];
}
//一共有多少个组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//每一组有多少个cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}
//每一个cell是什么
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"colCell" forIndexPath:indexPath];
    //cell.label.text=[NSString stringWithFormat:@"%ld",indexPath.section*100+indexPath.row];
    cell.backgroundColor=[UIColor groupTableViewBackgroundColor];
    return cell;
}
//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(114, 114);
}

//cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //cell被电击后移动的动画
    [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionTop];
    NSLog(@"%ld",indexPath.item);
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
