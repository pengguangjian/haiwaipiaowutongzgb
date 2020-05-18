//
//  CellCompleted.m
//  TicketPassesAPP
//
//  Created by macbook on 2019/7/2.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import "CellCompleted.h"

@implementation CellCompleted

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(TicketOrderModel *)model{
    
    _model = model;
    NSString *zhanname = [NSString stringWithFormat:@"%@-%@",model.start_name,model.end_name];
    self.zhannamelabel.text = zhanname;
    self.qianqianlabel.text = [NSString stringWithFormatPrice:model.ob_all_price];
    
    NSString *fache = NSBundleLocalizedString(@"发车");
    self.fachelabel.text = [NSString stringWithFormat:@"%@%@",[NSDate timestampToTimeStr:[model.ob_setout_time floatValue]],fache];
    
    NSString *gong = NSBundleLocalizedString(@"共");
    NSString *ren = NSBundleLocalizedString(@"人");
    NSString *piponumstr = [NSString stringWithFormat:@"%@%@%@",gong,model.ob_count,ren];
    self.piponumbr.text = piponumstr;
    
    if([model.ob_status integerValue] == 5){
        self.quxiaolabel.text = NSBundleLocalizedString(@"此订单已取消");
    }else{
        self.quxiaolabel.text = NSBundleLocalizedString(@"此订单已完成");
    }
    
    self.orderNoLabel.text = [NSString stringWithFormat:@"订单号：%@",model.booking_pay];
    
    
}
//将时间戳转换为时间
+ (NSDate *)timestampToDate:(CGFloat)timestamp {
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:timestamp];
    
    //解决8小时时差问题
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date dateByAddingTimeInterval: interval];
    
    
    return localeDate;
}


@end
