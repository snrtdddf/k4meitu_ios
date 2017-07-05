//
//  PicGroupCommentModel.h
//  K4Meitu
//
//  Created by simpleem on 6/22/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PicGroupCommentModel : NSObject<NSCoding>

@property (nonatomic, assign) int commentId;
@property (nonatomic, assign) int isCmtShow;
@property (nonatomic, strong) NSString *groupId;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *imgComment;
@property (assign, nonatomic) int commentLike;
@property (assign, nonatomic) int commentDislike;
@property (nonatomic, strong) NSString *date;
@property (nonatomic) BOOL isSetCmtLike;
@property (nonatomic) BOOL isSetDiscmtLike;

@end

