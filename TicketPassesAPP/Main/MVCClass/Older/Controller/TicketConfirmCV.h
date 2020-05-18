//
//  TicketConfirmCV.h
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/8/1.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "BaseViewController.h"
#import "TicketOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TicketConfirmCV : BaseViewController

@property (nonatomic , strong) TicketOrderModel *model;

@property (nonatomic,strong) NSString *shouming;

@end

NS_ASSUME_NONNULL_END
