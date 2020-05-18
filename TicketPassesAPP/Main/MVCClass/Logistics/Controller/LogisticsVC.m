//
//  LogisticsVC.m
//  TicketPassesAPP
//
//  Created by macbook on 2019/6/28.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import "LogisticsVC.h"
#import "AddressListVC.h"
#import "SelectPayTypeVC.h"
#import "AddressModel.h"
#import "XBCalendar.h"
#import "SelectPayTypeVC.h"
#import "EditorAddressVC.h"

@interface LogisticsModel : NSObject
    //出发地址
    @property (nonatomic,strong) NSString *addressID1;
    //到货地址
    @property (nonatomic,strong) NSString *addressID2;
    //时间
    @property (nonatomic,strong) NSString *time;
    //数量
    @property (nonatomic,strong) NSString *XLnumber;
    //名称
    @property (nonatomic,strong) NSString *XLname;
    //体积
    @property (nonatomic,strong) NSString *XLsize;
    //kg
    @property (nonatomic,strong) NSString *XLkg;
    //定金
    @property (nonatomic,strong) NSString *ol_deposit;
    //总价
    @property (nonatomic,strong) NSString *ol_tail_money;
    
@end

@implementation LogisticsModel



@end


@interface LogisticsVC ()<XBCalendarDelegate>

    
@property (nonatomic,strong) LogisticsModel *LogModel;

@property (weak, nonatomic) IBOutlet UILabel *qidianView;
@property (weak, nonatomic) IBOutlet UILabel *zhongdianView;

@property (weak, nonatomic) IBOutlet UILabel *addressName1;
@property (weak, nonatomic) IBOutlet UILabel *addressDetalis1;
@property (weak, nonatomic) IBOutlet UILabel *addressplaceholder1;
@property (weak, nonatomic) IBOutlet UILabel *addressName2;
@property (weak, nonatomic) IBOutlet UILabel *addressDetalis2;
@property (weak, nonatomic) IBOutlet UILabel *addressplaceholder2;
    
@property (weak, nonatomic) IBOutlet UILabel *fieldTime;
    
@property (weak, nonatomic) IBOutlet UITextField *fieldNumber;
@property (weak, nonatomic) IBOutlet UITextView *fiekdText;
@property (weak, nonatomic) IBOutlet UITextField *fieldSize;
@property (weak, nonatomic) IBOutlet UITextField *fieldKg;
    //定睛
    @property (weak, nonatomic) IBOutlet UILabel *deposit_countLabel;
    //总价
    @property (weak, nonatomic) IBOutlet UILabel *estimate_priceLabel;


@property (nonatomic, strong) XBCalendar *calendar;

//时间
@property (nonatomic, strong) LXCalendarDayModel *setout_time;

@end

@implementation LogisticsVC

