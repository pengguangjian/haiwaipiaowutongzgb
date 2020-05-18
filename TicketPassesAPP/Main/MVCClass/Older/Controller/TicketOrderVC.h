//
//  TicketOrderVC.h
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/15.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TicketOrderVC : BaseViewController

//订票订单状态 1未完成 2已完成 3取消
@property (nonatomic,strong) NSString *tickeType;


@end



NS_ASSUME_NONNULL_END
