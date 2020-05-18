//
//  CellTicket.h
//  TicketPassesAPP
//
//  Created by macbook on 2019/7/2.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CellTicket : UITableViewCell


@property (nonatomic,strong) TicketModel *model;

@end

NS_ASSUME_NONNULL_END
