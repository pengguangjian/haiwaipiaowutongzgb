//
//  CellPendingOlder.h
//  TicketPassesAPP
//
//  Created by macbook on 2019/7/2.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CellPendingOlder : UITableViewCell


@property (nonatomic,strong) TicketOrderModel *model;

@property (nonatomic, copy) void (^selectCellViewBloak)(TicketOrderModel *model);

@end

NS_ASSUME_NONNULL_END
