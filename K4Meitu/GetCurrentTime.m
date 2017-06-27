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
 
    if ([timeStamp isEqualToString:@""] || [timeStamp isKindOfClass:[NSNull class]]) {
        return @"date Error";
    }
    
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
    
   
     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    
    NSString *Year = [dateTime componentsSeparatedByString:@" "][0];
    NSString *Hour = [dateTime componentsSeparatedByString:@" "][1];
    
    if (TimeType == YYYY_MM_DD) {
        return Year;
    }else if(TimeType == HH_MM_SS){
        return Hour;
    }
    return dateTime;
    
}

@end
