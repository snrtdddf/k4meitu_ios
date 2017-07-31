//
//  JiongPicNewestModel.h
//  K4Meitu
//
//  Created by simpleem on 7/27/17.
//  Copyright © 2017 YangLei. All rights reserved.
//



#import <Foundation/Foundation.h>
@interface JiongPicNewestModel : NSObject
@property (nonatomic, strong) NSString *groupId;
@property (nonatomic, strong) NSString *Title;
@property (nonatomic, assign) int count;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *imgCoverName;
@property (nonatomic, assign) int imgCoverHeight;
@property (nonatomic, assign) int imgCoverWidth;
@property (assign, nonatomic) int likeCount;
@property (assign, nonatomic) int dislikeCount;
@property (assign, nonatomic) int cmtCount;
@property (assign, nonatomic) int browseCount;
@property (assign, nonatomic) int shareCount;
@property (assign, nonatomic) int score;
+ (NSDictionary *)modelCustomPropertyMapper;
@end
