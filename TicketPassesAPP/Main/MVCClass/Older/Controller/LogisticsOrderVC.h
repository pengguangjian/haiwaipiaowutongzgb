//
//  LogisticsOrderVC.h
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/15.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LogisticsOrderVC : BaseViewController

//订票订单状态 1待完成 2已完成
@property (nonatomic,strong) NSString *logisticsType;

@end


NS_ASSUME_NONNULL_END
