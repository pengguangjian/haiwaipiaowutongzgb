//
//  NewAddressVC.m
//  TicketPassesAPP
//
//  Created by macbook on 2019/7/1.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import "NewAddressVC.h"

@interface NewAddressVC ()

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *iphoneTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;

@end

@implementation NewAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(kStringIsEmpty(self.ad_id)){
        self.navigationItem.title = NSBundleLocalizedString(@"编辑地址");
        self.nameTF.text = self.nameStr;
        self.iphoneTF.text = self.iphoneStr;
        self.addressTF.text = self.addressStr;
    }else{
        self.navigationItem.title = NSBundleLocalizedString(@"新建地址");
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}

- (IBAction)saveClick:(id)sender {
    
    if(!kStringIsEmpty(self.nameTF.text)){
        [MBManager showBriefAlert:NSBundleLocalizedString(@"请输入姓名")];
        return;
    }
    if(![XBUtils isPhone:self.iphoneTF.text]){
        [MBManager showBriefAlert:NSBundleLocalizedString(@"请输入手机号码")];
        return;
    }
    if(!kStringIsEmpty(self.addressTF.text)){
        [MBManager showBriefAlert:NSBundleLocalizedString(@"请输入地址")];
        return;
    }
    WEAK_SELF;
    if(kStringIsEmpty(self.ad_id)){
        [AFHTTP requestEditaddressAd_id:self.ad_id
                           ad_consignee:self.nameTF.text
                     ad_consignee_phone:self.iphoneTF.text ad_get_address:self.addressTF.text
                                success:^(NSDictionary *dic){
                                    
                                    if(weakSelf.backSuccessBlock){
                                        weakSelf.backSuccessBlock();
                                    }
                                    [weakSelf onBack];
                                }];
        
        
    }else{
        [AFHTTP requestMyaddressAd_consignee:self.nameTF.text
                          ad_consignee_phone:self.iphoneTF.text ad_get_address:self.addressTF.text
                                     success:^(NSDictionary *dic){
                                         
                                         if(weakSelf.backSuccessBlock){
                                             weakSelf.backSuccessBlock();
                                         }
                                         [weakSelf onBack];
                                     }];
    }
    
    
   

}






@end
