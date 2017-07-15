//
//  GroupKeywordModel.m
//  K4Meitu
//
//  Created by simpleem on 7/15/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "GroupKeywordModel.h"

@implementation GroupKeywordModel
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"kid" : @"id",
             @"keyword" : @"keyword",
             @"searchCount" : @"searchCount",
             @"iconUrl" : @"iconUrl",
             @"date" : @"date"
             };
}
@end
