//
//  GetCurrentTime.m
//  NSDateDemo
//
//  Created by qianfeng on 16/1/8.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import "GetCurrentTime.h"


@implementation GetCurrentTime

+(NSString *)GetTimeFromTimeStamp:(NSString *)timeStamp andReturnTimeType:(TimeType)TimeType
{
 
    NSUInteger date = [timeStamp longLongValue];
    NSDate *bjDate = [NSDate dateWithTimeIntervalSince1970:[timeStamp longLongValue]];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if ([timeStamp longLongValue]/9999999999 > 0){
        bjDate = [NSDate dateWithTimeIntervalSince1970:date/1000];
    }else{
         bjDate = [NSDate dateWithTimeIntervalSince1970:date];
    }
    //NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:timeZone];
        
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
    NSString *Time = [dateFormatter stringFromDate:bjDate];
    
    NSString *Year = [Time componentsSeparatedByString:@" "][0];
    NSString *Hour = [Time componentsSeparatedByString:@" "][1];
    if (TimeType == YYYY_MM_DD) {
        return Year;
    }else if(TimeType == HH_MM_SS){
        return Hour;
    }else if(TimeType == YYYY_MM_DD_and_HH_MM_SS){
        return Time;
    }
    return Time;
    

}


+ (NSString *)GetCurrentBeijingTimeandReturnTimeType:(TimeType)TimeType
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    long long int date = (long long int)time;
    
    NSDate *date_c = [NSDate dateWithTimeIntervalSince1970:date];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateFormatter setTimeZone:timeZone];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *BeijingTime = [dateFormatter stringFromDate:date_c];
    NSString *Year = [BeijingTime componentsSeparatedByString:@" "][0];
    NSString *Hour = [BeijingTime componentsSeparatedByString:@" "][1];
    if (TimeType == YYYY_MM_DD) {
        return Year;
    }else if(TimeType == HH_MM_SS){
        return Hour;
    }else if(TimeType == YYYY_MM_DD_and_HH_MM_SS){
        return BeijingTime;
    }
    return BeijingTime;
    
}

@end
