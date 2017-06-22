//
//  BaseViewController.h
//  GoldWallet
//
//  Created by simpleem on 16/7/11.
//  Copyright © 2016年 China_Gold_Infomation. All rights reserved.
//

#import <UIKit/UIKit.h>
//textField输入内容的类型

@interface BaseViewController : UIViewController
{
    UIImageView *_navBar;
    
}

@property (nonatomic, strong) NSMutableArray *dataArray;

//- (void)showTabBar;  //显示工具栏
//
//- (void)hiddenTabBar; //隐藏工具条


// 添加文字提示框
- (void)addActityText:(NSString *)text deleyTime:(float)times margin:(float)margin Yoffset:(float)Yoffset;

// 添加等待框
- (void)showActityHoldView;

// 隐藏
- (void)hiddenActityHoldView;

- (void)showAlertWithMessage:(NSString *)message;

//- (void)backBtnClick;
- (void)backButtonAction:(UIButton *)sender;

//解析请求字段，是否正常 _allowShow是否显示后台返回提示
//-(BOOL)resolveRetCode:(NSDictionary*)_dictionary showServerSucessMsg:(BOOL)_allowShow;

- (void)addStatusBlackBackground;//导航栏背景
- (void)addBackButton:(BOOL)sendNotification;//导航栏返回
- (void)addTitleWithName:(id)name wordNun:(int)num;//导航栏标题
- (void)addRightButtonWithName:(id)name wordNum:(int)num actionBlock:(void (^)(void))clickedAction;//导航栏右侧按钮
//左边关闭按钮
- (void)addLeftCloseBtnWithName:(id)name wordNum:(int)num;

@end
