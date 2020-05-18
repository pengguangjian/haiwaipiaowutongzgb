//
//  OlderDateilsModel.h
//  TicketPassesAPP
//
//  Created by xiaoshiheng on 2019/8/6.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OlderDateilsModel : BaseModel
//总价
@property (nonatomic, copy) NSString *total_price;
//尾款
@property (nonatomic, copy) NSString *tail_money;
//定金
@property (nonatomic, copy) NSString *deposit;
//下单时间
@property (nonatomic, copy) NSString *create_at;
//编号
@property (nonatomic, copy) NSString *order_code;
//运送时间
@property (nonatomic, copy) NSString *consignment_time;
//行李名
@property (nonatomic, copy) NSString *luggage_name;
//行李数量
@property (nonatomic, copy) NSString *luggage_count;
//体积
@property (nonatomic, copy) NSString *luggage_volume;
//重
@property (nonatomic, copy) NSString *luggage_weight;

//状态
@property (nonatomic, assign) NSInteger status;
//状态名称
@property (nonatomic, copy) NSString *statusName;


//发件人
@property (nonatomic, copy) NSString *origin_name;
@property (nonatomic, copy) NSString *origin_phone;
@property (nonatomic, copy) NSString *origin_address;
//收件人
@property (nonatomic, copy) NSString *end_address;
@property (nonatomic, copy) NSString *end_name;
@property (nonatomic, copy) NSString *end_phone;

@end

NS_ASSUME_NONNULL_END