- (void)dealloc{
    //删除指定的key路径监听器
    if(_LogModel){
        [self.LogModel removeObserver:self forKeyPath:@"XLsize"];
        [self.LogModel removeObserver:self forKeyPath:@"XLkg"];
    }
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化 值
    ViewRadius(self.qidianView, 15);
    ViewRadius(self.zhongdianView, 15);
    
    self.qidianView.text = NSBundleLocalizedString(@"起");
    self.zhongdianView.text = NSBundleLocalizedString(@"终");
    self.LogModel.addressID1 = @"";
    self.addressName1.hidden = YES;
    self.addressDetalis1.hidden = YES;
    self.addressplaceholder1 .hidden = NO;
    self.addressName1.text = @"";
    self.addressDetalis1.text = @"";
    self.addressplaceholder1.text = NSBundleLocalizedString(@"请选择发货地址");
    
    self.LogModel.addressID2 = @"";
    self.addressName2.hidden = YES;
    self.addressDetalis2.hidden = YES;
    self.addressplaceholder2 .hidden = NO;
    self.addressName2.text = @"";
    self.addressDetalis2.text = @"";
    self.addressplaceholder2.text = NSBundleLocalizedString(@"请选择收货地址");
    
    self.fieldTime.text = NSBundleLocalizedString(@"请选择托运日期");
    
    self.LogModel.XLnumber = @"1";
    self.fieldNumber.text = @"1";
    
    self.deposit_countLabel.text = @"";
    self.estimate_priceLabel.text = @"";
    /*
     options: 有4个值，分别是：
     NSKeyValueObservingOptionOld 把更改之前的值提供给处理方法
     NSKeyValueObservingOptionNew 把更改之后的值提供给处理方法
     NSKeyValueObservingOptionInitial 把初始化的值提供给处理方法，一旦注册，立马就会调用一次。通常它会带有新值，而不会带有旧值。
     NSKeyValueObservingOptionPrior 分2次调用。在值改变之前和值改变之后。
     */

    WEAK_SELF;
    //输入限制 获取值方法
    self.fieldNumber.yb_inputCP = YBInputControlProfile.creat.set_textControlType(YBTextControlType_number).set_textChanged(^(UITextField *field){
        weakSelf.LogModel.XLnumber = field.text;
    });
    self.fieldSize.yb_inputCP = YBInputControlProfile.creat.set_textControlType(YBTextControlType_number).set_textChanged(^(UITextField *field){
        weakSelf.LogModel.XLsize = field.text;
    });
    self.fieldKg.yb_inputCP = YBInputControlProfile.creat.set_textControlType(YBTextControlType_number).set_textChanged(^(UITextField *field){
        weakSelf.LogModel.XLkg = field.text;
    });
    self.fiekdText.yb_inputCP = YBInputControlProfile.creat.set_maxLength(50).set_textChanged(^(UITextView *field){
        weakSelf.LogModel.XLname = field.text;
    });
    self.fiekdText.placeholder = NSBundleLocalizedString(@"填写货物的名称，最多不超过50字");
    
    //注册一个监听器用于监听指定的key路径
//    [self.LogModel addObserver:self forKeyPath:@"addressID1" options:NSKeyValueObservingOptionNew context:nil];
//    [self.LogModel addObserver:self forKeyPath:@"addressID2" options:NSKeyValueObservingOptionNew context:nil];
//    [self.LogModel addObserver:self forKeyPath:@"time" options:NSKeyValueObservingOptionNew context:nil];
//    [self.LogModel addObserver:self forKeyPath:@"XLnumber" options:NSKeyValueObservingOptionNew context:nil];
//    [self.LogModel addObserver:self forKeyPath:@"XLname" options:NSKeyValueObservingOptionNew context:nil];
    [self.LogModel addObserver:self forKeyPath:@"XLsize" options:NSKeyValueObservingOptionNew context:nil];
    [self.LogModel addObserver:self forKeyPath:@"XLkg" options:NSKeyValueObservingOptionNew context:nil];
    
   
    
    
}
    //当key路径对应的属性值发生改变时，监听器就会回调自身的监听方法，如下
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)contex{
    
    
    if([object isKindOfClass:[LogisticsModel class]]){
        LogisticsModel *model = object;
        
        if(![XBUtils isValString:model.XLsize] && ![XBUtils isValString:model.XLkg]){
            //模型中的 全部值 是否 全部有了
            [self getPriceestimate];
        }
//        NSLog(@"%@--%@",keyPath,model);
    }

}
#pragma mark --- selectTimerEnd
- (void)selectTimerEnd:(LXCalendarDayModel *)model{
    self.setout_time = model;
    [self uptime];
}
- (void)uptime{
    //    NSLog(@"%ld年 - %ld月 - %ld日",self.setout_time.year,self.setout_time.month,self.setout_time.day);
    
    //这月
    NSDate *monthData = [NSDate date];
    LXCalendarMonthModel *monthModel = [[LXCalendarMonthModel alloc]initWithDate:monthData];
    
    NSString *string;
    if(monthModel.year == self.setout_time.year){
        //年相等
        string = [NSBundle getYue:[NSString stringWithFormat:@"%i",self.setout_time.month] Ri:[NSString stringWithFormat:@"%i",self.setout_time.day]];
        
        if(monthModel.month == self.setout_time.month &&
           monthModel.day == self.setout_time.day ){
            //月，日相等
            //月，日相等
            string = [string stringByAppendingString:[NSString stringWithFormat:@"  %@",NSBundleLocalizedString(@"今日")]];
        }
    }else{
        string = [NSBundle getNian:[NSString stringWithFormat:@"%i",self.setout_time.year] Yue:[NSString stringWithFormat:@"%i",self.setout_time.month] Ri:[NSString stringWithFormat:@"%i",self.setout_time.day]];
    }
    NSString *time = [NSString stringWithFormat:@"%ld-%ld-%ld",self.setout_time.year,self.setout_time.month,self.setout_time.day];
    self.LogModel.time = time;
    self.fieldTime.text =  string;
    
}
#pragma mark -----  nwekeng
- (void)getPriceestimate{
    
    WEAK_SELF;
    [AFHTTP requesPriceestimateOl_luggage_volume:self.LogModel.XLsize ol_luggage_weight:self.LogModel.XLkg success:^(NSDictionary *model){
        
        NSDictionary *datas = model[@"datas"];
        if([datas isKindOfClass:[NSDictionary class]]){
            
            [weakSelf dealwithPriceestimate:datas];
        }
    } failure:^(NSError *error){
        
    }];
}
- (void)dealwithPriceestimate:(NSDictionary *)datas{
    

    NSString *depositstr = [NSString stringWithFormat:@"%@",datas[@"deposit_count"]];
    self.LogModel.ol_deposit = depositstr;
    self.deposit_countLabel.text = [NSString stringWithFormatPrice:depositstr];

    NSString *estimatestr = [NSString stringWithFormat:@"%@",datas[@"estimate_price"]];
    self.LogModel.ol_tail_money = estimatestr;
    self.estimate_priceLabel.text = [NSString stringWithFormatPrice:estimatestr];

}
//点击日期
- (IBAction)clickTime:(id)sender {
    
    [self.view endEditing:YES];
    [self.calendar showMenu];
    
}
    //减
