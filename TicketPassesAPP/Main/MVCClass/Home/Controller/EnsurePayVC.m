//
//  EnsurePayVC.m
//  XiaoShunZiAPP
//
//  Created by Mac on 2018/6/4.
//  Copyright © 2018年 XiaoShunZi. All rights reserved.
//

#import "EnsurePayVC.h"
#import "TPKeyboardAvoidingTableView.h"
#import "AppDelegate.h"

#import "WXApiManager.h"
#import "WXApiRequestHandler.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>

#import "PayMetodeCell.h"
#import "DHPaySuccessView.h"


@interface EnsurePayVC ()
{
    TPKeyboardAvoidingTableView *payMethodTableView;
    
    int payIndex;//1:微信 2:支付宝
    
    UIView *bgView;
    int bgViewHeight;
}
@end

@implementation EnsurePayVC


- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aliPayResult:) name:@"PayResult" object:nil];

    payIndex = 1;//默认微信
    
    [self initView];
    
    self.navigationItem.hidesBackButton = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [Util setNavigationBar:self.navigationController.navigationBar andBackgroundColor:[UIColor clearColor] andIsShowSplitLine:YES];

    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    [Util setNavigationBar:self.navigationController.navigationBar andBackgroundColor:[UIColor whiteColor] andIsShowSplitLine:NO];
    
}


- (void)initView {
    
    bgViewHeight = 400;
    
    
    bgView = [[UIView alloc] init];
    [bgView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(DEVICE_Height);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.equalTo(@(bgViewHeight));
    }];
    
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = COL1;
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.text = @"确认付款";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).with.offset(0);
        make.top.equalTo(bgView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(DEVICE_Width, 49.5));
    }];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [closeBtn addTarget:self action:@selector(closeBtnOnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setBackgroundColor:[UIColor clearColor]];
    UIImage *btnImage = [UIImage imageNamed:@"nav_close_gray"];
    //UIImageRenderingModeAlwaysOriginal这个枚举值是声明这张图片要按照原来的样子显示，不需要渲染成其他颜色
    btnImage = [btnImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //setImage 是会渲染的
    [closeBtn setImage:btnImage forState:UIControlStateNormal];
    btnImage = [UIImage imageNamed:@"nav_close_gray"];
    btnImage = [btnImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [closeBtn setImage:btnImage forState:UIControlStateSelected];
    [bgView addSubview:closeBtn];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).with.offset(0);
        make.top.equalTo(bgView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(49, 49));
    }];
    
    UIView *titleLineView = [[UIView alloc] init];
    [titleLineView setBackgroundColor:SEPARATORCOLOR];
    [bgView addSubview:titleLineView];
    [titleLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).with.offset(0);
        make.left.equalTo(bgView).with.offset(0);
        make.right.equalTo(bgView).with.offset(0);
        make.height.mas_equalTo(@0.5);
    }];
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.textColor = COL1;
    priceLabel.font = [UIFont systemFontOfSize:30];
    priceLabel.text = @"¥100.0f";//[NSString stringWithFormat:@"¥%.2f",[_cartOrder.payAmount floatValue]];
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).with.offset(0);
        make.top.equalTo(titleLineView.mas_bottom).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(DEVICE_Width, 70));
    }];
    
    
    float height = 150;
    
    payMethodTableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectMake(0, 120, DEVICE_Width, height) style:UITableViewStylePlain];
    
    payMethodTableView.delegate = self;
    payMethodTableView.dataSource = self;
    payMethodTableView.backgroundColor = RGB(248, 248, 248);
    payMethodTableView.separatorColor = SEPARATORCOLOR;
    payMethodTableView.showsVerticalScrollIndicator = NO;
    payMethodTableView.scrollEnabled = NO;
    if (@available(iOS 11.0, *)) {
        payMethodTableView.estimatedRowHeight = 0;
        payMethodTableView.estimatedSectionHeaderHeight = 0;
        payMethodTableView.estimatedSectionFooterHeight = 0;
        
        payMethodTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        payMethodTableView.scrollIndicatorInsets = self.tableView.contentInset;
    }
    if (@available(iOS 11.0, *)) {
        payMethodTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [bgView addSubview:payMethodTableView];
    
    UIView *lineView = [[UIView alloc] init];
    [lineView setBackgroundColor:SEPARATORCOLOR];
    [bgView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(payMethodTableView.mas_bottom).with.offset(0);
        make.left.equalTo(bgView).with.offset(16);
        make.right.equalTo(bgView).with.offset(0);
        make.height.mas_equalTo(@0.5);
    }];
    
    
    UIButton *ensureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [ensureBtn addTarget:self action:@selector(ensureBtnOnTouch:) forControlEvents:UIControlEventTouchUpInside];
    ensureBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [ensureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ensureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [ensureBtn setBackgroundColor:DEFAULTCOLOR2];
    [ensureBtn.layer setMasksToBounds:YES];
    [ensureBtn.layer setCornerRadius:5.0f];
    ensureBtn.xsz_acceptEventInterval = 1;
    [ensureBtn gradientButtonWithSize:CGSizeMake(DEVICE_Width-60, 50) colorArray:@[(id)DEFAULTCOLOR1,(id)DEFAULTCOLOR2] percentageArray:@[@(0.18),@(1)] gradientType:GradientFromLeftToRight];
    [bgView addSubview:ensureBtn];
    [ensureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bgView).with.offset(-30);
        make.left.equalTo(bgView).with.offset(30);
        make.right.equalTo(bgView).with.offset(-30);
        make.height.mas_equalTo(@50);
    }];
    
    
    
    [self show];
    
}





