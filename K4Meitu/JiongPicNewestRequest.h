//
//  JiongPicNewestRequest.h
//  K4Meitu
//
//  Created by simpleem on 7/27/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JiongPicNewestCell.h"
#import "JiongPicNewestModel.h"
typedef void(^dataBlock)(NSMutableArray *dataArr,NSInteger maxPage);
typedef void(^addLikeBlock)(BOOL isSuccess);

@interface JiongPicNewestRequest : NSObject

+ (void)requestCurPage:(int)curPage dataBlock:(dataBlock)block;
+ (JiongPicNewestCell *)JiongCell:(JiongPicNewestCell *)cell dataArr:(JiongPicNewestModel *)model IndexPath:(NSIndexPath *)indexPath;
+ (void)requestAddLikeOrDislikeData:(NSNumber *)Gid like:(NSNumber *)like dislike:(NSNumber *)dislike groupId:(NSString *)groupId addLikeBlock:(addLikeBlock)block;


@end
