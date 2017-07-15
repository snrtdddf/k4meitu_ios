//
//  Header.h
//  GoldWallet
//
//  Created by simpleem on 16/7/11.
//  Copyright © 2016年 China_Gold_Infomation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetIPAddress.h"
#import "Connection.h"
//*******************************网络请求相关宏**********************
//网络请求 上传图片的地址也要换

#define URLPrefix @"http://192.168.1.38:8080/pic/api.action?"


//渠道编号
#define APPCHANNEL @"iOS"

//ip地址
#define getIpAddress [UserDefaults valueForKey:@"ipAddress"]==nil?@"192.168.1.1":[UserDefaults valueForKey:@"ipAddress"] //正式环境中，在检测网络时将ip写入沙盒
//#define getIpAddress @"192.168.10.38"

//userId
#define userID [UserDefaults valueForKey:@"userID"]

//Channel&IP
#define ParamDictNeed  @"channel":APPCHANNEL,@"ip":getIpAddress
//请求结果dict
#define requestSuccess [resDict[@"success"] boolValue]
//weakself
#define myWeakSelf __weak __typeof(self)weakSelf = self
//Connection
#define myConnection Connection *connect = [Connection shareInstance]
//NSJsonSerilizaion
#define myJsonSerialization [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil]
//requestBlock
#define requestBlock success:(Succeed)succeed failed:(Failed)failed
//*****************************************************************

//*****************************系统配置*****************************
//判断是否已经登录过
#define logined [UserDefaults valueForKey:@"logined"]
//WhiteColor
#define White_COLOR [UIColor whiteColor]//白色
//ErrorMsg
#define ErrorMsg resDict[@"ErrorMsg"]
//*****************************************************************



//*******************************系统参数***************************
//系统版本
#define DEVICE_VERSION  [[UIDevice currentDevice].systemVersion floatValue]
// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

//设备判断宏
#define IS_Phone4S ([[UIScreen mainScreen]bounds].size.height == 480.0)
#define IS_Phone5S ([[UIScreen mainScreen]bounds].size.height == 568.0)
#define IS_Phone6 ([[UIScreen mainScreen]bounds].size.height == 667.0)
#define IS_Phone6S ([[UIScreen mainScreen]bounds].size.height == 667.0)
#define IS_Phone6_Plus ([[UIScreen mainScreen]bounds].size.height == 736.0)
//动态获取设备高度
#define IPHONE_HEIGHT [UIScreen mainScreen].bounds.size.height
//动态获取设备宽度
#define IPHONE_WIDTH [UIScreen mainScreen].bounds.size.width
#define SPW(WIDTH)  WIDTH/375.0*IPHONE_WIDTH
#define SPH(HEIGHT) HEIGHT/667.0*IPHONE_HEIGHT

#define SWIDTH self.frame.size.width
#define SHEIGHT self.frame.size.height

//*****************************************************************


//*******************************颜色********************************
#define Pink_COLOR [UIColor colorWithRed:255.f/255.f green:182.f/255.f blue:193.f/255.f alpha:1]//默认粉
#define Black_COLOR [UIColor colorWithRed:59.f/255.f green:66.f/255.f blue:72.f/255.f alpha:1]//默认黑
#define Gold_COLOR [UIColor colorWithRed:255.f/255.f green:165.f/255.f blue:44.f/255.f alpha:1]//默认金
#define S_Light_Gray [UIColor colorWithRed:248.f/255.f green:248.f/255.f blue:248.f/255.f alpha:1]//默认灰
#define Red_COLOR [UIColor colorWithRed:254.f/255.f green:90.f/255.f blue:61.f/255.f alpha:1]//默认红
#define White_COLOR [UIColor whiteColor]//白色
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define lightGray_Color [UIColor lightGrayColor]
#define btnGray_Color RGBACOLOR(191,191,191,1)//btn灰
#define Line_COLOR [UIColor colorWithRed:229.f/255.f green:232.f/255.f blue:239.f/255.f alpha:1] //分割线颜色
//****************************************************************


//系统单例
#define UserDefaults  [NSUserDefaults standardUserDefaults]
#define NotificationCenter  [NSNotificationCenter defaultCenter]
#define SharedApplication  [UIApplication sharedApplication]
//#define APPDelegate     [[UIApplication sharedApplication] delegate]
#define FileManager [NSFileManager defaultManager]
#define myAppDelegate [[UIApplication sharedApplication] delegate]


#define MYMARGIN    10
#define MYAFTERDELAY   1

@interface Header : NSObject




@end