- (IBAction)clickLess:(id)sender {
    
    NSInteger number =  [self.LogModel.XLnumber integerValue];
    if(NO){
        //不是数字 结束
        return;
    }
    number -- ;
    if(number == 0){
        //最后结果 = 0 结束
        return;
    }
    NSString *numbernew = [NSString stringWithFormat:@"%i",number];
    self.fieldNumber.text = numbernew;
    self.LogModel.XLnumber = numbernew;
    
}
//加
- (IBAction)clickPlus:(id)sender {
    
    NSInteger number =  [self.LogModel.XLnumber integerValue];
    if(NO){
       //不是数字 结束
        return;
    }
    number ++ ;
    NSString *numbernew = [NSString stringWithFormat:@"%i",number];
    self.fieldNumber.text = numbernew;
    self.LogModel.XLnumber = numbernew;
   
}
    

- (IBAction)selectAction:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    if (sender.tag == 201) {
        //始
        WEAK_SELF;
        EditorAddressVC *addressVC = [[EditorAddressVC alloc] init];
        [addressVC setStartSelectSuccessBlock:^(AddressModel *model){
            weakSelf.LogModel.addressID1 = model.ad_id;
            weakSelf.addressName1.hidden = NO;
            weakSelf.addressDetalis1.hidden = NO;
            weakSelf.addressplaceholder1 .hidden = YES;
            
            weakSelf.addressName1.text = [NSString stringWithFormat:@"%@    %@",model.ad_consignee,model.ad_consignee_phone];
            weakSelf.addressDetalis1.text = model.ad_get_address;
            weakSelf.addressplaceholder1.text = @"";
        }];
        [self.navigationController pushViewController:addressVC animated:YES];
    }else if (sender.tag == 202){
        //终
        WEAK_SELF;
        EditorAddressVC *addressVC = [[EditorAddressVC alloc] init];
        [addressVC setEndSelectSuccessBlock:^(AddressModel *model){
            weakSelf.LogModel.addressID2 = model.ad_id;
            weakSelf.addressName2.hidden = NO;
            weakSelf.addressDetalis2.hidden = NO;
            weakSelf.addressplaceholder2 .hidden = YES;
            
            weakSelf.addressName2.text = [NSString stringWithFormat:@"%@    %@",model.ad_consignee,model.ad_consignee_phone];
            weakSelf.addressDetalis2.text = model.ad_get_address;
            weakSelf.addressplaceholder2.text = @"";
        }];
        [self.navigationController pushViewController:addressVC animated:YES];
    }else if (sender.tag == 203){
        //下单  下单成功到 支付方式界面
        if(!kStringIsEmpty(self.LogModel.addressID1)){
            [MBManager showBriefAlert:NSBundleLocalizedString(@"请选择发货地址")];
            return;
        }
        if(!kStringIsEmpty(self.LogModel.addressID2)){
            [MBManager showBriefAlert:NSBundleLocalizedString(@"请选择收货地址")];
            return;
        }
        if([self.LogModel.addressID1 isEqualToString:self.LogModel.addressID2]){
            [MBManager showBriefAlert:NSBundleLocalizedString(@"发货地址与收货地址相同")];
            return;
        }
        if(!kStringIsEmpty(self.LogModel.time)){
            [MBManager showBriefAlert:NSBundleLocalizedString(@"请选择托运日期")];
            return;
        }
        if(!kStringIsEmpty(self.LogModel.XLnumber)){
            [MBManager showBriefAlert:NSBundleLocalizedString(@"请输入行李数量")];
            return;
        }
        if(!kStringIsEmpty(self.LogModel.XLname)){
            [MBManager showBriefAlert:NSBundleLocalizedString(@"请输入行李名称")];
            return;
        }
        if(!kStringIsEmpty(self.LogModel.XLsize)){
            [MBManager showBriefAlert:NSBundleLocalizedString(@"请输入行李体积")];
            return;
        }
        if(!kStringIsEmpty(self.LogModel.XLkg)){
            [MBManager showBriefAlert:NSBundleLocalizedString(@"请输入行李重量")];
            return;
        }
        if(!kStringIsEmpty(self.LogModel.ol_deposit)){
            [MBManager showBriefAlert:NSBundleLocalizedString(@"请等待计算")];
            return;
        }
        if(!kStringIsEmpty(self.LogModel.ol_tail_money)){
            [MBManager showBriefAlert:NSBundleLocalizedString(@"请等待计算")];
            return;
        }
        
        WEAK_SELF;
        [AFHTTP requesAddlogisticsorderOl_begin_address:self.LogModel.addressID1
                                         ol_end_address:self.LogModel.addressID2 ol_consignment_time:self.LogModel.time ol_luggage_count:self.LogModel.XLnumber ol_luggage_name:self.LogModel.XLname ol_luggage_volume:self.LogModel.XLsize ol_luggage_weight:self.LogModel.XLkg ol_deposit:self.LogModel.ol_deposit ol_tail_money:self.LogModel.ol_tail_money success:^(NSDictionary *dic){
                                             
                                             NSString *order_id = dic[@"order_code"];
                                             if(kStringIsEmpty(order_id)){
                                                 //下单成功
                                                 [weakSelf requestPaymentorder_id:order_id];
                                             }
                                            
                                         } failure:^(NSError *error){
                                             
                                         }];
    }
}


- (void)requestPaymentorder_id:(NSString *)order_id{
    
//    PaymentWebViewController *vc = [[PaymentWebViewController alloc]init];
//    vc.order_id = order_id;
//    vc.order_type = @"2";
//    [self.navigationController pushViewController:vc animated:YES];
    
    SelectPayTypeVC *vc = [[SelectPayTypeVC alloc] initWithNibName:@"SelectPayTypeVC" bundle:nil];
    vc.order_id = order_id;
    vc.order_type = @"2";
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
- (XBCalendar *)calendar{
    if (!_calendar) {
        _calendar = [[XBCalendar alloc] init];
        _calendar.delegate = self;
        _calendar.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT);
        
    }
    return _calendar;
}
- (LogisticsModel *)LogModel{
    if(!_LogModel){
        _LogModel = [[LogisticsModel alloc]init];
    }
    return _LogModel;
}
    
@end
