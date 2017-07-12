//
//  funcBtnModel.h
//  GoldWallet
//
//  Created by simpleem on 16/10/29.
//  Copyright © 2016年 China_Gold_Infomation. All rights reserved.
//id, img, showTxt, openMethod, showOrder, createDate

#import <Foundation/Foundation.h>
#import <NSObject+YYModel.h>
@interface funcBtnModel : NSObject

@property (nonatomic, strong) NSString *kid;
@property (nonatomic, strong) NSString *keyword;
@property (nonatomic, strong) NSString *searchCount;
@property (nonatomic, strong) NSString *iconUrl;
@property (strong, nonatomic) NSString *date;

+ (NSDictionary *)modelCustomPropertyMapper;
@end
