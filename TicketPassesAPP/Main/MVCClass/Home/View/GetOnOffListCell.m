//
//  GetOnOffListCell.m
//  TicketPassesAPP
//
//  Created by caochun on 2019/11/6.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "GetOnOffListCell.h"

@implementation GetOnOffListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.timeLabel.textColor = COL1;
    self.nameLabel.textColor = COL1;
    self.addrLabel.textColor = COL1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
