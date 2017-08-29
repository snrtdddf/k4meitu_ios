//
//  SexySkillArticleRequest.h
//  K4Meitu
//
//  Created by simpleem on 8/25/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^dataBlock)(NSMutableArray *dataArr,NSInteger maxPage);

@interface SexySkillArticleRequest : NSObject
+ (void)requestType:(NSString *)type subType:(NSString *)subType CurPage:(int)curPage pCount:(int)pCount dataBlock:(dataBlock)block;
@end
