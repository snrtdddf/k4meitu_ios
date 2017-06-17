//
//  LoadingViewController.m
//  K4Meitu
//
//  Created by simpleem on 6/17/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "LoadingViewController.h"
#import "MainViewController.h"
#import "MainTabBarViewController.h"
@interface LoadingViewController ()

@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    MainTabBarViewController *rooterVC = [[MainTabBarViewController alloc]init];
    UINavigationController *rooterNav = [[UINavigationController alloc]initWithRootViewController:rooterVC];
    [UIApplication sharedApplication].keyWindow.rootViewController = rooterNav;
    MainViewController *VC = [[MainViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];

    
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
