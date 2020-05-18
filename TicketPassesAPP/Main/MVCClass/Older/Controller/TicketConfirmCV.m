//
//  TicketConfirmCV.m
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/8/1.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "TicketConfirmCV.h"
#import "TicketConfirmModel.h"

@interface TicketConfirmCV ()
//车票金额
@property (weak, nonatomic) IBOutlet UILabel *mouniLabel;
@property (weak, nonatomic) IBOutlet UILabel *pipomUber;
//预计手续费
@property (weak, nonatomic) IBOutlet UILabel *sxflabel;
//预计退款金额
@property (weak, nonatomic) IBOutlet UILabel *yujituikuanlabel;
//说明
@property (weak, nonatomic) IBOutlet UILabel *shouminglabel;

@property (weak, nonatomic) IBOutlet UIButton *quexiaoButton;
@property (weak, nonatomic) IBOutlet UIButton *querenButton;

@end

@implementation TicketConfirmCV

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = NSBundleLocalizedString(@"退票退款");
    self.view.backgroundColor = UIColorFromHex(0xf6f6f6);
    
    self.mouniLabel.text = @"";
    self.pipomUber.text = @"";
    self.sxflabel.text = @"";
    self.yujituikuanlabel.text = @"";
    
    NSString *shouming = NSBundleLocalizedString(@"说明");
    NSString *shouming2 = self.shouming;
    
    
    self.shouminglabel.text = [NSString stringWithFormat:@"%@\n%@",shouming,shouming2];
    
    self.quexiaoButton.backgroundColor = [UIColor whiteColor];
    ViewRadius(self.querenButton, 3.0);
    ViewBorderRadius(self.quexiaoButton, 3.0, 0, [UIColor groupTableViewBackgroundColor]);
    [self requestReplyrefund];
}


- (void)requestReplyrefund{
    
    WEAK_SELF;
    [AFHTTP requestReplyrefundOb_id:self.model.ob_id success:^(NSDictionary *dic){
        
        [weakSelf chulishuju:dic];
        
    } failure:^(NSError *errer){
        
        [weakSelf onBack];
        
    }];
    
}
- (void)chulishuju:(NSDictionary *)dic{
    
    NSDictionary *info = dic[@"info"];
    if([info isKindOfClass:[NSDictionary class]]){
        
        TicketConfirmModel *model = [TicketConfirmModel mj_objectWithKeyValues:info];
        
        self.mouniLabel.text =[NSString stringWithFormatPrice:model.all_price];
        
        NSString *gong = NSBundleLocalizedString(@"共");
        NSString *ren = NSBundleLocalizedString(@"人");
        NSString *piponumstr = [NSString stringWithFormat:@"%@%@%@",gong,model.ticket_count,ren];
        self.pipomUber.text = piponumstr;
        
        self.sxflabel.text = [NSString stringWithFormatPrice:model.service_charge];
        
        self.yujituikuanlabel.text =  [NSString stringWithFormatPrice:model.back_money];
        
        
        
    }
        

}
- (void)requestsurerefund{
    
    WEAK_SELF;
    [AFHTTP requestsurerefundOrder_id:self.model.ob_id success:^(NSDictionary *dic){
        
        [MBManager showBriefAlert:NSBundleLocalizedString(@"申请成功")];
        
        [weakSelf onBack];
        
    }];
    
}
- (IBAction)quxiaoClick:(id)sender {
    
    [self onBack];
    
}
- (IBAction)querenClick:(id)sender {
    
    [self requestsurerefund];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
