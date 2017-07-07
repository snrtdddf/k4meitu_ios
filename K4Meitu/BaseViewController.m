//
//  BaseViewController.m
//  GoldWallet
//
//  Created by simpleem on 16/7/11.
//  Copyright © 2016年 China_Gold_Infomation. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"
#import "Header.h"


@interface BaseViewController ()
{
    void(^cacheBlock)(void);
}

@end

@implementation BaseViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置导航栏字体及颜色
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
//       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //设置状态栏字体颜色为白色
    //self.title = @"首页";
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *views = self.navigationController.navigationBar.subviews;
    
    for (UIView *view in views) {
        if (view.tag == 1001) {
            [view setHidden:YES];
            break;
        }
    }

   
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    // 防止从别的界面pop回来的时候菊花没有消失
    [self hiddenActityHoldView];
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    for (UIView *view in self.navigationController.navigationBar.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            if (view.tag == 2001) {
                [view removeFromSuperview];
            }
        }
    }
}

- (void)addActityText:(NSString *)text deleyTime:(float)times margin:(float)margin Yoffset:(float)Yoffset;
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window.rootViewController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    //    hud.color = RGBACOLOR(253, 165, 86, 1);
    hud.detailsLabelText = text;
    hud.detailsLabelFont = [UIFont systemFontOfSize:15.0f];
    hud.margin = margin;
    hud.cornerRadius = 3;
    hud.yOffset = Yoffset;
    [hud hide:YES afterDelay:times];
}

//等待框
- (void)showActityHoldView
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"请稍候...";
    
}

- (void)hiddenActityHoldView
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

//创建提示框
- (void)showAlertWithMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

//增加状态栏黑色背景
- (void)addStatusBlackBackground{

    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = Black_COLOR;//RGBACOLOR(0, 2, 43, 1);//;//
    //self.view.backgroundColor = RGBACOLOR(242, 242, 242, 1);
    
    //标题白色
    UIColor * color = [UIColor whiteColor];
    
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
}

//导航栏返回按钮
- (void)addBackButton:(BOOL)sendNotification{
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftButton setImage:[UIImage imageNamed:@"BackButton.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    if (sendNotification) {
        [NotificationCenter postNotificationName:@"BackButtonNotification" object:nil];
    }
}

- (void)backButtonAction:(UIButton *)sender{
    //[NotificationCenter postNotificationName:@"leftbutton" object:nil];
    //    [NotificationCenter postNotificationName:@"lastdata" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
//导航栏右侧按钮
- (void)addRightButtonWithName:(id)name wordNum:(int)num actionBlock:(void (^)(void))clickedAction{
    cacheBlock = clickedAction;
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, num*20, 20)];

    if ([name isKindOfClass:[NSString class]]) {
        [rightButton setTitle:name forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    if ([name isKindOfClass:[UIImage class]]) {
        [rightButton setImage:name forState:UIControlStateNormal];
    }
    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton addTarget:self action:@selector(rightButtonDownAction:) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
}
- (void)rightButtonAction:(UIButton *)sender{
    sender.alpha = 1.0;
    cacheBlock();
}
- (void)rightButtonDownAction:(UIButton *)sender{
    sender.alpha = 0.6;
}
//导航栏左侧关闭按钮
- (void)addLeftCloseBtnWithName:(id)name wordNum:(int)num{
    UIButton *leftCloseButton = nil;
    leftCloseButton = [[UIButton alloc] initWithFrame:CGRectMake(50/375.0*IPHONE_WIDTH, 12, num*20, 20)];
    leftCloseButton.tag = 2001;
    if ([name isKindOfClass:[NSString class]]) {
        [leftCloseButton setTitle:name forState:UIControlStateNormal];
        [leftCloseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    if ([name isKindOfClass:[UIImage class]]) {
        [leftCloseButton setImage:name forState:UIControlStateNormal];
    }
    [leftCloseButton addTarget:self action:@selector(leftCloseButtonAction) forControlEvents:UIControlEventTouchUpInside];
  
    [self.navigationController.navigationBar addSubview:leftCloseButton];
    [self.navigationController.navigationBar bringSubviewToFront:leftCloseButton];
}

- (void)leftCloseButtonAction{
 
}

//导航栏标题
- (void)addTitleWithName:(id )name wordNun:(int)num{
    if ([name isKindOfClass:[NSString class]]) {
        self.navigationItem.title = name;
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    }
    if ([name isKindOfClass:[UIImage class]]) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 27/2*num, 23)];//初始化图片视图控件
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = name;
        self.navigationItem.titleView = imageView;//设置导航栏的titleView为imageView
    }
    if ([name isKindOfClass:[UIButton class]]) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0.0f, 0.0f, 27/2*num, 30);
        btn.contentMode = UIViewContentModeScaleAspectFit;
        btn = name;
        self.navigationItem.titleView = btn;
    }
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
