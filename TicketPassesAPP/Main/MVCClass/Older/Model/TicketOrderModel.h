//
//  TicketOrderModel.h
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/8/1.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TicketOrderModel : BaseModel


@property (nonatomic, copy) NSString *end_name_e;
@property (nonatomic, copy) NSString *ob_unit_price;
@property (nonatomic, copy) NSNumber *ob_status;
@property (nonatomic, copy) NSString *end_name_y;
@property (nonatomic, copy) NSString *ob_id;
@property (nonatomic, copy) NSString *order_code;
@property (nonatomic, copy) NSString *ob_all_price;
@property (nonatomic, copy) NSString *start_name_y;
@property (nonatomic, copy) NSNumber *ob_count;
@property (nonatomic, copy) NSString *start_name_c;
@property (nonatomic, copy) NSString *end_name_c;

@property (nonatomic, copy) NSString *start_name;
@property (nonatomic, copy) NSString *end_name;

@property (nonatomic, copy) NSNumber *ob_setout_time;
@property (nonatomic, copy) NSString *start_name_e;
@property (nonatomic, copy) NSString *booking_pay;


@end

NS_ASSUME_NONNULL_END
