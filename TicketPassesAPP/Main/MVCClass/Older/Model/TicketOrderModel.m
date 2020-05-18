//
//  TicketOrderModel.m
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/8/1.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "TicketOrderModel.h"

@implementation TicketOrderModel

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
