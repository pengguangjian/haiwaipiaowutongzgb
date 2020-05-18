//
//  LogisticsOrderRefundVC.m
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/8/1.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "LogisticsOrderRefundVC.h"
#import "TicketConfirmModel.h"
#import "WebModel.h"

@interface LogisticsOrderRefundVC ()
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

@implementation LogisticsOrderRefundVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = NSBundleLocalizedString(@"退款");
    self.view.backgroundColor = UIColorFromHex(0xf6f6f6);
    
    self.mouniLabel.text = @"";
    self.pipomUber.text = @"";
    self.sxflabel.text = @"";
    self.yujituikuanlabel.text = @"";
    
    
    
    self.quexiaoButton.backgroundColor = [UIColor whiteColor];
    ViewRadius(self.querenButton, 3.0);
    ViewBorderRadius(self.quexiaoButton, 3.0, 1, [UIColor groupTableViewBackgroundColor]);
    [self requestReplyrefund];
    
    [self getRequestDesc];
}


- (void)getRequestDesc{
    
    WEAK_SELF;
    [AFHTTP requestInfoagreement555555success:^(NSDictionary *responseObject){
        WebModel *model = [WebModel mj_objectWithKeyValues:responseObject[@"content"]];
        weakSelf.shouming = [weakSelf filterHTML:model.content];
        
        NSString *shouming = NSBundleLocalizedString(@"说明");
        NSString *shouming2 = self.shouming;
        
        self.shouminglabel.text = [NSString stringWithFormat:@"%@\n%@",shouming,shouming2];
    }];
}

- (NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}


- (void)requestReplyrefund{
    
    WEAK_SELF;
    [AFHTTP requestLogisticsReplyrefundOb_id:self.model.ol_id success:^(NSDictionary *dic){
        
        [weakSelf chulishuju:dic];
        
    } failure:^(NSError *errer){
        
        [weakSelf onBack];
        
    }];
    
}
- (void)chulishuju:(NSDictionary *)dic{
    
    NSDictionary *info = dic[@"info"];
    if([info isKindOfClass:[NSDictionary class]]){
        
        TicketConfirmModel *model = [TicketConfirmModel mj_objectWithKeyValues:info];
        
        self.mouniLabel.text = [NSString stringWithFormatPrice:model.all_price];
        
        self.sxflabel.text = [NSString stringWithFormatPrice:model.service_charge];
        
        self.yujituikuanlabel.text =  [NSString stringWithFormatPrice:model.back_money];
        
    }
        

}
- (void)requestsurerefund{
    
    WEAK_SELF;
    [AFHTTP requestLogisticssurerefundOrder_id:self.model.ol_id success:^(NSDictionary *dic){
        
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
