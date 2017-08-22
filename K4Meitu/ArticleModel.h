//
//  ArticleModel.h
//  K4Meitu
//
//  Created by simpleem on 8/21/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleModel : NSObject

@property (assign, nonatomic) int cid;
@property (strong, nonatomic) NSString *groupId;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *subType;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *preContent;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *imgUrl;
@property (strong, nonatomic) NSString *linkUrl;
@property (assign, nonatomic) int browseCount;
@property (assign, nonatomic) int shareCount;
@property (assign, nonatomic) int likeCount;
@property (assign, nonatomic) int dislikeCount;
@property (assign, nonatomic) int commentCount;
@property (nonatomic, strong) NSString *date;
+ (NSDictionary *)modelCustomPropertyMapper;
@end
