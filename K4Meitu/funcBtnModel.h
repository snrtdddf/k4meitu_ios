//
//  funcBtnModel.h
//  GoldWallet
//
//  Created by simpleem on 16/10/29.
//  Copyright © 2016年 China_Gold_Infomation. All rights reserved.
//id, img, showTxt, openMethod, showOrder, createDate

#import <Foundation/Foundation.h>

@interface funcBtnModel : NSObject

@property (nonatomic, strong) NSData *imageData;
@property (nonatomic, strong) NSString *showTxt;
@property (nonatomic, strong) NSString *linkUrl;
@property (nonatomic, strong) NSString *showOrder;
@property (nonatomic, strong) NSString *imgUrl;

@end
