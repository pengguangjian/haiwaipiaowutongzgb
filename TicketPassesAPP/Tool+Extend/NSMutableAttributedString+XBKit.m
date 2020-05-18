//
//  NSMutableAttributedString+XBKit.m
//  YJB
//
//  Created by admin on 2017/6/21.
//  Copyright © 2017年 肖世恒. All rights reserved.
//

#import "NSMutableAttributedString+XBKit.h"

@implementation NSMutableAttributedString (XBKit)


+(instancetype)attributedStringMax14Min12WithShowStr:(NSString *)showStr{
    
    return [self attributedStringWithShowStr:showStr smallerFont:12 biggerFont:14 isUnit:NO issymbol:NO];
}

    +(instancetype)attributedStringUnitMax22Min15WithShowStr:(NSString *)showStr{
        
        
        return [self attributedStringWithShowStr:showStr smallerFont:15 biggerFont:22 isUnit:YES issymbol:YES];
        
    }

+ (instancetype)attributedStringWithShowStr:(NSString *)filePrefix smallerFont:(NSInteger)smallerFont biggerFont:(NSInteger)biggerFont isUnit:(BOOL)isUnit{
    
    
    return [self attributedStringWithShowStr:filePrefix smallerFont:smallerFont biggerFont:biggerFont isUnit:isUnit issymbol:YES];
    
}

+ (instancetype)attributedStringWithShowStr:(NSString *)filePrefix smallerFont:(NSInteger)smallerFont biggerFont:(NSInteger)biggerFont isUnit:(BOOL)isUnit issymbol:(BOOL)issymbol{
    
    //容错
    if (!filePrefix) {
        filePrefix = @"0";
    }
    if (smallerFont == 0) {
        smallerFont = 10;
    }
    if (biggerFont == 0) {
        biggerFont = 16;
    }
    //包含￥  去掉
    NSString* showStr = [NSString stringWithString:filePrefix];
    NSRange rangeMoney1 = [filePrefix rangeOfString:@"￥"];
    if (rangeMoney1.length != 0) {
        //如果包含
        showStr = [showStr stringByReplacingOccurrencesOfString:@"￥" withString:@""];
    }
    
    NSRange rangeMoney2 = [filePrefix rangeOfString:@"元"];
    if (rangeMoney2.length != 0) {
        //如果包含
        showStr = [showStr stringByReplacingOccurrencesOfString:@"元" withString:@""];
    }
    
    
    
    double doubleShowValue = [showStr doubleValue];
    ///自动 加 万 亿 单位 和  ￥ 符号
    if(isUnit){
        NSString *tempStr = [self accurateNumberStr:[NSString stringWithFormat:@"%lf", doubleShowValue] afterPoint:2];
        NSString *resultStr ;
        if(issymbol){
            resultStr = [NSString stringWithFormat:@"￥%@", tempStr];
        }else{
            resultStr = [NSString stringWithFormat:@"%@", tempStr];
        }
        
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:resultStr];
        [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:smallerFont] range:NSMakeRange(0, 1)];
        [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:biggerFont] range:NSMakeRange(1, resultStr.length-3)];
        [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:smallerFont] range:NSMakeRange(resultStr.length-3, 3)];
        
        return attStr;
        /*
        if (doubleShowValue > 1000000000) {
            
            NSString *tempStr = [self accurateNumberStr:[NSString stringWithFormat:@"%lf", doubleShowValue/100000000.0] afterPoint:2];
            NSString *resultStr ;
            if(issymbol){
                resultStr = [NSString stringWithFormat:@"￥%@亿", tempStr];
            }else{
                resultStr = [NSString stringWithFormat:@"%@亿", tempStr];
            }
            
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:resultStr];
            
            [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:smallerFont] range:NSMakeRange(0, 1)];
            [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:biggerFont] range:NSMakeRange(1, resultStr.length-3)];
            [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:smallerFont] range:NSMakeRange(resultStr.length-3, 3)];
            
            return attStr;
            
        } else if (doubleShowValue > 100000) {
            
            NSString *tempStr = [self accurateNumberStr:[NSString stringWithFormat:@"%lf", doubleShowValue/10000.0] afterPoint:2];
            NSString *resultStr ;
            if(issymbol){
                resultStr = [NSString stringWithFormat:@"￥%@万", tempStr];
            }else{
                resultStr = [NSString stringWithFormat:@"%@万", tempStr];
            }
            
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:resultStr];
            [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:smallerFont] range:NSMakeRange(0, 1)];
            [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:biggerFont] range:NSMakeRange(1, resultStr.length-3)];
            [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:smallerFont] range:NSMakeRange(resultStr.length-3, 3)];
            
            return attStr;
            
        } else {
            
            NSString *tempStr = [self accurateNumberStr:[NSString stringWithFormat:@"%lf", doubleShowValue] afterPoint:2];
            NSString *resultStr ;
            if(issymbol){
                resultStr = [NSString stringWithFormat:@"￥%@", tempStr];
            }else{
                resultStr = [NSString stringWithFormat:@"%@", tempStr];
            }
            
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:resultStr];
            [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:smallerFont] range:NSMakeRange(0, 1)];
            [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:biggerFont] range:NSMakeRange(1, resultStr.length-3)];
            [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:smallerFont] range:NSMakeRange(resultStr.length-3, 3)];
            
            return attStr;
        }
        */
    }else{
        
        NSString *tempStr = [self accurateNumberStr:[NSString stringWithFormat:@"%lf", doubleShowValue] afterPoint:2];
        NSString *resultStr = [NSString stringWithFormat:@"%@", tempStr];
        
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:resultStr];
        [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:biggerFont] range:NSMakeRange(0, resultStr.length-3)];
        [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:smallerFont] range:NSMakeRange(resultStr.length-3, 3)];
        
        return attStr;
    }
    

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
