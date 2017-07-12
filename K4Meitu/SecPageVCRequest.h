//
//  SecPageVCRequest.h
//  K4Meitu
//
//  Created by simpleem on 7/12/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "funcBtnListView.h"
#import "SecPageHotCmtView.h"
typedef void(^DataBlock)(NSMutableArray *dataArr);

@interface SecPageVCRequest : NSObject

+ (void)requestFromKeywordList:(DataBlock)block;
+ (SecPageHotCmtView *)hotCommentViewFrame:(CGRect)frame;

@end
