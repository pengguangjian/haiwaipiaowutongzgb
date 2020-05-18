//
//  WXPay.h
//  MeiShi
//
//  Created by caochun on 16/4/14.
//  Copyright © 2016年 More. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXPay : NSObject
@property (nonatomic, strong) NSString *appid;
@property (nonatomic, strong) NSString *partnerid;
@property (nonatomic, strong) NSString *prepayid;
@property (nonatomic, strong) NSString *package;
@property (nonatomic, strong) NSString *noncestr;
@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong) NSString *sign;

@end
