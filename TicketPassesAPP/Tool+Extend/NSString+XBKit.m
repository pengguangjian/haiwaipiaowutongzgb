//
//  NSString+XBKit.m
//  TicketPassesAPP
//
//  Created by xiaoshiheng on 2019/8/6.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "NSString+XBKit.h"

@implementation NSString (XBKit)

+ (instancetype)stringWithFormatPrice:(NSString *)priceStr
{
    //容错
    if (!priceStr) {
        priceStr = @"0";
    }
    //包含￥  去掉
    NSString* showStr = [NSString stringWithString:priceStr];
    NSRange rangeMoney1 = [priceStr rangeOfString:@"￥"];
    if (rangeMoney1.length != 0) {
        //如果包含
        showStr = [showStr stringByReplacingOccurrencesOfString:@"￥" withString:@""];
    }
    
    NSRange rangeMoney2 = [priceStr rangeOfString:@"元"];
    if (rangeMoney2.length != 0) {
        //如果包含
        showStr = [showStr stringByReplacingOccurrencesOfString:@"元" withString:@""];
    }
    double doubleShowValue = [showStr doubleValue];
    NSString *tempStr = [self accurateNumberStr:[NSString stringWithFormat:@"%lf", doubleShowValue] afterPoint:2];
    NSString *resultStr ;
    
    resultStr = [NSString stringWithFormat:@"%@RMB", tempStr];
    
    return resultStr;
    
}

+ (NSString *)accurateNumberStr:(NSString *)numberStr afterPoint:(NSInteger)afterPoint {
    
    //保留小数点后两
    NSDecimalNumberHandler *numberHandler = [NSDecimalNumberHandler
                                             decimalNumberHandlerWithRoundingMode:NSRoundDown
                                             scale:afterPoint
                                             raiseOnExactness:NO
                                             raiseOnOverflow:NO
                                             raiseOnUnderflow:NO
                                             raiseOnDivideByZero:YES];
    
    NSDecimalNumber *tempResult = [NSDecimalNumber decimalNumberWithString:numberStr];
    
    NSDecimalNumber *roundedOunces = [tempResult decimalNumberByRoundingAccordingToBehavior:numberHandler];
    
    return [NSString stringWithFormat:@"%.2lf",[roundedOunces doubleValue]];
}

@end
