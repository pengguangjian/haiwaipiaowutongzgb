//
//  TicketModel.h
//  TicketPassesAPP
//
//  Created by xiaoshiheng on 2019/7/30.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TicketModel : BaseModel

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *trip_code;
@property (nonatomic, copy) NSString *end_name_e;
@property (nonatomic, copy) NSString *end_name_y;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *old_price;
@property (nonatomic, copy) NSString *start_name_y;
@property (nonatomic, copy) NSString *station_begin;
@property (nonatomic, copy) NSString *setout_time;
@property (nonatomic, copy) NSString *start_name_c;

@property (nonatomic, copy) NSString *start_name;
@property (nonatomic, copy) NSString *end_name;

@property (nonatomic, copy) NSString *least_count;
@property (nonatomic, copy) NSString *counts;
@property (nonatomic, copy) NSString *station_end;
@property (nonatomic, copy) NSString *end_name_c;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *start_name_e;
@property (nonatomic, copy) NSString *company_name;
@property (nonatomic, copy) NSString *company_id;

@property (nonatomic, copy) NSString *duration;

@property (nonatomic, copy) NSString *from_name;
@property (nonatomic, copy) NSString *to_city;
@property (nonatomic, copy) NSString *vehicle_type;
@property (nonatomic, copy) NSString *total_seats;
@property (nonatomic, copy) NSString *notification_english_label;//乘客须知标题
@property (nonatomic, copy) NSString *notification_english_content;//乘客须知内容
@property (nonatomic, copy) NSString *overall;
@property (nonatomic, copy) NSString *unchoosable;
//@property (nonatomic, copy) NSString *unchoosable;

@end

NS_ASSUME_NONNULL_END
