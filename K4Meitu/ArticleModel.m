//
//  ArticleModel.m
//  K4Meitu
//
//  Created by simpleem on 8/21/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "ArticleModel.h"

@implementation ArticleModel
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"cid" : @"id",
            };
}

@end
