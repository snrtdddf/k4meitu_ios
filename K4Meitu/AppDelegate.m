//
//  AppDelegate.m
//  K4Meitu
//
//  Created by simpleem on 6/17/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "AppDelegate.h"
#import "LoadingViewController.h"
#import <IQKeyboardManager.h>
#import "SPUncaughtExceptionHandler.h"
#import "AFNetworking.h"
#import "Header.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //--------------------------启动时首先加载“启动页”----------------------
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    LoadingViewController *rooterVC = [[LoadingViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:rooterVC];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    //------------------------------------------------------------------
    //--------------------------网络状态检测------------------------------
    
    [UserDefaults removeObjectForKey:@"isNetReachable"];
    [UserDefaults synchronize];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown:
            {
                
                [UserDefaults setValue:@"NO" forKey:@"isNetReachable"];
                NSLog(@"isNetOK:Unknown");
                break;
            }
                
            case AFNetworkReachabilityStatusNotReachable:
            {
                NSLog(@"isNetOK:NotReachable");
                [UserDefaults setValue:@"NO" forKey:@"isNetReachable"];
                break;
            }
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
               NSLog(@"isNetOK:4G/3G");
                NSString *ipAddress = [GetIPAddress getIPAddress:YES];
                [UserDefaults setValue:@"YES" forKey:@"isNetReachable"];
                [UserDefaults setValue:ipAddress forKey:@"ipAddress"];
                [UserDefaults synchronize];
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                NSLog(@"isNetOK:WiFi");
                [UserDefaults setValue:@"YES" forKey:@"isNetReachable"];
                NSString *ipAddress = [GetIPAddress getIPAddress:YES];
                [UserDefaults setValue:ipAddress forKey:@"ipAddress"];
                [UserDefaults synchronize];
                break;
            }
                
            default:
                break;
        }
        
    }];
    //------------------------------------------------------------------
    
    
    //-----------------------IQKeyboardManager使用------------------------
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES; // 控制整个功能是否启用。
    manager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    manager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    manager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    manager.toolbarManageBehaviour = IQAutoToolbarByTag; // 最新版的设置键盘的returnKey的关键字 ,可以点击键盘上的next键，自动跳转到下一个输入框，最后一个输入框点击完成，自动收起键盘。
    //------------------------------------------------------------------
    
    
    InstallUncaughtExceptionHandler();//异常捕捉，防闪退
    

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
