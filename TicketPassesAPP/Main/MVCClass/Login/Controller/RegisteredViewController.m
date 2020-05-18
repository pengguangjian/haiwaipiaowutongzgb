//
//  RegisteredViewController.m
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/13.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "RegisteredViewController.h"
#import "GGVerifyCodeViewBtn.h"
#import "BindingLoginVC.h"
#import "LoginVC.h"
#import "ThirdPlatformLogin.h"
#import "BindingLoginVC.h"
#import <AuthenticationServices/AuthenticationServices.h>

@interface RegisteredViewController ()
 {
    SSDKUser *ssdkUser;
}

@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *pwaTF;
@property (weak, nonatomic) IBOutlet UITextField *pwa2TF;
@property (weak, nonatomic) IBOutlet UIButton *tongyi;

@property (weak, nonatomic) IBOutlet GGVerifyCodeViewBtn *codeBtn;


@property (weak, nonatomic) IBOutlet UIButton *but1;
@property (weak, nonatomic) IBOutlet UIButton *but2;
@property (weak, nonatomic) IBOutlet UIButton *but3;

@end

@implementation RegisteredViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.but1 setTitleColor:UIColorFromRGB(130, 130, 130) forState:UIControlStateNormal];
    [self.but1 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.but2 setTitleColor:UIColorFromRGB(130, 130, 130) forState:UIControlStateNormal];
    [self.but2 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.but3 setTitleColor:UIColorFromRGB(130, 130, 130) forState:UIControlStateNormal];
    [self.but3 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    [self upLanguageBut];
    
    self.pwaTF.secureTextEntry = YES;
    self.pwa2TF.secureTextEntry = YES;
    
    [self.tongyi setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    [self.tongyi setImage:[UIImage imageNamed:@"check"] forState:UIControlStateSelected];
    self.tongyi.selected = YES;
    
    [self setupTextFilePlaceholder:NSBundleLocalizedString(@"请输入手机号码") andTextFile:self.phoneTF];
    
    [self setupTextFilePlaceholder:NSBundleLocalizedString(@"请输入密码") andTextFile:self.pwaTF];
    
    [self setupTextFilePlaceholder:NSBundleLocalizedString(@"请再次输入密码") andTextFile:self.pwa2TF];
    
    [self setupTextFilePlaceholder:NSBundleLocalizedString(@"请输入验证码") andTextFile:self.codeTF];
    
    if (@available(iOS 13.0, *)) {
           // Sign In With Apple Button
        ASAuthorizationAppleIDButton *appleIDBtn = [ASAuthorizationAppleIDButton buttonWithType:ASAuthorizationAppleIDButtonTypeDefault style:ASAuthorizationAppleIDButtonStyleWhite];
        appleIDBtn.frame = CGRectMake(0, 0, 40, 40);
        appleIDBtn.layer.cornerRadius = 20.0f;
        [appleIDBtn addTarget:self action:@selector(handleAuthorizationAppleIDButtonPress) forControlEvents:UIControlEventTouchUpInside];
        [_otherLoginView insertArrangedSubview:appleIDBtn atIndex:0];
    
    }
    
}

- (void)upLanguageBut{
    self.but1.selected = NO;
    self.but2.selected = NO;
    self.but3.selected = NO;
    LanguageKey key = [NSBundle getLanguagekey];
    if(key == LanguageVI){
        self.but1.selected = YES;
    }else if (key == LanguageZH){
        self.but2.selected = YES;
    }else{
        self.but3.selected = YES;
    }
}
- (void)setupTextFilePlaceholder:(NSString *)titleStr andTextFile:(UITextField *)textFile{
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:titleStr];
    [placeholder addAttribute:NSForegroundColorAttributeName value:COL3 range:NSMakeRange(0, titleStr.length)];
    [placeholder addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(0, titleStr.length)];
    textFile.attributedPlaceholder = placeholder;
}

