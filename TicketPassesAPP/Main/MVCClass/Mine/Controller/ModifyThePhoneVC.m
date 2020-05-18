//
//  ModifyThePhoneVC.m
//  TicketPassesAPP
//
//  Created by macbook on 2019/6/27.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import "ModifyThePhoneVC.h"
#import "GGVerifyCodeViewBtn.h"

@interface ModifyThePhoneVC ()

@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet GGVerifyCodeViewBtn *codeBtn;

@end

@implementation ModifyThePhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSBundleLocalizedString(@"修改绑定手机号码");
}


- (IBAction)codeAction:(id)sender {
    if(![XBUtils isPhone:self.phoneTF.text]){
        [MBManager showBriefAlert:NSBundleLocalizedString(@"请输入手机号码")];
        return;
    }
    [AFHTTP requestSmscodePhone:self.phoneTF.text status:@"2" success:^(id responseObject){
        [self.codeBtn timeFailBeginFrom:60];
    }];
}


- (IBAction)loginAction:(id)sender {
#ifdef DEBUG
    [AFHTTP requestBandnewphonePhone:self.phoneTF.text verify_code:self.codeTF.text success:^(id responseObject){
        
        
    
    }];
#else
    if(![XBUtils isPhone:self.phoneTF.text]){
        [MBManager showBriefAlert:NSBundleLocalizedString(@"请输入手机号码")];
        return;
    }
    if(!kStringIsEmpty(self.codeTF.text)){
        [MBManager showBriefAlert:NSBundleLocalizedString(@"请输入验证码")];
        return;
    }
//    [AFHTTP requestLoginPhone:self.phoneTF.text andCode:self.codeTF.text];
#endif
    
    
}

@end
