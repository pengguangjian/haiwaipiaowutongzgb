//
//  CellTicket.m
//  TicketPassesAPP
//
//  Created by macbook on 2019/7/2.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import "CellTicket.h"

@interface CellTicket ()

//yu
@property (weak, nonatomic) IBOutlet UILabel *yulabel;

@property (weak, nonatomic) IBOutlet UIView *boxView;
@property (weak, nonatomic) IBOutlet UILabel *timelabel;

@property (weak, nonatomic) IBOutlet UILabel *kaishilabel;

@property (weak, nonatomic) IBOutlet UILabel *jieshulabel;
@property (weak, nonatomic) IBOutlet UILabel *qianlabel;

@property (weak, nonatomic) IBOutlet UILabel *shengyuLabel;

@end


@implementation CellTicket

- (void)awakeFromNib {
    [super awakeFromNib];
    ViewBorderRadius(self.boxView, 5, 1, UIColorFromHex(0xefefef));\
    self.yulabel.text = NSBundleLocalizedString(@"余");
}

- (void)setModel:(TicketModel *)model{
    _model = model;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:model.setout_time];
    NSDateFormatter *formatterddd = [[NSDateFormatter alloc] init];
    [formatterddd setDateFormat:@"HH:mm"];
    NSString *oneDayStr = [formatterddd stringFromDate:date];
    
    self.timelabel.text = oneDayStr;//model.setout_time;
    
    self.kaishilabel.text = model.start_name;
    self.jieshulabel.text = model.end_name;
    self.qianlabel.text = [NSString stringWithFormatPrice:model.price];
    
    NSString *counts = [NSString stringWithFormat:@"%@%@",model.least_count,NSBundleLocalizedString(@"张")];
    
    self.shengyuLabel.text = counts;
    
}


@end
