//
//  GroupKeywordModel.h
//  K4Meitu
//
//  Created by simpleem on 7/15/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NSObject+YYModel.h>
@interface GroupKeywordModel : NSObject

@property (nonatomic, strong) NSString *kid;
@property (nonatomic, strong) NSString *keyword;
@property (nonatomic, strong) NSString *searchCount;
@property (nonatomic, strong) NSString *iconUrl;
@property (strong, nonatomic) NSString *date;

+ (NSDictionary *)modelCustomPropertyMapper;
@end
