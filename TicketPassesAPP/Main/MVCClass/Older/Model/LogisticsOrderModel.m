//
//  LogisticsOrderModel.m
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/28.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "LogisticsOrderModel.h"

@implementation LogisticsOrderModel

//    1未支付  2支付订金（待完成）  3待支付尾款  4已完成（尾款支付）
- (NSString *)ol_statusName{
    NSString *tempName = @" ";
    if(_ol_status == 1){
        tempName = NSBundleLocalizedString(@"未支付");
    }else if(_ol_status == 2){
        tempName = NSBundleLocalizedString(@"已支付");
    }else if(_ol_status == 3){
        tempName = NSBundleLocalizedString(@"待支付尾款");
    }else{
        tempName = NSBundleLocalizedString(@"已完成");
    }
    return tempName;
}


@end
