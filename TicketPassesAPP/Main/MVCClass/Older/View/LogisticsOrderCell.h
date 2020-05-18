//
//  LogisticsOrderCell.h
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/28.
//  Copyright © 2019 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogisticsOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LogisticsOrderCell : UITableViewCell

    @property (weak, nonatomic) IBOutlet UILabel *orderhaoLabel;

    @property (weak, nonatomic) IBOutlet UIImageView *orderIcon;
    @property (weak, nonatomic) IBOutlet UILabel *orderStaseLabel;
    @property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
    @property (weak, nonatomic) IBOutlet UILabel *orderNameLabel;
    @property (weak, nonatomic) IBOutlet UILabel *shouLabel;
    @property (weak, nonatomic) IBOutlet UILabel *orderaddrs;
    @property (weak, nonatomic) IBOutlet UIButton *orderButton;
    
    @property (nonatomic,strong) LogisticsOrderModel *model;

@property (nonatomic, copy) void (^confirmRefundNoticeViewBloak)(LogisticsOrderModel *model);

@end

NS_ASSUME_NONNULL_END
