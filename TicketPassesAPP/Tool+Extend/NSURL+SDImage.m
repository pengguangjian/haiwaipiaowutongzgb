
//
//  NSURL+SDImage.m
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/14.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "NSURL+SDImage.h"

@implementation NSURL (SDImage)

+ (NSURL *)SDURLWithString:(NSString *)str{

    if(![XBUtils isValString:str]){
        
        if([str containsString:@"http"] || [str containsString:@"https"]){
            
            return [NSURL URLWithString:str];
            
        }else{
            
            NSString *urlstr = [NSString stringWithFormat:@"%@%@",HTTPImageAPI,str];
            return [NSURL URLWithString:urlstr];
        }
    }else{
        return [NSURL URLWithString:@""];
    }
}


@end
