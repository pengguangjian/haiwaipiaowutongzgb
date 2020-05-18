//
//  SBModel.m
//  szshoubao
//
//  Created by xiao_shoubao on 16/6/16.
//  Copyright © 2016年 YQLshoubao. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel


- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    
    if  (property.type.typeClass == [NSString class]) {
        
        if (oldValue == nil || [oldValue isKindOfClass:[NSNull class]])
            
            return @"";
        
    }else if  (property.type.typeClass == [NSDictionary class]) {
        
        if (oldValue == nil || [oldValue isKindOfClass:[NSNull class]])
            
            return @{};
        
    }else if  (property.type.typeClass == [NSArray class]) {
        
        if (oldValue == nil || [oldValue isKindOfClass:[NSNull class]])
            
            return @[];
        
    }
    
    return oldValue;
}



+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"ID":@"id",
             @"Description":@"description"
             };
}

@end
