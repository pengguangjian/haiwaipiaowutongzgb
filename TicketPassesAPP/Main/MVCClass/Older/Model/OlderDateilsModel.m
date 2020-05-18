//
//  OlderDateilsModel.m
//  TicketPassesAPP
//
//  Created by xiaoshiheng on 2019/8/6.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "OlderDateilsModel.h"

@implementation OlderDateilsModel

//    1未支付  2支付订金（待完成）  3待支付尾款  4已完成（尾款支付）
- (NSString *)statusName{

    NSString *tempName = @" ";
    if(_status == 1){
        tempName = NSBundleLocalizedString(@"未支付");
    }else if(_status == 2){
        tempName = NSBundleLocalizedString(@"已支付");
    }else if(_status == 3){
        tempName = NSBundleLocalizedString(@"待支付尾款");
    }else{
        tempName = NSBundleLocalizedString(@"已完成");
    }
    return tempName;
}

@end
