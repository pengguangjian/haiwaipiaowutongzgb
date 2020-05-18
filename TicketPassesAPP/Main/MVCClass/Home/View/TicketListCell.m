//
//  TicketListCell.m
//  TicketPassesAPP
//
//  Created by caochun on 2019/11/4.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "TicketListCell.h"

@implementation TicketListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.passengerNotesLabel.textColor = DEFAULTCOLOR1;
    self.passengerNotesLabel.text = @"";
    
    self.priceLabel.textColor = DEFAULTCOLOR1;
    self.oldPriceLabel.textColor = COL3;
    
    self.starLevelLabel.text = @"评价星级";
    
    _starRate = [[TYStarRateView alloc] initWithFrame:CGRectMake(0, 0, 90, 15) numberOfStars:5];
    _starRate.scorePercent = 4.0/5.0;
    _starRate.allowIncompleteStar = NO;
    _starRate.hasAnimation = YES;
    _starRate.isSetting = NO;
    _starRate.delegate = self;
    [_starContainerView addSubview:_starRate];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(TicketModel *)model {
    _model = model;
    
    self.passengerNotesLabel.text = model.notification_english_label;
//
    self.startTimeLabel.text = [Util time_hourSecondTime:model.station_begin];
    self.startStationLable.text = model.from_name;
    self.endTimeLabel.text = [Util time_hourSecondTime:model.station_end];
    self.endStationLabel.text = model.to_city;
    self.boardingPointLabel.text = model.start_name_c;
    self.busTypeLabel.text = [NSString stringWithFormat:@"%@",model.vehicle_type];
    self.busCompanyLabel.text = model.company_name;
    self.priceLabel.text = [NSString stringWithFormatPrice:model.price];
    
    if ([model.old_price doubleValue]>0) {
        self.oldPriceLabel.text = [NSString stringWithFormatPrice:model.old_price];
    } else {
        self.oldPriceLabel.text = nil;
    }
    
    //删除线
    NSDictionary *attrDic = @{
                              NSFontAttributeName:[UIFont systemFontOfSize:13.f],
                              NSForegroundColorAttributeName:COL2,
                              NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),
                              NSStrikethroughColorAttributeName:COL2,
                              NSBaselineOffsetAttributeName:@(0)
                              };
    
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:self.oldPriceLabel.text attributes:attrDic];
    self.oldPriceLabel.attributedText = attrStr;
    
    
//    
    NSString *counts = [NSString stringWithFormat:@"%@%@",model.least_count,NSBundleLocalizedString(@"张")];
//    
    self.remainingTicketLabel.text = [NSString stringWithFormat:@"余票%@",counts];
    
    NSString *remainingTicketText = self.remainingTicketLabel.text;
    NSMutableAttributedString *remainingTicketAttrStr = [[NSMutableAttributedString alloc] initWithString:remainingTicketText];
    [remainingTicketAttrStr addAttribute:NSForegroundColorAttributeName
                             value:DEFAULTCOLOR1
                             range:NSMakeRange(2, remainingTicketText.length-3)];
    self.remainingTicketLabel.attributedText = remainingTicketAttrStr;
    
    self.starRate.scorePercent = [model.overall doubleValue]/5.0f;
}

@end
