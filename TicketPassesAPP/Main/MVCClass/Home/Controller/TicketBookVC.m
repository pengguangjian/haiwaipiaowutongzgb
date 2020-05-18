//
//  TicketBookVC.m
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/30.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "TicketBookVC.h"
#import "SelectPayTypeVC.h"
#import "DHSelectSeatView.h"
#import "ContactListVC.h"
#import "SeatObj.h"
#import "ContactObj.h"
#import "GetOnOffListVC.h"
#import "BusCompanyInfoVC.h"
#import "GetOnOffObj.h"

@interface TicketBookVC ()

{
    NSArray *selectSeatArr;
    ContactObj *selectCo;
    
    GetOnOffObj *getOnObj;
    GetOnOffObj *getOffObj;
}
@property (weak, nonatomic) IBOutlet UILabel *zhan;
@property (weak, nonatomic) IBOutlet UILabel *paiojia;
@property (weak, nonatomic) IBOutlet UITextField *number;
@property (weak, nonatomic) IBOutlet UILabel *orderpr;
@property (weak, nonatomic) IBOutlet UILabel *pipoNuber;
@property (strong, nonatomic) IBOutlet UIView *contactBgView;

@property (nonatomic,strong) NSString *XLnumber;

@end

@implementation TicketBookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.getOffTextField.keyboardType = UIKeyboardTypeASCIICapable;
     //监听输入内容
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFiledEditChanged:)
                                                 name:@"UITextFieldTextDidChangeNotification"
                                               object:self.getOffTextField];
    
    
    self.view.backgroundColor =  UIColorFromHex(0xf6f6f6);
    
    self.XLnumber = @"1";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:self.model.setout_time];
    NSDateFormatter *formatterddd = [[NSDateFormatter alloc] init];
    [formatterddd setDateFormat:@"MM-dd HH:mm"];
    NSString *oneDayStr = [formatterddd stringFromDate:date];
    
    NSString *chufa = NSBundleLocalizedString(@"出发");
    NSString *titStr = [NSString stringWithFormat:@"%@%@",oneDayStr,chufa];
    self.navigationItem.title = titStr;
    
    NSString *zhannaem = [NSString stringWithFormat:@"%@-%@",self.model.start_name,self.model.end_name];
    
    self.zhan.text = zhannaem;
    
//    NSString *piaojia = NSBundleLocalizedString(@"票价");
//    NSString *jiage = [NSString stringWithFormatPrice:self.model.price];
//    NSString *pajial = [NSString stringWithFormat:@"%@%@",piaojia,jiage];
//    self.paiojia.text = pajial;
    
    NSInteger hour = [_model.duration integerValue]/60;
    NSInteger minute = [_model.duration integerValue]%60;
    NSString *totalTimeStr = @"全程时间：";
    if (hour>0) {
        totalTimeStr = [totalTimeStr stringByAppendingFormat:@"%zi小时", hour];
    }
    if (minute>0) {
        totalTimeStr = [totalTimeStr stringByAppendingFormat:@"%zi分钟", minute];
    }
    self.paiojia.text = totalTimeStr;
    
    WEAK_SELF;
    self.number.text = self.XLnumber;
    self.number.yb_inputCP = YBInputControlProfile.creat.set_textControlType(YBTextControlType_number).set_textChanged(^(UITextField *field){
        
        weakSelf.XLnumber = field.text;
        [weakSelf upddddd];
        
    });
   
    [XBUtils setViewBorderRadius:self.number Radius:16];
    
    [self upddddd];
    
    self.name.textColor = DEFAULTCOLOR1;
    self.phoneAndEmail.textColor = COL2;
    self.phoneAndEmailViewHeight.constant = 0.0f;
    self.contactView.hidden = YES;
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.frame = CGRectMake(0, 0 , DEVICE_Width-30, self.contactBgView.frame.size.height);
    layer.backgroundColor   = [UIColor clearColor].CGColor;

    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:layer.frame cornerRadius:3.0f];
    layer.path             = path.CGPath;
    layer.lineWidth         = 1.0f;
    layer.lineDashPattern    = @[@4, @4];
    layer.fillColor          = [UIColor clearColor].CGColor;
    layer.strokeColor       = DEFAULTCOLOR1.CGColor;

    [self.contactBgView.layer addSublayer:layer];
    
    [self setIsShowGetOnInputView:NO];
    [self setIsShowGetOffInputView:NO];
}

