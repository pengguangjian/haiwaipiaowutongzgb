//
//  PaymentWebViewController.h
//  TicketPassesAPP
//
//  Created by xiaoshiheng on 2019/7/31.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PaymentWebViewController : BaseViewController


//支付系统必要
@property (nonatomic,strong) NSString *order_id;
//支付系统必要
@property (nonatomic,strong) NSString *order_type;

@end

NS_ASSUME_NONNULL_END