- (IBAction)codeAction:(id)sender {
    [self.view endEditing:YES];
    if(![XBUtils isPhone:self.phoneTF.text]){
        [MBManager showBriefAlert:NSBundleLocalizedString(@"请输入手机号码")];
        return;
    }
    WEAK_SELF;
    [AFHTTP requestSmscodePhone:self.phoneTF.text status:@"1" success:^(id responseObject){
        [weakSelf.codeBtn timeFailBeginFrom:60];
    }];
}
- (IBAction)tongyiClcik:(id)sender {
    
    if(self.tongyi.selected){
        self.tongyi.selected = NO;
    }else{
        self.tongyi.selected = YES;
    }
    
}
- (IBAction)loginAction:(id)sender {
    [self.view endEditing:YES];
    [XBUtils SYSRootController:[LoginVC class]];
}
- (IBAction)protocolClick:(id)sender {
    [self.view endEditing:YES];
    WebViewController *vc = [[WebViewController alloc]init];
    vc.webType = 1;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)regisereClicj:(id)sender {
    [self.view endEditing:YES];
    if(!self.tongyi.selected){
        [MBManager showBriefAlert:NSBundleLocalizedString(@"您还没用同意用户注册协议")];
        return;
    }
    if(!kStringIsEmpty(self.pwaTF.text)){
        [MBManager showBriefAlert:NSBundleLocalizedString(@"请输入密码")];
        return;
    }
    if(![self.pwaTF.text isEqualToString:self.pwa2TF.text]){
        [MBManager showBriefAlert:NSBundleLocalizedString(@"两次密码不一致")];
        return;
    }
    if(![XBUtils isPhone:self.phoneTF.text]){
        [MBManager showBriefAlert:NSBundleLocalizedString(@"请输入手机号码")];
        return;
    }
    if(!kStringIsEmpty(self.codeTF.text)){
        [MBManager showBriefAlert:NSBundleLocalizedString(@"请输入验证码")];
        return;
    }
    [AFHTTP requestRegistPhone:self.phoneTF.text password:self.pwaTF.text andCode:self.codeTF.text];
}

- (IBAction)languageChlick:(UIButton *)sender {
    [self.view endEditing:YES];
    if (sender.tag == 201) {
        if([NSBundle getLanguagekey] == LanguageVI){
            return;
        }
        [NSBundle setLanguage:LanguageVI];
    } else if (sender.tag == 202) {
        if([NSBundle getLanguagekey] == LanguageZH){
            return;
        }
        [NSBundle setLanguage:LanguageZH];
    } else if (sender.tag == 203) {
        if([NSBundle getLanguagekey] == LanguageEN){
            return;
        }
        [NSBundle setLanguage:LanguageEN];
    }
    [XBUtils SYSResetRootController];
}
- (IBAction)qitalonginClick:(UIButton *)sender {
    [self.view endEditing:YES];
//    if(sender.tag == 100){
//        [self getUserInfoForFB];
//    }else{
//        [self getUserInfoForZalo];
//    }
    
    if(sender.tag == 100){
        [self getUserInfoForWX];
    }else{
        [self getUserInfoForQQ];
    }
    
}

- (void)requestZalologin:(NSString *)uid zalopram:(NSDictionary *)zalopram{
    WEAK_SELF;
    [AFHTTP requestZalologinzalo_id:uid success:^(id responseObject) {
        //进入绑定界面
        [weakSelf goBindingLoginVC:@"zalo" prom:zalopram];
        
    }];
}
- (void)requestFacebooklogin:(NSString *)uid Faceprom:(NSDictionary *)faceprom{
    WEAK_SELF;
    [AFHTTP requestFacebookloginfb_id:uid success:^(id responseObject) {
        //进入绑定界面
        [weakSelf goBindingLoginVC:@"fackbook" prom:faceprom];
    }];
}
- (void)goBindingLoginVC:(NSString *)type prom:(NSDictionary *)prom{
    BindingLoginVC *vc = [[BindingLoginVC alloc]init];
    vc.type = type;
    vc.prom = prom;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)requestApplelogin:(NSString *)uid appleprom:(NSDictionary *)appleprom{
    WEAK_SELF;
    [AFHTTP requestAppleloginApple_id:uid success:^(id responseObject) {
        //进入绑定界面
        [weakSelf goBindingLoginVC:@"Apple" prom:appleprom];
    }];
}


