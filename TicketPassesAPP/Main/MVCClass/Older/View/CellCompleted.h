//
//  CellCompleted.h
//  TicketPassesAPP
//
//  Created by macbook on 2019/7/2.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CellCompleted : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *zhannamelabel;
@property (weak, nonatomic) IBOutlet UILabel *fachelabel;
@property (weak, nonatomic) IBOutlet UILabel *qianqianlabel;
@property (weak, nonatomic) IBOutlet UILabel *piponumbr;
@property (weak, nonatomic) IBOutlet UILabel *quxiaolabel;
@property (strong, nonatomic) IBOutlet UILabel *orderNoLabel;

@property (nonatomic,strong) TicketOrderModel *model;

@end

NS_ASSUME_NONNULL_END