- (void)textFiledEditChanged:(NSNotification*)notification {

    UITextField *textField = notification.object;
    NSString *str = textField.text;
    for (int i = 0; i<str.length; i++) {

        NSString*string = [str substringFromIndex:i];
        NSString *regex = @"[\u4e00-\u9fa5]{0,}$"; // 中文
        // 2、拼接谓词
        NSPredicate *predicateRe1 = [NSPredicate predicateWithFormat:@"self matches %@", regex];
        // 3、匹配字符串
        BOOL resualt = [predicateRe1 evaluateWithObject:string];

        if (resualt) {
            //是中文替换为空字符串
            str =  [str stringByReplacingOccurrencesOfString:[str substringFromIndex:i] withString:@""];
        }
    }
    textField.text = str;

}


//更新票价 和人数
//- (void)upddddd{
//
//    CGFloat danjia = [self.model.price floatValue];
//    NSInteger piponumber = [self.XLnumber integerValue];
//    NSString *numdd = [NSString stringWithFormat:@"%lf",danjia*piponumber];
//    self.orderpr.text = [NSString stringWithFormatPrice:numdd];
//
//    NSString *gong = NSBundleLocalizedString(@"共");
//    NSString *ren = NSBundleLocalizedString(@"人");
//    NSString *pipoddd = [NSString stringWithFormat:@"%@%@%@",gong,self.XLnumber,ren];
//    self.pipoNuber.text = pipoddd;
//
//
//}

- (void)upddddd{
    
    if (selectSeatArr && selectSeatArr.count>0) {
        
        double totalPrice = 0;
        for (SeatObj *so in selectSeatArr) {
            totalPrice += [so.price doubleValue];
        }
        
        NSString *numdd = [NSString stringWithFormat:@"%lf",totalPrice];
        self.orderpr.text = [NSString stringWithFormatPrice:numdd];
        
        NSString *gong = NSBundleLocalizedString(@"共");
        NSString *ren = NSBundleLocalizedString(@"人");
        NSString *pipoddd = [NSString stringWithFormat:@"%@%zi%@",gong,selectSeatArr.count,ren];
        self.pipoNuber.text = pipoddd;
    } else {
        
        self.orderpr.text = [NSString stringWithFormatPrice:@"0"];
        
        NSString *gong = NSBundleLocalizedString(@"共");
        NSString *ren = NSBundleLocalizedString(@"人");
        NSString *pipoddd = [NSString stringWithFormat:@"%@0%@",gong,ren];
        self.pipoNuber.text = pipoddd;
    }
}

