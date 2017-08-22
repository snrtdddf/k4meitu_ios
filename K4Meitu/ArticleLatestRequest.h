//
//  ArticleLatestRequest.h
//  K4Meitu
//
//  Created by simpleem on 8/21/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^dataBlock)(NSMutableArray *dataArr,NSInteger maxPage);

@interface ArticleLatestRequest : NSObject

+ (void)requestCurPage:(int)curPage pCount:(int)pCount dataBlock:(dataBlock)block;

@end
