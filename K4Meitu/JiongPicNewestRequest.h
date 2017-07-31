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

@interface JiongPicNewestRequest : NSObject

+ (void)requestCurPage:(int)curPage dataBlock:(dataBlock)block;
+ (JiongPicNewestCell *)JiongCell:(JiongPicNewestCell *)cell dataArr:(JiongPicNewestModel *)model;
@end
