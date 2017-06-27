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
#import "RequestManager.h"
#import "Header.h"
#import "commonTools.h"
@interface LoadingViewController ()
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [NSTimer scheduledTimerWithTimeInterval:1.0F repeats:NO block:^(NSTimer * _Nonnull timer) {
//        
//        if (userID == nil) {
//            [self registerUser];
//            NSLog(@"用户不存在，正在注册");
//        }else{
//            [self loginUser];
//            NSLog(@"正在登录");
//        }
//        
//        
//        
//        MainTabBarViewController *rooterVC = [[MainTabBarViewController alloc]init];
//        UINavigationController *rooterNav = [[UINavigationController alloc]initWithRootViewController:rooterVC];
//        [UIApplication sharedApplication].keyWindow.rootViewController = rooterNav;
//        MainViewController *VC = [[MainViewController alloc] init];
//        [self.navigationController pushViewController:VC animated:YES];
//        [timer invalidate];
//    }];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerClick) userInfo:nil repeats:NO];
    
    
}

- (void)timerClick{
    
    if (userID == nil) {
        [self registerUser];
        NSLog(@"用户不存在，正在注册");
    }else{
        [self loginUser];
        NSLog(@"正在登录");
    }
    
    
    
    MainTabBarViewController *rooterVC = [[MainTabBarViewController alloc]init];
    UINavigationController *rooterNav = [[UINavigationController alloc]initWithRootViewController:rooterVC];
    [UIApplication sharedApplication].keyWindow.rootViewController = rooterNav;
    MainViewController *VC = [[MainViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    [self.timer invalidate];
    self.timer = nil;

}

- (void)registerUser{
    [RequestManager registerUser:^(NSData *data) {
        NSDictionary *resDict = myJsonSerialization;
        NSLog(@"%@",resDict);
        [commonTools HideActivityIndicator];
        if ([resSuccess boolValue]) {
            NSString *uId = resDict[@"res"][@"userInfo"][@"userId"];
            [UserDefaults setValue:uId forKey:@"userID"];
        }
        
    } failed:^(NSError *error) {
        
    }];
    
}

- (void)loginUser{
    [RequestManager userLogin:^(NSData *data) {
        NSDictionary *resDict = myJsonSerialization;
        NSLog(@"%@",resDict);
        [commonTools HideActivityIndicator];
        if ([resSuccess boolValue]) {
            
        }
    } failed:^(NSError *error) {
        
    }];
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
