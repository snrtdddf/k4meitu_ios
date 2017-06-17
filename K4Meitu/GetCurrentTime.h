//
//  GetCurrentTime.h
//  NSDateDemo
//
//  Created by qianfeng on 16/1/8.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM (NSInteger,TimeType)
{
    YYYY_MM_DD = 0,
    
    HH_MM_SS = 1,
    
    YYYY_MM_DD_and_HH_MM_SS = 2
    
};

@interface GetCurrentTime : NSObject

- (NSString *)GetTimeFromTimeStamp:(NSString *)timeStamp andReturnTimeType:(TimeType)TimeType;
- (NSString *)GetCurrentBeijingTimeandReturnTimeType:(TimeType)TimeType;

+ (NSString *)GetCurrentBeijingTimeandReturnTimeType:(TimeType)TimeType;

@end
