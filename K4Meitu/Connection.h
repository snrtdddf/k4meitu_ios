//
//  Connection.h
//  GoldWallet
//
//  Created by simpleem on 16/7/27.
//  Copyright © 2016年 China_Gold_Infomation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "Header.h"
#import "MBManager.h"
#import <UIKit/UIKit.h>

typedef void(^Succeed)(NSData * data);
typedef void(^Failed)(NSError *error);

@interface Connection : NSObject

@property (nonatomic) BOOL isNetOK;
@property (nonatomic, strong) AppDelegate *myAPP;

+ (id)shareInstance;
- (void)GetTextURL:(NSString *)url parameters:(NSDictionary *)dict Success:(Succeed)isSucceed andFail:(Failed)isFailed;

- (void)PostTextURL:(NSString *)url parameters:(NSDictionary *)dict Success:(Succeed)isSucceed andFail:(Failed)isFailed  isIndicatorShow:(BOOL)isShow;



@end
