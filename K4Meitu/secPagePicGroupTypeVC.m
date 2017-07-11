//
//  secPagePicGroupTypeVC.m
//  K4Meitu
//
//  Created by simpleem on 7/10/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "secPagePicGroupTypeVC.h"
#import "Header.h"
#import "MainTabBarViewController.h"
@interface secPagePicGroupTypeVC ()

@end

@implementation secPagePicGroupTypeVC
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
    
    [self renderUI];
}
- (NSDictionary *)getPageConfigInfo{
    NSDictionary *configInfo = @{
                                 @"topViewBgColor":@"#FFFFFF",
                                 @"maskColor":@"#FEEDB1",
                                 @"dataArray":@[@{
                                                    @"itemType":@2,
                                                    @"title":@"推荐",
                                                    @"normalTitleColor":@"#666666",
                                                    @"selectTitleColor":@"#3d3d3d",
                                                    @"normalIconName":@"home_unselect",
                                                    @"selectIconName":@"home_select",
                                                    @"vcName":@"SecPageVC1"
                                                    },
                                                @{
                                                    @"itemType":@2,
                                                    @"title":@"旅行机票",
                                                    @"normalTitleColor":@"#666666",
                                                    @"selectTitleColor":@"#3d3d3d",
                                                    @"normalIconName":@"flight_unselect",
                                                    @"selectIconName":@"flight_select",
                                                    @"vcName":@"SecPageVC2"
                                                    },
                                                @{
                                                    @"itemType":@2,
                                                    @"title":@"签证",
                                                    @"normalTitleColor":@"#666666",
                                                    @"selectTitleColor":@"#3d3d3d",
                                                    @"normalIconName":@"visa_unselect",
                                                    @"selectIconName":@"visa_select",
                                                    @"vcName":@"SecPageVC3"
                                                    },
                                                @{
                                                    @"itemType":@2,
                                                    @"title":@"酒店",
                                                    @"normalTitleColor":@"#666666",
                                                    @"selectTitleColor":@"#3d3d3d",
                                                    @"normalIconName":@"hotel_unselect",
                                                    @"selectIconName":@"hotel_select",
                                                    @"vcName":@"SecPageVC4"
                                                    },
                                                @{
                                                    @"itemType":@2,
                                                    @"title":@"租车包车",
                                                    @"normalTitleColor":@"#666666",
                                                    @"selectTitleColor":@"#3d3d3d",
                                                    @"normalIconName":@"car_unselect",
                                                    @"selectIconName":@"car_select",
                                                    @"vcName":@"SecPageVC5"
                                                    }
                                                ]
                                 };
    return configInfo;
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
