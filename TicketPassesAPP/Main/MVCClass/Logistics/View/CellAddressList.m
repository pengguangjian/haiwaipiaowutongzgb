//
//  CellAddressList.m
//  TicketPassesAPP
//
//  Created by macbook on 2019/6/28.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import "CellAddressList.h"

@implementation CellAddressList

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(AddressModel *)model{
    _model = model;
    self.nameLabel.text = model.ad_consignee;
    self.iphoneLabel.text = model.ad_consignee_phone;
    self.addressLabel.text = model.ad_get_address;
}


@end
