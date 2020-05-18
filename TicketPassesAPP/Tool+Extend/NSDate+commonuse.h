//
//  NSDate+commonuse.h
//  TicketPassesAPP
//
//  Created by xiaoshiheng on 2019/8/12.
//  Copyright © 2019 macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (commonuse)
//日期格式化
+(NSDateFormatter *)dateFormatWith:(NSString *)formatStr;

//获取当前时间戳
+(NSString *)getNowTimestamp;

//将时间转换为时间戳
+ (NSString *)dateToTimestamp:(NSDate *)date;

//将时间转换为时间字符串
+ (NSString *)dateToTimeStr:(NSDate *)date;

//将时间戳转换为时间
+ (NSDate *)timestampToDate:(CGFloat)timestamp;

//将时间字符串转换为时间戳
+ (NSString *)timeStrToTimestamp:(NSString *)timeStr;

//将时间字符串转换为时间
+ (NSDate *)timeStrToDate:(NSString *)timeStr;

//将时间戳转换为时间字符串
+ (NSString *)timestampToTimeStr:(CGFloat)timestamp;


@end

NS_ASSUME_NONNULL_END
