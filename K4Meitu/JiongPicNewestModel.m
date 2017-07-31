//
//  JiongPicNewestModel.m
//  K4Meitu
//
//  Created by simpleem on 7/27/17.
//  Copyright © 2017 YangLei. All rights reserved.
//
/*
 @property (nonatomic, strong) NSString *groupId;
 @property (nonatomic, strong) NSString *Title;
 @property (nonatomic, assign) int count;
 @property (nonatomic, strong) NSString *type;
 @property (nonatomic, strong) NSString *imgUrl;
 @property (nonatomic, strong) NSString *date;
 @property (nonatomic, strong) NSString *imgCoverName;
 @property (nonatomic, assign) int imgCoverHeight;
 @property (nonatomic, assign) int imgCoverWidth;
 @property (strong, nonatomic) NSNumber *likeCount;
 @property (strong, nonatomic) NSNumber *dislikeCount;
 @property (strong, nonatomic) NSNumber *cmtCount;
 @property (strong, nonatomic) NSNumber *browseCount;
 @property (strong, nonatomic) NSNumber *shareCount;
 @property (strong, nonatomic) NSNumber *score;
 
 @"groupId" : @"title",
 @"Title" : @"count",
 @"subTitle" : @"type",
 @"content" : @"imgUrl",
 @"titleImgUrl" : @"date",
 @"imgUrl1" : @"imgCoverName",
 @"imgUrl2" : @"imgCoverHeight",
 @"imgUrl3" : @"imgCoverWidth",
 @"imgUrl4" : @"likeCount",
 @"linkUrl" : @"dislikeCount",
 @"date" : @"cmtCount",
 @"date" : @"browseCount",
 @"date" : @"shareCount",
 @"date" : @"score",

 */
#import "JiongPicNewestModel.h"

@implementation JiongPicNewestModel
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"groupId" : @"groupId",
             @"Title" : @"title",
             @"count" : @"count",
             @"type" : @"type",
             @"imgUrl" : @"imgUrl",
             @"date" : @"date",
             @"imgCoverName" : @"imgCoverName",
             @"imgCoverHeight" : @"imgCoverHeight",
             @"imgCoverWidth" : @"imgCoverWidth",
             @"likeCount" : @"likeCount",
             @"dislikeCount" : @"dislikeCount",
             @"cmtCount" : @"cmtCount",
             @"browseCount" : @"browseCount",
             @"shareCount" : @"shareCount",
             @"score" : @"score"
             };
}
@end
