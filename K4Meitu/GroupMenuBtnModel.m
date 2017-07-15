//
//  GroupMenuBtnModel.m
//  K4Meitu
//
//  Created by simpleem on 7/15/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "GroupMenuBtnModel.h"

@implementation GroupMenuBtnModel
/*
 id: 1,
 type: "funcBtn",
 groupId: "",
 title: "美臀",
 subTitle: "",
 content: null,
 titleImgUrl: "http://ys-k.ys168.com/342481687/nxqtxit7M3J565S5Q73/1.png",
 imgUrl1: "",
 imgUrl2: "",
 imgUrl3: "",
 imgUrl4: "",
 linkUrl: "",
 date: 1500084963000
 */
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"gid" : @"id",
             @"type" : @"type",
             @"groupId" : @"groupId",
             @"title" : @"title",
             @"subTitle" : @"subTitle",
             @"content" : @"content",
             @"titleImgUrl" : @"titleImgUrl",
             @"imgUrl1" : @"imgUrl1",
             @"imgUrl2" : @"imgUrl2",
             @"imgUrl3" : @"imgUrl3",
             @"imgUrl4" : @"imgUrl4",
             @"linkUrl" : @"linkUrl",
             @"date" : @"date",
             };
}
@end
