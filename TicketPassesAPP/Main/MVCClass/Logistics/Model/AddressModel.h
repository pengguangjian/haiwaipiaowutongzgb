//
//  AddressModel.h
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/18.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddressModel : BaseModel


@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *ad_get_address;
@property (nonatomic, copy) NSString *ad_id;
@property (nonatomic, copy) NSString *ad_consignee;
@property (nonatomic, copy) NSString *ad_consignee_phone;
@property (nonatomic, copy) NSString *ad_user_id;

@end

NS_ASSUME_NONNULL_END
