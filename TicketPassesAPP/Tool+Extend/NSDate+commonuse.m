//
//  NSDate+commonuse.m
//  TicketPassesAPP
//
//  Created by xiaoshiheng on 2019/8/12.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "NSDate+commonuse.h"

@implementation NSDate (commonuse)
//获取日期格式化器
+(NSDateFormatter *)dateFormatWith:(NSString *)formatStr {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:formatStr];//@"YYYY-MM-dd HH:mm:ss"
    //设置时区
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    return formatter;
}
//获取当前时间戳
+(NSString *)getNowTimestamp {
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    
    return [self dateToTimestamp:date];
}

//将时间转换为时间戳
+ (NSString *)dateToTimestamp:(NSDate *)date {
    
    NSTimeInterval stamp = [date timeIntervalSince1970];
    
    return [NSString stringWithFormat:@"%.0f", stamp];
}

//将时间转换为时间字符串
+ (NSString *)dateToTimeStr:(NSDate *)date {
    
    NSString *timeStr = [[self dateFormatWith:@"YYYY-MM-dd HH:mm:ss"] stringFromDate:date];
    
    return timeStr;
}

//将时间字符串转换为时间戳
+ (NSString *)timeStrToTimestamp:(NSString *)timeStr {
    
    NSDate *date = [self timeStrToDate:timeStr];
    NSTimeInterval stamp = [date timeIntervalSince1970];
    
    return [NSString stringWithFormat:@"%.0f", stamp];
}

//将时间字符串转换为时间
+ (NSDate *)timeStrToDate:(NSString *)timeStr {
    
    NSDate *date = [[self dateFormatWith:@"YYYY-MM-dd HH:mm:ss"] dateFromString:timeStr];
    
    //解决8小时时差问题
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date dateByAddingTimeInterval: interval];
    
    return localeDate;
}

//将时间戳转换为时间字符串
+ (NSString *)timestampToTimeStr:(CGFloat)timestamp {
    
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *timeStr=[[self dateFormatWith:@"YYYY-MM-dd HH:mm:ss"] stringFromDate:date];
    
    return timeStr;
}

//将时间戳转换为时间
+ (NSDate *)timestampToDate:(CGFloat)timestamp {
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:timestamp];
    
    //解决8小时时差问题
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date dateByAddingTimeInterval: interval];
    
    
    return localeDate;
}

@end
