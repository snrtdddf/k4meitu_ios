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
#import "funcBtnModel.h"
#import "SDCycleScrollView.h"
#import <UIImageView+WebCache.h>
@interface SecondViewController ()<funcBtnListDelegate,SDCycleScrollViewDelegate>
@property (strong, nonatomic) funcBtnListView *funcBtnView;
@property (strong, nonatomic) NSMutableArray *funcBtnArray;
@property (strong, nonatomic) NSMutableArray *picUrlList;
@property (strong, nonatomic) SDCycleScrollView *cycleScrollView;

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
    [self initAdView];
    [self initFunctionBtnView];
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
    CGFloat w = self.view.bounds.size.width;
    //网络加载 --- 创建带标题的图片轮播器
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, IPHONE_HEIGHT*0.20) delegate:self placeholderImage:[UIImage imageNamed:@"photo"]];
    self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.cycleScrollView.currentPageDotColor = [UIColor redColor];
    self.cycleScrollView.pageDotColor = [UIColor lightGrayColor];
    self.cycleScrollView.pageControlDotSize = CGSizeMake(8, 8);
    self.cycleScrollView.delegate = self;
    self.cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    self.cycleScrollView.autoScrollTimeInterval = 3.0;
    self.cycleScrollView.imageURLStringsGroup = self.picUrlList;
    //自定义分页控件小圆标颜色
    [self.view addSubview:self.cycleScrollView];
    
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    //NSLog(@"---点击了第%ld张图片", (long)index);
}

- (void)initFunctionBtnView{
    
    if (self.funcBtnArray == nil) {
        self.funcBtnArray = [[NSMutableArray alloc]init];
    }
    for(int i=0; i<10; i++){
        funcBtnModel *model = [[funcBtnModel alloc]init];
        model.imgUrl = @"http://14.103.207.146:8081/project/11120171041/1.jpg";
        model.showTxt = @"性感";
        model.linkUrl = @"http://14.103.207.146:8081/project/11120171041/1.jpg";
        model.showOrder = [NSString stringWithFormat:@"%d",i];
        
        [self.funcBtnArray addObject:model];
    }
    NSInteger row = self.funcBtnArray.count%4!=0 ?
    self.funcBtnArray.count/4 + 1 :
    self.funcBtnArray.count/4;
    
    self.funcBtnView = [[funcBtnListView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.cycleScrollView.frame), IPHONE_WIDTH, IPHONE_HEIGHT*0.10*row) funcBtnList:self.funcBtnArray CountPerline:5];
    
    self.funcBtnView.delegate = self;
    [self.view addSubview:self.funcBtnView];
}
//功能按钮的点击事件
- (void)funcBtnAction:(UIButton *)btn{
    
    funcBtnModel *model = self.funcBtnArray[btn.tag-1000];
    
    
}
- (void)btnclick{
    [self.navigationController pushViewController:[[secPagePicGroupTypeVC alloc] init] animated:YES];
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
