//
//  PicGroupDetailRequest.h
//  K4Meitu
//
//  Created by simpleem on 6/21/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^DataBlock)(NSMutableArray *dataArr);

@interface PicGroupDetailRequest : NSObject

+ (void)requestData:(NSString *)groupId dataBlock:(DataBlock)block;

+ (UIScrollView *)imgScrollView:(NSMutableArray *)imgUrls;
@end
