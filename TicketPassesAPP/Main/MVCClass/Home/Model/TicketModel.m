//
//  TicketModel.m
//  TicketPassesAPP
//
//  Created by xiaoshiheng on 2019/7/30.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "TicketModel.h"

@implementation TicketModel

- (NSString *)start_name{
    NSInteger type =  [NSBundle getLanguageType];
    if(type == 1){
        return _start_name_y;
    }else if(type == 2){
        return _start_name_e;
    }else{
        return _start_name_c;
    }
}
- (NSString *)end_name{
    NSInteger type =  [NSBundle getLanguageType];
    if(type == 1){
        return _end_name_y;
    }else if(type == 2){
        return _end_name_e;
    }else{
        return _end_name_c;
    }
}

@end
