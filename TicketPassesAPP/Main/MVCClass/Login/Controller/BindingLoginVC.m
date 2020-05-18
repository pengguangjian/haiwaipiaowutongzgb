//
//  BindingLoginVC.m
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/8/31.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "BindingLoginVC.h"
#import "GGVerifyCodeViewBtn.h"

@interface BindingLoginVC ()

@property (weak, nonatomic) IBOutlet UITextField *iphoneTF;

@property (weak, nonatomic) IBOutlet UIView *pwdView;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UITextField *pwd2TF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *codeTop250;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *codeTop750;
@property (weak, nonatomic) IBOutlet GGVerifyCodeViewBtn *codeBtn;

@end

@implementation BindingLoginVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = NSBundleLocalizedString(@"绑定手机");
    self.pwdTF.secureTextEntry = YES;
    self.pwd2TF.secureTextEntry = YES;
    [self showPwdView:YES];
    
    
    UIButton *userAgreementBtn =[[UIButton alloc]init];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"注册即代表接受《用户注册协议》"];
    NSRange titleRange = {0,[title length]};
    [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
    [userAgreementBtn setAttributedTitle:title
                                forState:UIControlStateNormal];
    [userAgreementBtn setBackgroundColor:[UIColor whiteColor]];
    [userAgreementBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [userAgreementBtn.titleLabel setTextColor:DEFAULTCOLOR1];
    [userAgreementBtn addTarget:self action:@selector(userAgreementBtnOnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:userAgreementBtn];
    [userAgreementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).with.offset(-25-SafeAreaBottomHomeHeight);
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.mas_equalTo(@50);
    }];
    
}

- (void)userAgreementBtnOnTouch:(id)sender{
    [self.view endEditing:YES];
    WebViewController *vc = [[WebViewController alloc]init];
    vc.webType = 1;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)showPwdView:(BOOL)showPwd{
    
    if(showPwd){
        self.pwdView.hidden = YES;
        self.codeTop250.priority = 750;
        self.codeTop750.priority = 250;
    }else{
        self.pwdView.hidden = NO;
        self.codeTop250.priority = 250;
        self.codeTop750.priority = 750;
    }
    
}
- (IBAction)codeAction:(id)sender {
    [self.view endEditing:YES];
    if(![XBUtils isPhone:self.iphoneTF.text]){
        [MBManager showBriefAlert:NSBundleLocalizedString(@"请输入手机号码")];
        return;
    }
    // 验证手机号后在发送验证码
    [self requestcheckphone:@"code"];
    
}
- (IBAction)loginAction:(id)sender {
    [self.view endEditing:YES];
    if(![XBUtils isPhone:self.iphoneTF.text]){
        [MBManager showBriefAlert:NSBundleLocalizedString(@"请输入手机号码")];
        return;
    }
    if(!kStringIsEmpty(self.codeTF.text)){
        [MBManager showBriefAlert:NSBundleLocalizedString(@"请输入验证码")];
        return;
    }
    if(!self.pwdView.hidden){
        //密码框出现 说明手机号码不存在，并要验证密码
        if(!kStringIsEmpty(self.pwdTF.text)){
            [MBManager showBriefAlert:NSBundleLocalizedString(@"请输入密码")];
            return;
        }
        if(![self.pwdTF.text isEqualToString:self.pwd2TF.text]){
            [MBManager showBriefAlert:NSBundleLocalizedString(@"两次密码不一致")];
            return;
        }
        //展开 调用绑定接口 说明手机号码不存在 可以直接绑定
        if([self.type isEqualToString:@"zalo"]){
            //绑定 zalo
            [self requestzalobandphone];
        }else if([self.type isEqualToString:@"WX"]){
            //绑定 WX
            [self requestWXbandphone];
        }else if([self.type isEqualToString:@"QQ"]){
            //绑定 QQ
            [self requestQQbandphone];
        }else if([self.type isEqualToString:@"Apple"]){
            //绑定 Apple
            [self requestApplebandphone];
        }else{
            //绑定 fackbook
            [self requestFbbandphone];
        }
    }else{
        [self requestcheckphone:@"login"];
    }
    
}

