//
//  LogisticsOrderModel.h
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/28.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LogisticsOrderModel : BaseModel

@property (nonatomic, copy) NSString *ad_consignee_phone;
@property (nonatomic, copy) NSString *ad_get_address;
@property (nonatomic, assign) NSInteger ol_status;
@property (nonatomic, copy) NSString *ol_statusName;
@property (nonatomic, copy) NSString *ol_id;
@property (nonatomic, copy) NSString *ad_consignee;
@property (nonatomic, copy) NSString *ol_order_code;

@end

NS_ASSUME_NONNULL_END
