//
//  OlderDateilsVC.m
//  TicketPassesAPP
//
//  Created by macbook on 2019/7/28.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import "OlderDateilsVC.h"
#import "OlderDateilsModel.h"


@interface OlderDateilsVC ()
@property (weak, nonatomic) IBOutlet UILabel *olderNumber;
@property (weak, nonatomic) IBOutlet UILabel *olderTime;
@property (weak, nonatomic) IBOutlet UILabel *olderStar;
@property (weak, nonatomic) IBOutlet UILabel *olderPr;
@property (weak, nonatomic) IBOutlet UILabel *olderTOYUTime;
//数量
@property (weak, nonatomic) IBOutlet UILabel *olderShutdown;
@property (weak, nonatomic) IBOutlet UILabel *olderTiJi;
@property (weak, nonatomic) IBOutlet UILabel *olderSize;
@property (weak, nonatomic) IBOutlet UILabel *olderName;
//寄件人
@property (weak, nonatomic) IBOutlet UILabel *jijianrenNameAndIphone;
@property (weak, nonatomic) IBOutlet UILabel *jijianrenaddroid;

//发件人
@property (weak, nonatomic) IBOutlet UILabel *fajianrenNameAndIphone;

@property (weak, nonatomic) IBOutlet UILabel *fajianrenaddroid;
@end

@implementation OlderDateilsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSBundleLocalizedString(@"订单详情");
    
    self.olderNumber.text = @" ";
    self.olderTime.text = @" ";
    self.olderStar.text =@" ";
    self.olderPr.text = @" ";
    self.olderTOYUTime.text = @" ";
    self.olderShutdown.text =  @" ";
    self.olderTiJi.text =  @" ";
    self.olderSize.text =  @" ";
    self.olderName.text =  @" ";
    self.jijianrenNameAndIphone.text =  @" ";
    self.jijianrenaddroid .text =  @" ";
    self.fajianrenNameAndIphone .text =  @" ";
    self.fajianrenaddroid.text =  @" ";
    
    [self requeslogisticsdetail];
    
}



- (void)requeslogisticsdetail{
    WEAK_SELF;
    [AFHTTP requeslogisticsdetailOrder_id:self.order_id success:^(NSDictionary * responseObject) {
        
        [weakSelf chulirequeslogisticsdetail:responseObject];
        
    }];
    
}
- (void)chulirequeslogisticsdetail:(NSDictionary *)dic{
    
    NSDictionary *values = dic[@"detail"];
    if([values isKindOfClass:[NSDictionary class]]){
        OlderDateilsModel *model = [OlderDateilsModel mj_objectWithKeyValues:values];
        
        self.olderNumber.text = model.order_code;
        self.olderTime.text = model.create_at;
        self.olderStar.text = model.statusName;
        
        NSString *zhongjai = NSBundleLocalizedString(@"订单总价为");
        NSString *dingjing = NSBundleLocalizedString(@"定金");
        NSString *wukuan = NSBundleLocalizedString(@"尾款");
        NSString *zhongjaiprice = [NSString stringWithFormatPrice:model.total_price];
        NSString *dingjingprice = [NSString stringWithFormatPrice:model.deposit];
        NSString *wukuanprice = [NSString stringWithFormatPrice:model.tail_money];
        NSString *price = [NSString stringWithFormat:@"%@%@ %@%@ %@%@",zhongjai,zhongjaiprice,dingjing,dingjingprice,wukuan,wukuanprice];
        self.olderPr.text = price;
        
        self.olderTOYUTime.text = model.consignment_time;
        self.olderShutdown.text =  model.luggage_count;
        self.olderName.text =  model.luggage_name;
        self.olderTiJi.text = [NSString stringWithFormat:@"%@m³",model.luggage_volume];
        self.olderSize.text =  [NSString stringWithFormat:@"%@kg",model.luggage_weight];
        
        self.jijianrenNameAndIphone.text = [NSString stringWithFormat:@"%@    %@",model.origin_name,model.origin_phone];
        self.jijianrenaddroid .text =  model.origin_address;
        self.fajianrenNameAndIphone .text =  [NSString stringWithFormat:@"%@    %@",model.end_name,model.end_phone];
        self.fajianrenaddroid.text =  model.end_address;
        
        
    }
}







@end