- (void)getUserInfoForFB
{
    WEAK_SELF;
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Facebook currentViewController:nil completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *resp = result;
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        if(error){
            [MBManager showBriefAlert:NSBundleLocalizedString(@"取消登录")];
        }else{
            
            //            fb_id   脸书编号
            //            iconurl 头像
            //            fb_name 脸书昵称
            
            NSMutableDictionary *bacebookpram = [[NSMutableDictionary alloc]init];
            [bacebookpram setValue:resp.uid forKey:@"fb_id"];
            [bacebookpram setValue:resp.iconurl forKey:@"iconurl"];
            [bacebookpram setValue:resp.name forKey:@"fb_name"];
            
            [weakSelf requestFacebooklogin:resp.uid Faceprom:bacebookpram];
        }
        
        
    }];
}

- (void)getUserInfoForZalo
{
    WEAK_SELF;
    [[ZaloSDK sharedInstance] authenticateZaloWithAuthenType:ZAZAloSDKAuthenTypeViaZaloAppAndWebView parentController:self
                                                     handler:^(ZOOauthResponseObject *response) {
                                                         if([response isSucess]) {
                                                             
                                                             //zalo_id zali用户编号
                                                             //picture zalo头像
                                                             //gender zalo性别
                                                             //zalo_name zalo昵称
                                                             //birthday 生日
                                                             
                                                             NSMutableDictionary *zalopram = [[NSMutableDictionary alloc]init];
                                                             [zalopram setValue:response.userId forKey:@"zalo_id"];
                                                             [zalopram setValue:response.displayName forKey:@"zalo_name"];
                                                             [zalopram setValue:@"" forKey:@"picture"];
                                                             [zalopram setValue:response.gender forKey:@"gender"];
                                                             [zalopram setValue:response.dob forKey:@"birthday"];
                                                             
                                                             [weakSelf requestZalologin:response.userId zalopram:zalopram];
                                                             
                                                         } else{
                                                             
                                                             [MBManager showBriefAlert:NSBundleLocalizedString(@"取消登录")];
                                                         }
                                                     }];
}


- (void)requestQQlogin:(NSString *)uid Faceprom:(NSDictionary *)qqprom{
    WEAK_SELF;
    [AFHTTP requestQQloginqq_id:uid success:^(id responseObject) {
        //进入绑定界面
        [weakSelf goBindingLoginVC:@"QQ" prom:qqprom];
    }];
}

- (void)requestWXlogin:(NSString *)uid Faceprom:(NSDictionary *)wxprom{
    WEAK_SELF;
    [AFHTTP requestWXloginwx_id:uid success:^(id responseObject) {
        //进入绑定界面
        [weakSelf goBindingLoginVC:@"WX" prom:wxprom];
    }];
}







- (void)getUserInfoForWX {
    
    WEAK_SELF;
    ThirdPlatformLogin *tpl = [ThirdPlatformLogin sharedThirdPlatformLogin];
    tpl.thirdPlatformLoginHandler = ^(SSDKUser *user) {
        
        NSLog(@"uid=%@",user.uid);
        NSLog(@"%@",user.credential);
        NSLog(@"token=%@",user.credential.token);
        NSLog(@"nickname=%@",user.nickname);
        
        NSMutableDictionary *rowData = [user.rawData mutableCopy];
        NSString *unionid = [rowData objectForKey:@"unionid"];
        
        NSString *openid = [rowData objectForKey:@"openid"];
        
        user.credential.token = openid;
        
        ssdkUser = user;
        
        NSMutableDictionary *wxpram = [[NSMutableDictionary alloc]init];
        [wxpram setValue:user.uid forKey:@"wx_id"];
        [wxpram setValue:unionid forKey:@"wx_unionid"];
        [wxpram setValue:user.icon forKey:@"iconurl"];
        [wxpram setValue:user.nickname forKey:@"wx_name"];
        
        [weakSelf requestWXlogin:unionid Faceprom:wxpram];
        
    };
    [tpl loginWechat];
    

    
}