- (void)show
{
    [UIView animateWithDuration:0.5 animations:^{
        bgView.layer.transform = CATransform3DMakeTranslation(0, -bgViewHeight, 0);
        
    } completion:^(BOOL finished){
        
    }];
    
}


- (void)ensureBtnOnTouch:(id)sender {
    
    //调用支付
    [self callPay];
    
}






- (void)toPayDetailVC {
    
    DHPaySuccessView *paySuccessView = [DHPaySuccessView sharedView];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:paySuccessView];
    
    [paySuccessView show];
    
}


//- (void)useCoupon {
//
//    HttpManager *hm = [HttpManager createHttpManager];
//    hm.responseHandler = ^(id responseObject) {
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            ResponseData *rd = [ResponseData mj_objectWithKeyValues:responseObject];
//
//            if ([rd.code isEqualToString:SUCCESS] && [rd.sub_code isEqualToString:SUCCESS]) {
//                [self toPayDetailVC];
//            } else {
//                [SVProgressHUD showErrorWithStatus:rd.sub_msg];
//            }
//        });
//    };
//
//    NSMutableDictionary *dataDic = @{@"id":[CreateOrderManager sharedCreateOrderManager].co.id
//                                     };
//
//    [hm getRequetInterfaceData:dataDic withInterfaceName:@"coupon/use"];
//}

- (void)backRootVC {
    
    

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

    [Util setNavigationBar:self.navigationController.navigationBar andBackgroundColor:[UIColor whiteColor] andIsShowSplitLine:NO];
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: COL1,
                                                                    UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};

    [self.navigationController popToRootViewControllerAnimated:NO];
    
    //选择订单
    UITabBarController *tabBar = (UITabBarController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
    [tabBar setSelectedIndex:2];
    
}

- (void)closeBtnOnTouch:(id)sender {
    
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    
    NSString *message = @"你确定要取消支付？";//[NSString stringWithFormat:app.appcw.Unpaid];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];

    [alert addAction:[UIAlertAction actionWithTitle:@"确定取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

        dispatch_async(dispatch_get_main_queue(), ^{

             [self backRootVC];
        });


    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"再想想" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {

    }]];

    [self presentViewController:alert animated:YES completion:nil];
    
}


#pragma mark - tableView代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row == 0) {
        static NSString *CustomCellIdentifier = @"PayMethodCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CustomCellIdentifier];
        }
        
        cell.textLabel.textColor = COL1;
        cell.textLabel.font = [UIFont systemFontOfSize:16.0];
        
        cell.detailTextLabel.textColor = COL2;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15.0];
        
//        OrderProduct *pro = [_cartOrder.skuList firstObject];
        cell.textLabel.text = @"订单信息";
        cell.detailTextLabel.text = @"";//pro.productName;
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell setHeight:50];
        
        return cell;
    }
    
    
    
    static NSString *CustomCellIdentifier = @"PayMetodeCell";
    PayMetodeCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    
    if (!cell)
    {
        UINib *nib = [UINib nibWithNibName:CustomCellIdentifier bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CustomCellIdentifier];
        cell = (PayMetodeCell *)[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    }
    
    cell.selectStatusImageView.hidden = YES;
    
    if (indexPath.row == 1) {
        cell.payMethodImageView.image = [UIImage imageNamed:@"pay_icon_weixin"];
        cell.payMethodLabel.text = @"微信";
        
    } else if(indexPath.row == 2){
        cell.payMethodImageView.image = [UIImage imageNamed:@"pay_icon_alipay"];
        cell.payMethodLabel.text = @"支付宝";
        
    }
    
    if(payIndex == indexPath.row) {
        cell.selectStatusImageView.hidden = NO;
    }
    
    cell.descLabel.text = @"";
    
    
    cell.selectStatusImageView.image = [UIImage imageNamed:@"pay_icon_tick"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell setHeight:50];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.000001;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000001;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中状态
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.row>0) {
        
        
        payIndex = indexPath.row;
        [payMethodTableView reloadData];
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

/**
 *  分割线的处理
 */
-(void)viewDidLayoutSubviews {
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 15, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 0)];
    }
    
}



#pragma mark -


- (void)callPay {
    
    //支付宝
    if (payIndex == 2) {
        
//        HttpManager *hm = [HttpManager createHttpManager];
//        
//        hm.responseHandler = ^(id responseObject) {
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                ResponseData *rd = [ResponseData mj_objectWithKeyValues:responseObject];
//                if ([rd.code isEqualToString:SUCCESS] && [rd.sub_code isEqualToString:SUCCESS]) {
//                    NSString* signedString = rd.data;
//                    [self callAlipay:signedString];
//                    
//                } else {
//                    [SVProgressHUD showErrorWithStatus:rd.sub_msg];
//                }
//            });
//        };
//        
//        NSDictionary *payDic = @{@"type":@"1", @"orderNum":_cartOrder.orderno};
//        [hm getRequetInterfaceData:payDic withInterfaceName:@"orderpay/sendorder"];
        
    //微信
    } else if (payIndex == 1) {
        
        if (![WXApi isWXAppInstalled]) {
            [SVProgressHUD showErrorWithStatus:@"需要微信支付，请安装微信"];
            return;
        }
//        [WXApiManager sharedManager].delegate = self;
//        NSDictionary *payDic = @{@"type":@"2",@"orderNum":_cartOrder.orderno};
//        [[WXApiRequestHandler sharedRequestHandler] jumpToBizPayWithDic:payDic];
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

@end
