//
//  TicketConfirmModel.h
//  TicketPassesAPP
//
//  Created by xiaoshiheng on 2019/8/6.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TicketConfirmModel : BaseModel

@property (nonatomic, copy) NSString *service_charge;
@property (nonatomic, copy) NSString *back_money;
@property (nonatomic, copy) NSString *all_price;
@property (nonatomic, copy) NSString *ticket_count;

@end

NS_ASSUME_NONNULL_END
