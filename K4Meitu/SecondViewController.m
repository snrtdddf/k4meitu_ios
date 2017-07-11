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
@interface SecondViewController ()

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
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
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
