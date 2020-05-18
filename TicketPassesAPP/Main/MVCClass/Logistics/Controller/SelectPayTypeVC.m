//
//  SelectPayTypeVC.m
//  TicketPassesAPP
//
//  Created by macbook on 2019/7/1.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import "SelectPayTypeVC.h"
#import "DHPaySuccessView.h"

#import "WXApiManager.h"
#import "WXApiRequestHandler.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>


@interface SelectPayTypeVC ()
{
    NSMutableArray *btnArr;
     int payIndex;//1:微信 2:支付宝
}
@end

@implementation SelectPayTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = NSBundleLocalizedString(@"支付方式");
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aliPayResult:) name:@"PayResult" object:nil];
    
    btnArr = [NSMutableArray arrayWithCapacity:2];
    
    [self setRadioBtn:_alipayRadioBtn];
    [self setRadioBtn:_wxRadioBtn];
    
    [_wxRadioBtn setSelected:YES];
    payIndex = 1;

    [btnArr[0] setGroupButtons:btnArr];
    
//    if (_isFromTicket) {
        _descLabel.hidden = YES;
//    }
    
    [self setNavItem];
}

- (void)setNavItem {
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [leftBtn setTitle:@"关闭" forState:UIControlStateNormal];
    if (@available(iOS 11.0, *)) {
        CGFloat offset = 8;
        leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -offset, 0, offset);
        leftBtn.translatesAutoresizingMaskIntoConstraints = false;
    }
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn setBackgroundColor:[UIColor clearColor]];
    [leftBtn addTarget:self action:@selector(closeBtnOnTouch:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -15;
    self.navigationItem.leftBarButtonItems =  @[negativeSpacer, leftItem];
    
}

- (void)closeBtnOnTouch:(id)sender {
    
    //返回首页
    [self.navigationController popToRootViewControllerAnimated:NO];
    
    UITabBarController *tabBar = (UITabBarController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
    if (_isFromOrder) {
        [tabBar setSelectedIndex:2];
    }else if (_isFromTicket) {
        [tabBar setSelectedIndex:0];
    } else {
        [tabBar setSelectedIndex:1];
    }
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 禁用返回手势
    [UIViewController popGestureClose:self];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 开启返回手势
    [UIViewController popGestureOpen:self];
}

- (void)setRadioBtn:(XSZRadioButton*)btn {
    //UIImageRenderingModeAlwaysOriginal这个枚举值是声明这张图片要按照原来的样子显示，不需要渲染成其他颜色
    UIImage *unCheckImage = [UIImage imageNamed:@"unchecked.png"];
    unCheckImage = [unCheckImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *checkImage = [UIImage imageNamed:@"checked.png"];
    checkImage = [checkImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [btn addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [btn setImage:unCheckImage forState:UIControlStateNormal];
    [btn setImage:checkImage forState:UIControlStateSelected];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    [btnArr addObject:btn];
    
}

- (void)onRadioButtonValueChanged:(UIButton*)btn {
    
    if (btn == _alipayRadioBtn) {
        NSLog(@"选择的类型: 支付宝");
        payIndex = 2;
    } else {
        NSLog(@"选择的类型: 微信");
        payIndex = 1;
    }
}

#pragma mark -

- (IBAction)payBtnOnTouch:(id)sender {
    
    //调用支付
    [self callPay];
}




- (void)callPay {
    
    //支付宝
    if (payIndex == 2) {
        
        HttpManager *hm = [HttpManager createHttpManager];

        hm.responseHandler = ^(id responseObject) {

            dispatch_async(dispatch_get_main_queue(), ^{

                ResponseData *rd = [ResponseData mj_objectWithKeyValues:responseObject];
                if ([rd.code isEqualToString:SUCCESS]) {
                    NSString *signedString = rd.data;
                    [self callAlipay:signedString];

                } else {
                    [SVProgressHUD showErrorWithStatus:rd.msg];
                }
            });
        };

        NSDictionary *payDic = @{@"type":@"2",
                                 @"order_type":_order_type,
                                 @"order_code":_order_id};
        [hm getRequetInterfaceData:payDic withInterfaceName:@"/api/orderpay/sendorder"];
        
    //微信
    } else if (payIndex == 1) {
        
        if (![WXApi isWXAppInstalled]) {
            [SVProgressHUD showErrorWithStatus:@"需要微信支付，请安装微信"];
            return;
        }
        [WXApiManager sharedManager].delegate = self;
        NSDictionary *payDic = @{@"type":@"1",@"order_type":_order_type,@"order_code":_order_id};
        [[WXApiRequestHandler sharedRequestHandler] jumpToBizPayWithDic:payDic];
    }
}


- (void)callAlipay:(NSString*)signedString {
    
    // NOTE: 调用支付结果开始支付
    [[AlipaySDK defaultService] payOrder:signedString fromScheme:@"TicketPassesAPP" callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
        
        NSNumber *resultStatus = [resultDic objectForKey:@"resultStatus"];
        if ([resultStatus intValue] == 9000) {
            NSDictionary *resultDictionary = [self dictionaryWithJsonString:[resultDic valueForKey:@"result"]];
            NSDictionary *alipayResponseDic = [resultDictionary valueForKey:@"alipay_trade_app_pay_response"];
            NSString *paySuccessDateTime = [alipayResponseDic valueForKey:@"timestamp"];
//            _cartOrder.paySuccessDateTime = paySuccessDateTime;
//            _cartOrder.payType = [NSNumber numberWithInt:2];
            
            [self toPayDetailVC];
        }else{
            [SVProgressHUD showErrorWithStatus:@"支付失败"];
        }
        //        resultStatus，状态码，SDK里没对应信息，第一个文档里有提到：
        //        9000 订单支付成功
        //        8000 正在处理中
        //        4000 订单支付失败
        //        6001 用户中途取消
        //        6002 网络连接出错
    }];
    
}

- (void)WXPayResult:(NSUInteger)result {
    
    if (result == WXPayResultFail) {
        [SVProgressHUD showErrorWithStatus:@"支付失败"];
    }
    if (result == WXPayResultSucess) {
        [self toPayDetailVC];
    }
        
}

#pragma mark - 通知更新
-(void)aliPayResult:(NSNotification *)Notification {
    NSString *result = [Notification valueForKey:@"object"];
    
    if ([result isEqualToString:@"ali_success"]) {
        NSDictionary *userInfoDic = [Notification valueForKey:@"userInfo"];
        NSDictionary *resultDic = [self dictionaryWithJsonString:[userInfoDic valueForKey:@"result"]];
        NSDictionary *alipayResponseDic = [resultDic valueForKey:@"alipay_trade_app_pay_response"];
        NSString *paySuccessDateTime = [alipayResponseDic valueForKey:@"timestamp"];
//        _cartOrder.paySuccessDateTime = paySuccessDateTime;
//        _cartOrder.payType = [NSNumber numberWithInt:2];
        
        [self toPayDetailVC];
        
    } else {
        [SVProgressHUD showErrorWithStatus:@"支付失败"];
    }
    
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {

    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


- (void)toPayDetailVC {
    
    DHPaySuccessView *paySuccessView = [DHPaySuccessView sharedView];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:paySuccessView];
    
    [paySuccessView show];
    
}

@end