- (void)getUserInfoForQQ
{
    WEAK_SELF;
    ThirdPlatformLogin *tpl = [ThirdPlatformLogin sharedThirdPlatformLogin];
    tpl.thirdPlatformLoginHandler = ^(SSDKUser *user) {
        
        NSLog(@"uid=%@",user.uid);
        NSLog(@"%@",user.credential);
        NSLog(@"token=%@",user.credential.token);
        NSLog(@"nickname=%@",user.nickname);
        
        ssdkUser = user;
        
        NSMutableDictionary *qqpram = [[NSMutableDictionary alloc]init];
        [qqpram setValue:user.uid forKey:@"qq_id"];
        [qqpram setValue:user.icon forKey:@"iconurl"];
        [qqpram setValue:user.nickname forKey:@"qq_name"];
        
        [weakSelf requestQQlogin:user.uid Faceprom:qqpram];
        
    };
    [tpl loginQQ];
    
}

#pragma mark -

- (void)handleAuthorizationAppleIDButtonPress {
    if (@available(iOS 13.0, *)) {
        // 基于用户的Apple ID授权用户，生成用户授权请求的一种机制
        ASAuthorizationAppleIDProvider *appleIDProvider = [[ASAuthorizationAppleIDProvider alloc] init];
        // 创建新的AppleID 授权请求
        ASAuthorizationAppleIDRequest *appleIDRequest = [appleIDProvider createRequest];
        // 在用户授权期间请求的联系信息
        appleIDRequest.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
        // 由ASAuthorizationAppleIDProvider创建的授权请求 管理授权请求的控制器
        ASAuthorizationController *authorizationController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[appleIDRequest]];
        // 设置授权控制器通知授权请求的成功与失败的代理
        authorizationController.delegate = self;
        // 设置提供 展示上下文的代理，在这个上下文中 系统可以展示授权界面给用户
        authorizationController.presentationContextProvider = self;
        // 在控制器初始化期间启动授权流
        [authorizationController performRequests];
        
        
    }
}


#pragma mark - ASAuthorizationControllerDelegate

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0))
{
    WEAK_SELF;
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]])       {
        ASAuthorizationAppleIDCredential *credential = authorization.credential;
        
        NSString *state = credential.state;
        NSString *userID = credential.user;
        NSPersonNameComponents *fullName = credential.fullName;
        NSString *email = credential.email;
        NSString *authorizationCode = [[NSString alloc] initWithData:credential.authorizationCode encoding:NSUTF8StringEncoding]; // refresh token
        NSString *identityToken = [[NSString alloc] initWithData:credential.identityToken encoding:NSUTF8StringEncoding]; // access token
        ASUserDetectionStatus realUserStatus = credential.realUserStatus;
        
        NSLog(@"state: %@", state);
        NSLog(@"userID: %@", userID);
        NSLog(@"fullName: %@", fullName);
        NSLog(@"email: %@", email);
        NSLog(@"authorizationCode: %@", authorizationCode);
        NSLog(@"identityToken: %@", identityToken);
        NSLog(@"realUserStatus: %@", @(realUserStatus));
        
        NSMutableDictionary *applepram = [[NSMutableDictionary alloc]init];
        [applepram setValue:userID forKey:@"apple_id"];
        
        [weakSelf requestApplelogin:userID appleprom:applepram];

    }
}

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0))
{
    NSString *errorMsg = nil;
    switch (error.code) {
        case ASAuthorizationErrorCanceled:
            errorMsg = @"用户取消了授权请求";
            break;
        case ASAuthorizationErrorFailed:
            errorMsg = @"授权请求失败";
            break;
        case ASAuthorizationErrorInvalidResponse:
            errorMsg = @"授权请求响应无效";
            break;
        case ASAuthorizationErrorNotHandled:
            errorMsg = @"未能处理授权请求";
            break;
        case ASAuthorizationErrorUnknown:
            errorMsg = @"授权请求失败未知原因";
            break;
    }
    NSLog(@"%@", errorMsg);
    [SVProgressHUD showErrorWithStatus:errorMsg];
}

@end