- (IBAction)clickJJJ:(id)sender {
    NSInteger number =  [self.XLnumber integerValue];
    if(NO){
        //不是数字 结束
        return;
    }
    number ++ ;
    NSString *numbernew = [NSString stringWithFormat:@"%i",number];
    self.number.text = numbernew;
    self.XLnumber = numbernew;
    
    [self upddddd];
}
- (IBAction)clickJIAN:(id)sender {
    NSInteger number =  [self.XLnumber integerValue];
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
    self.number.text = numbernew;
    self.XLnumber = numbernew;
    
    [self upddddd];
}
- (IBAction)playeOK:(id)sender {
    
    [self.view endEditing:YES];
    
    if((!(selectSeatArr.count>0))){
        [MBManager showBriefAlert:NSBundleLocalizedString(@"请选择座位")];
        return;
    }
    
    if(!selectCo){
        [MBManager showBriefAlert:NSBundleLocalizedString(@"请选择联系人")];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"车位预约中"];
    
    
    WEAK_SELF;
//    [AFHTTP requestAddticketorderStation_begin:self.start_id station_end:self.end_id price:self.model.price setout_time:self.model.setout_time count_ticket:self.XLnumber success:^(NSDictionary *dic){
//
//
//        NSString *order_id = dic[@"order_id"];
//        if(kStringIsEmpty(order_id)){
//            //下单成功
//            [weakSelf requestPaymentorder_id:order_id];
//        }
//
//    }];
    
    HttpManager *hm = [HttpManager createHttpManager];
    
    hm.responseHandler = ^(id responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            ResponseData *rd = [ResponseData mj_objectWithKeyValues:responseObject];
            [SVProgressHUD dismiss];
            
            if ([rd.code isEqualToString:SUCCESS] ) {
                
                NSLog(@"");
                NSString *order_id = [rd.data objectForKey:@"order_code"];
                if(kStringIsEmpty(order_id)){
                    //下单成功
                    [weakSelf requestPaymentorder_id:order_id];
                }
                
            } else {
                [SVProgressHUD showErrorWithStatus:rd.msg];
            }
        });
    };
    
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
    [dataDic setObject:_model.ID forKey:@"trip_code"];
    [dataDic setObject:_seatLabel.text forKey:@"seats"];
    
    [dataDic setObject:selectCo.id forKey:@"contact_id"];
    if (getOnObj) {
        [dataDic setObject:getOnObj.id forKey:@"Pickup_id"];
        [dataDic setObject:getOnObj.name forKey:@"pickup"];
    }
    if (getOffObj) {
        [dataDic setObject:getOffObj.id forKey:@"drop_off_point_id"];
        [dataDic setObject:getOffObj.name forKey:@"drop_off_info"];
    }
    
    if (self.getOnTextField.text.length>0) {
        [dataDic setObject:self.getOffTextField.text forKey:@"pickup"];
    }
    
    if (self.getOffTextField.text.length>0) {
        [dataDic setObject:self.getOffTextField.text forKey:@"drop_off_info"];
    }
    
    [hm getRequetInterfaceData:dataDic withInterfaceName:@"/api/ticketorder/ordersubmit"];
}

- (void)requestPaymentorder_id:(NSString *)order_id{
    
//    PaymentWebViewController *vc = [[PaymentWebViewController alloc]init];
//    vc.order_id = order_id;
//    vc.order_type = @"1";
//    [self.navigationController pushViewController:vc animated:YES];
    
    //选择微信支付宝支付EnsurePayVC
    
    SelectPayTypeVC *vc = [[SelectPayTypeVC alloc] initWithNibName:@"SelectPayTypeVC" bundle:nil];
    vc.order_id = order_id;
    vc.order_type = @"1";
    vc.isFromTicket = YES;
    [self.navigationController pushViewController:vc animated:YES];

}


- (IBAction)selectSeatBtnOnTouch:(id)sender {
    
    if ([_model.unchoosable intValue] != 0) {
        
        NSString *message = @"根据公交运营商的要求，提早去公交车站的顾客可以选择自己的座位。";
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"我已知晓" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [self toSelectSeat];
            
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    } else {
        [self toSelectSeat];
    }
    
    
}

- (void)toSelectSeat {
    
    DHSelectSeatView *selectSeatView = [DHSelectSeatView sharedView:_model.ID];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:selectSeatView];
    
    __block __typeof(self)bself = self;
    selectSeatView.handler = ^(NSArray *selectArr) {
        
        selectSeatArr = selectArr;
        
        NSString *seatStr = nil;
        for (SeatObj *so in selectSeatArr) {
            if (so.seat_code) {
                if (seatStr) {
                    seatStr = [seatStr stringByAppendingString:@","];
                    seatStr = [seatStr stringByAppendingString:so.seat_code];
                } else {
                    seatStr = so.seat_code;
                }
            }
        }
        _seatLabel.text = seatStr;
        
        [bself upddddd];
        
    };
    [selectSeatView show];
    
}

