//
//  CellPendingOlder.m
//  TicketPassesAPP
//
//  Created by macbook on 2019/7/2.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import "CellPendingOlder.h"

@interface CellPendingOlder ()

@property (weak, nonatomic) IBOutlet UILabel *tishilabel;
@property (weak, nonatomic) IBOutlet UIButton *outButton;
@property (weak, nonatomic) IBOutlet UILabel *zhannamelabel;
@property (weak, nonatomic) IBOutlet UILabel *fachelabel;
@property (weak, nonatomic) IBOutlet UILabel *qianqianlabel;
@property (weak, nonatomic) IBOutlet UILabel *piponumbr;
@property (strong, nonatomic) IBOutlet UILabel *orderNoLabel;

@end


@implementation CellPendingOlder

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tishilabel.text = NSBundleLocalizedString(@"温馨提示：请提前准时到达始发站");
    ViewBorderRadius(self.outButton, 5, 0, UIColorFromHex(0x989898));
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(TicketOrderModel *)model{
    
    _model = model;
    
    if([model.ob_status intValue] == 1){
        //支付
        [self.outButton setTitle:NSBundleLocalizedString(@"支付") forState:UIControlStateNormal];
    }else{
        //待坐车
        [self.outButton setTitle:NSBundleLocalizedString(@"退票退款") forState:UIControlStateNormal];
    }
    
    
    NSString *zhanname = [NSString stringWithFormat:@"%@-%@",model.start_name,model.end_name];
    self.zhannamelabel.text = zhanname;
    self.qianqianlabel.text = [NSString stringWithFormatPrice:model.ob_all_price];
    
    NSString *fache = NSBundleLocalizedString(@"发车");
    self.fachelabel.text = [NSString stringWithFormat:@"%@%@",[NSDate timestampToTimeStr:[model.ob_setout_time floatValue]],fache];
    
    NSString *gong = NSBundleLocalizedString(@"共");
    NSString *ren = NSBundleLocalizedString(@"人");
    NSString *piponumstr = [NSString stringWithFormat:@"%@%@%@",gong,model.ob_count,ren];
    self.piponumbr.text = piponumstr;
    
    self.orderNoLabel.text = [NSString stringWithFormat:@"订单号：%@",model.booking_pay];
    
    
}

- (IBAction)tuipiaoClick:(id)sender {
    
    if(self.selectCellViewBloak){
        self.selectCellViewBloak(self.model);
    }
    
    
}


@end