- (void)requestcheckphone:(NSString *)successkey{
    
    WEAK_SELF;
    [AFHTTP requestcheckphone:self.iphoneTF.text success:^(id responseObject) {
        //1手机号码不存在 2脸书账号未绑定 3zalo未绑定 4均未绑定
        NSInteger  status = [responseObject[@"status"] integerValue];
        if(status == 1){
            [weakSelf showPwdView:NO];
        }else{
            //继续绑定操作
            if([successkey isEqualToString:@"login"]){
             //判断是否被绑定了
                if([weakSelf.type isEqualToString:@"zalo"]){
                    if(status == 3 ||  status == 4){
                        //绑定 zalo
                        [weakSelf requestzalobandphone];
                    }else{
                        //zalo 已绑定
                        [MBManager showBriefAlert:NSBundleLocalizedString(@"账号已绑定Zalo")];
                    }
                }else if([weakSelf.type isEqualToString:@"WX"]){
                    if(status == 3 ||  status == 4){
                        //绑定 zalo
                        [weakSelf requestWXbandphone];
                    }else{
                        //zalo 已绑定
                        [MBManager showBriefAlert:NSBundleLocalizedString(@"账号已绑定QQ")];
                    }
                }else if([weakSelf.type isEqualToString:@"QQ"]){
                    if(status == 3 ||  status == 4){
                        //绑定 zalo
                        [weakSelf requestQQbandphone];
                    }else{
                        //zalo 已绑定
                        [MBManager showBriefAlert:NSBundleLocalizedString(@"账号已绑定WX")];
                    }
                }else if([weakSelf.type isEqualToString:@"Apple"]){
                    if(status == 3 ||  status == 4){
                        //绑定 zalo
                        [weakSelf requestApplebandphone];
                    }else{
                        //zalo 已绑定
                        [MBManager showBriefAlert:NSBundleLocalizedString(@"账号已绑定Apple")];
                    }
                }else{
                    if(status == 2 ||  status == 4){
                        //绑定 fackbook
                        [weakSelf requestFbbandphone];
                    }else{
                        //fackbook 已绑定
                        [MBManager showBriefAlert:NSBundleLocalizedString(@"账号已绑定Facebook")];
                    }
                }
            }
        }
        //不管是否展开密码 都发送验证码
        if([successkey isEqualToString:@"code"]){
            //继续发生验证码
            [weakSelf fasongyanzengma];
        }
        
    }];
}
- (void)fasongyanzengma{
    WEAK_SELF;
    [AFHTTP requestSmscodePhone:self.iphoneTF.text status:@"4" success:^(id responseObject){
        [weakSelf.codeBtn timeFailBeginFrom:60];
    }];
}

- (void)requestWXbandphone{

    //            fb_id   脸书编号
    //            iconurl 头像
    //            fb_name 脸书昵称
    WEAK_SELF;
    [AFHTTP requestWXbandphone:self.iphoneTF.text
                      password:self.pwdTF.text
                   verify_code:self.codeTF.text
                         wx_id:self.prom[@"wx_id"]
                    wx_unionid:self.prom[@"wx_unionid"]
                       iconurl:self.prom[@"iconurl"]
                       wx_name:self.prom[@"wx_name"]
                       success:^(id responseObject) {
        
        NSLog(@"requestFbbandphone = %@",responseObject);
        
    }];
}

- (void)requestQQbandphone {

    //            fb_id   脸书编号
    //            iconurl 头像
    //            fb_name 脸书昵称
    WEAK_SELF;
    [AFHTTP requestQQbandphone:self.iphoneTF.text
                      password:self.pwdTF.text
                   verify_code:self.codeTF.text
                         qq_id:self.prom[@"qq_id"]
                       iconurl:self.prom[@"iconurl"]
                       qq_name:self.prom[@"qq_name"]
                       success:^(id responseObject) {
        
        NSLog(@"requestFbbandphone = %@",responseObject);
        
    }];
}

- (void)requestApplebandphone {

    //            fb_id   脸书编号
    //            iconurl 头像
    //            fb_name 脸书昵称
    WEAK_SELF;
    [AFHTTP requestApplebandphone:self.iphoneTF.text
                      password:self.pwdTF.text
                   verify_code:self.codeTF.text
                         apple_id:self.prom[@"apple_id"]
                       success:^(id responseObject) {
        
        NSLog(@"requestFbbandphone = %@",responseObject);
        
    }];
}

- (void)requestFbbandphone{

    //            fb_id   脸书编号
    //            iconurl 头像
    //            fb_name 脸书昵称
    WEAK_SELF;
    [AFHTTP requestFbbandphone:self.iphoneTF.text
                      password:self.pwdTF.text
                   verify_code:self.codeTF.text
                         fb_id:self.prom[@"fb_id"]
                       iconurl:self.prom[@"iconurl"]
                       fb_name:self.prom[@"fb_name"]
                       success:^(id responseObject) {
        
        NSLog(@"requestFbbandphone = %@",responseObject);
        
    }];
}
- (void)requestzalobandphone{
    
    //zalo_id zali用户编号
    //picture zalo头像
    //gender zalo性别
    //zalo_name zalo昵称
    //birthday 生日
    WEAK_SELF;
    [AFHTTP requestzalobandphone:self.iphoneTF.text
                        password:self.pwdTF.text
                     verify_code:self.codeTF.text
                         zalo_id:self.prom[@"zalo_id"]
                       zalo_name:self.prom[@"zalo_name"]
                         picture:self.prom[@"picture"]
                          gender:self.prom[@"gender"]
                        birthday:self.prom[@"birthday"]
                         success:^(id responseObject) {
        
        NSLog(@"requestzalobandphone = %@",responseObject);
        
    }];
}


@end