- (IBAction)selectContactBtnOnTouch:(id)sender {
    
    WEAK_SELF;
    ContactListVC *contactListVC = [[ContactListVC alloc] init];
    [contactListVC setStartSelectSuccessBlock:^(ContactObj *co){
        NSLog(@"");
        selectCo = co;
        self.phoneAndEmailViewHeight.constant = 40.0f;
        self.contactView.hidden = NO;
        self.name.text = co.name;
        self.phoneAndEmail.text = [NSString stringWithFormat:@"电话：%@  邮箱：%@",co.phone,co.email];
    }];
    [self.navigationController pushViewController:contactListVC animated:YES];
    
}

- (IBAction)getOffBtnOnTouch:(id)sender {
    
    GetOnOffListVC *vc = [[GetOnOffListVC alloc] initWithNibName:@"GetOnOffListVC" bundle:nil];
    vc.trip_id = _model.ID;
    vc.titleStr = @"请选择下车点";
    vc.getOffHander = ^(id  _Nonnull obj) {
        getOffObj = obj;
        
        NSArray *componds = [getOffObj.real_time componentsSeparatedByString:@" "];
        _getOffLabel.text = [NSString stringWithFormat:@"%@ %@",[componds firstObject], getOffObj.name];
        
        if ([getOffObj.unfixed_point intValue] == 1) {
            [self setIsShowGetOffInputView:YES];
        } else {
            [self setIsShowGetOffInputView:NO];
        }
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)getOnBtnOnTouch:(id)sender {
    
    GetOnOffListVC *vc = [[GetOnOffListVC alloc] initWithNibName:@"GetOnOffListVC" bundle:nil];
    vc.trip_id = _model.ID;
    vc.titleStr = @"请选择上车点";
    vc.getONHandler = ^(id  _Nonnull obj) {
        getOnObj = obj;
        
        NSArray *componds = [getOnObj.real_time componentsSeparatedByString:@" "];
        _getOnLabel.text = [NSString stringWithFormat:@"%@ %@",[componds firstObject], getOnObj.name];
        
        if ([getOnObj.unfixed_point intValue] == 1) {
            [self setIsShowGetOnInputView:YES];
        } else {
            [self setIsShowGetOnInputView:NO];
        }
        
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)checkBusInfoBtnOnTouch:(id)sender {
    
    BusCompanyInfoVC *vc = [[BusCompanyInfoVC alloc] initWithNibName:@"BusCompanyInfoVC" bundle:nil];
    vc.trip_code = _model.trip_code;
    vc.company_id = _model.company_id;
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)setIsShowGetOnInputView:(BOOL)isShow {
    self.getOnTextField.text = nil;
    if (isShow) {
        self.getOnInputViewAlignTop.constant = 10;
        self.getOnInputViewHeight.constant = 50;
        self.getOnInputView.hidden = NO;
        self.getOnDescLabel.hidden = NO;
        self.getOnTextField.hidden = NO;
    } else {
        self.getOnInputViewAlignTop.constant = 0;
        self.getOnInputViewHeight.constant = 0;
        self.getOnInputView.hidden = YES;
        self.getOnDescLabel.hidden = YES;
        self.getOnTextField.hidden = YES;
    }
}

- (void)setIsShowGetOffInputView:(BOOL)isShow {
    self.getOffTextField.text = nil;
    if (isShow) {
        self.getOffInputViewAlignTop.constant = 10;
        self.getOffInputViewHeight.constant = 50;
        self.getOffInputView.hidden = NO;
        self.getOffDescLabel.hidden = NO;
        self.getOffTextField.hidden = NO;
    } else {
        self.getOffInputViewAlignTop.constant = 0;
        self.getOffInputViewHeight.constant = 0;
        self.getOffInputView.hidden = YES;
        self.getOffDescLabel.hidden = YES;
        self.getOffTextField.hidden = YES;
    }
}


@end
