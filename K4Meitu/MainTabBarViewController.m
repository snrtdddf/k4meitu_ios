//
//  MainTabBarViewController.m
//  GoldWallet
//
//  Created by simpleem on 16/7/11.
//  Copyright © 2016年 China_Gold_Infomation. All rights reserved.
//
/*
 NSArray *normalArray    =   @[@"tab1_n",@"tab2_n",@"tab3_n"];
 NSArray *selectedArray  =   @[@"tab1_s",@"tab2_s",@"tab3_s"];
 */
#import "MainTabBarViewController.h"
#import "MainViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "Header.h"
#import "VersionedImage.h"


@interface MainTabBarViewController ()

@property (nonatomic,strong) UIImageView *tabbarBGV;//tabbar背景图

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    //初始化tabbar
    [self overWriteTabbar];
    //    //
    //    //   //初始化控制器
    [self initTabBarController];
    
    
    
    self.view.backgroundColor = RGBACOLOR(250, 251, 255, 1);
    
    self.hidesBottomBarWhenPushed = YES;
    
    
}




-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    // 删除系统自动生成的UItabButton
    for (UIView *child in self.tabBar.subviews)
    {
        if ([child isKindOfClass:[UIControl class]])
        {
            [child removeFromSuperview];
        }
    }
    
}


#pragma 初始化tabbar    －－重写
-(void)overWriteTabbar
{
    TabBar *customTabBar = [[TabBar alloc]init];
    customTabBar.frame = self.tabBar.bounds;
    //设置代理 ---  注意
    customTabBar.delegate = self;
    
   
    
    //在tabBar 添加自定义的视图
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
    
}


#pragma mark --- <MYTabBarDelegate>
-(void)tabBar:(TabBar *)bar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)destination
{
    self.selectedIndex = destination;
}

-(void)initTabBarController
{
    MainViewController *homeVC = [[MainViewController alloc]init];
    [self initTabBarViewController:homeVC title:@"首页" imageName:@"mainPage_unselect" selectedImageName:@"mainPage_select"];
    
    SecondViewController *secondVC = [[SecondViewController alloc]init];
    [self initTabBarViewController:secondVC title:@"分类" imageName:@"fansSay_unselect" selectedImageName:@"fansSay_select"];
    
    ThirdViewController *thirdVC = [[ThirdViewController alloc]init];
    [self initTabBarViewController:thirdVC title:@"夜色" imageName:@"shopping_un" selectedImageName:@"shopping_s"];
    
    FourthViewController *fourthVC = [[FourthViewController alloc]init];
    [self initTabBarViewController:fourthVC title:@"我的" imageName:@"me_unselect" selectedImageName:@"me_select"];
}


#pragma 初始化子控制器属性
-(void)initTabBarViewController:(UIViewController*)viewController title:(NSString*)title imageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName
{
    
    //1.设置控制器属性
    viewController.title = title;
    viewController.tabBarItem.image = [VersionedImage imageWithName:imageName];
    UIImage *selectedImage = [VersionedImage imageWithName:selectedImageName];
    
    if(iOS7)
    {
        viewController.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    else
    {
        viewController.tabBarItem.selectedImage = selectedImage;
    }
    
    //2.添加一个导航控制器控制子控制器
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:viewController];
    [self addChildViewController:navc];
    
    //3.将viewController中的tabBarItem添加到customTaBar中，使内部的按钮对应相应的tabBarItem
    [self.customTabBar addTabBarButtonWithItem:viewController.tabBarItem];
    
}



- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (UIViewController *)childViewControllerForStatusBarStyle{
    return nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    
    
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
