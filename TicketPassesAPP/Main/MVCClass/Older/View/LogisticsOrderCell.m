//
//  LogisticsOrderCell.m
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/28.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "LogisticsOrderCell.h"

@implementation LogisticsOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = UIColorFromHex(0xf6f6f6);
    self.orderhaoLabel .text = NSBundleLocalizedString(@"订单号");
    [self.orderButton setTitle:NSBundleLocalizedString(@"订单详情") forState:UIControlStateNormal];
    ViewBorderRadius(self.orderButton, 3.0f, 1, UIColorFromHex(0xefefef));

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)clickOrderinif:(id)sender {
    
    if(self.confirmRefundNoticeViewBloak){
        self.confirmRefundNoticeViewBloak(self.model);
    }
    
}
    
    - (void)setModel:(LogisticsOrderModel *)model{
        _model = model;
        
        if (_model.ol_status == 2) {
            [self.orderButton setTitle:NSBundleLocalizedString(@"退款") forState:UIControlStateNormal];
            [self.orderButton setBackgroundColor:DEFAULTCOLOR1];
            [self.orderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        } else {
            [self.orderButton setBackgroundColor:[UIColor whiteColor]];
            [self.orderButton setTitleColor:COL2 forState:UIControlStateNormal];
        }
        
        
        self.orderStaseLabel.textColor =UIColorFromHex(0x56b157);
        self.orderStaseLabel.text = model.ol_statusName;
        self.orderNumberLabel.text = model.ol_order_code;
        NSString *name = [NSString stringWithFormat:@"%@    %@",model.ad_consignee,model.ad_consignee_phone];
        self.orderNameLabel.text = name;
        self.shouLabel.text = NSBundleLocalizedString(@"收");
        self.orderaddrs.text = model.ad_get_address;
    }

@end
