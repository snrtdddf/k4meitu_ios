//
//  funcBtnModel.m
//  GoldWallet
//
//  Created by simpleem on 16/10/29.
//  Copyright © 2016年 China_Gold_Infomation. All rights reserved.
//

#import "funcBtnModel.h"

@implementation funcBtnModel
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"kid" : @"id",
             @"keyword" : @"keyword",
             @"searchCount" : @"searchCount",
             @"iconUrl" : @"iconUrl",
             @"date" : @"date"
            };
}
@end
