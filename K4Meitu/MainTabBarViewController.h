//
//  MainTabBarViewController.h
//  GoldWallet
//
//  Created by simpleem on 16/7/11.
//  Copyright © 2016年 China_Gold_Infomation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBar.h"
@interface MainTabBarViewController : UITabBarController<TabBarDelegate>

@property (nonatomic,strong) TabBar *customTabBar;

@end
