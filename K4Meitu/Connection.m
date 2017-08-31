//
//  Connection.m
//  GoldWallet
//
//  Created by simpleem on 16/7/27.
//  Copyright © 2016年 China_Gold_Infomation. All rights reserved.
//

#import "Connection.h"
#import "AFNetworking.h"
#import "LGAlertView.h"
#import "RequestManager.h"
#import "FMDB.h"
#import "SDImageCache.h"
#import "commonTools.h"
#import "MBProgressHUD.h"
#import <UIKit/UIKit.h>

//typedef void (^TextResult)(NSProgress *downloadProgress, id response, NSError *err);

@implementation Connection


{
    AFHTTPSessionManager * _manager;
}

+ (id)shareInstance
{
    static dispatch_once_t onceToken;
    static Connection * connect = nil;
    
    dispatch_once(&onceToken, ^{
        connect = [[Connection alloc] init];
    });
    
    return connect;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _manager = [AFHTTPSessionManager manager];
        
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [_manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    }
    return self;
}

- (void)GetTextURL:(NSString *)url parameters:(NSDictionary *)dict Success:(Succeed)isSucceed andFail:(Failed)isFailed
{

    self.isNetOK = [[UserDefaults valueForKey:@"isNetReachable"] boolValue];
    if (self.isNetOK) {
        [MBManager showLoading];
        // 设置超时时间
        [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _manager.requestSerializer.timeoutInterval = 10.f;
        [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        [_manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [_manager GET:url parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            isSucceed(responseObject);
           [MBManager hideAlert];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            isFailed(error);
        }];
    }else{
        [MBManager showBriefAlert:@"网络连接失败，请检查网络连接"];
    }
    
    
}

- (void)PostTextURL:(NSString *)url parameters:(NSDictionary *)dict Success:(Succeed)isSucceed andFail:(Failed)isFailed  isIndicatorShow:(BOOL)isShow
{
     AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //app.window.rootViewController
    MBProgressHUD *hud = nil;
   
    
    self.isNetOK = [[UserDefaults valueForKey:@"isNetReachable"] boolValue];
    
    if (self.isNetOK) {
        if (isShow) {
            //[MBManager showLoading];
            [MBProgressHUD hideHUDForView:app.window.rootViewController.view animated:NO];
            MBProgressHUD *hud = nil;
            hud = [MBProgressHUD showHUDAddedTo:app.window.rootViewController.view animated:NO];
            [hud hide:YES afterDelay:8];
        }
        // 设置超时时间
        [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _manager.requestSerializer.timeoutInterval = 10.f;
        [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        //请求
        [_manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [_manager POST:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (isShow) {
               // [MBManager hideAlert];
                [MBProgressHUD hideHUDForView:app.window.rootViewController.view animated:YES];
                [hud removeFromSuperview];
            }
            
            isSucceed(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            isFailed(error);
        }];
        
    } else {
        [MBManager showBriefAlert:@"网络连接失败，请检测网络连接"];
    }
}

-(void) hideHUD:(MBProgressHUD*) progress {
    __block MBProgressHUD* progressC = progress;
    dispatch_async(dispatch_get_main_queue(), ^{
        [progressC hide:YES];
        progressC = nil;
    });
}

@end
