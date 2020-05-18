//
//  AddOrEditContactVC.m
//  TicketPassesAPP
//
//  Created by caochun on 2019/10/28.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "AddOrEditContactVC.h"
#import "FESeletTypeView.h"
#import "ColumnTypeObj.h"

@interface AddOrEditContactVC ()

{
    ColumnTypeObj *selectCto;
}

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *iphoneTF;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *certificateTypeTF;
@property (weak, nonatomic) IBOutlet UITextField *cardNoTF;

@end

@implementation AddOrEditContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameTF.keyboardType = UIKeyboardTypeASCIICapable;
     //监听输入内容
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFiledEditChanged:)
                                                 name:@"UITextFieldTextDidChangeNotification"
                                               object:self.nameTF];
    
    if(_co){
        self.navigationItem.title = NSBundleLocalizedString(@"编辑联系人");
        self.nameTF.text = _co.name;
        self.iphoneTF.text = _co.phone;
        self.emailTF.text = _co.email;
        if ([_co.card_type intValue] == 1) {
            self.certificateTypeTF.text = @"护照";
        } else if ([_co.card_type intValue] == 2) {
            self.certificateTypeTF.text = @"身份证";
        }
        self.cardNoTF.text = _co.card_number;
        
        selectCto = [[ColumnTypeObj alloc] init];
        selectCto.id = _co.card_type;
        selectCto.name = self.certificateTypeTF.text;
        
    }else{
        self.navigationItem.title = NSBundleLocalizedString(@"新建联系人");
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.certificateTypeTF.enabled = NO;
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

- (IBAction)saveClick:(id)sender {
    
//    if(!kStringIsEmpty(self.nameTF.text)){
//        [MBManager showBriefAlert:NSBundleLocalizedString(@"请输入姓名")];
//        return;
//    }
//    if(![self.iphoneTF.text isValidPhoneNum]){
//        [MBManager showBriefAlert:NSBundleLocalizedString(@"请输入手机号码")];
//        return;
//    }
//    if(![self.emailTF.text isValidEmail]){
//        [MBManager showBriefAlert:NSBundleLocalizedString(@"请输入邮箱")];
//        return;
//    }
//
//    if (!selectCto) {
//        [MBManager showBriefAlert:NSBundleLocalizedString(@"请选择证件类型")];
//        return;
//    }
//
//    if(!kStringIsEmpty(self.cardNoTF.text)){
//        [MBManager showBriefAlert:NSBundleLocalizedString(@"请输入证件号码")];
//        return;
//    }
    WEAK_SELF;
    if(_co){
        
        HttpManager *hm = [HttpManager createHttpManager];
        
        hm.responseHandler = ^(id responseObject) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                ResponseData *rd = [ResponseData mj_objectWithKeyValues:responseObject];
                
                if ([rd.code isEqualToString:SUCCESS] ) {
                    
                    if(weakSelf.backSuccessBlock){
                        weakSelf.backSuccessBlock();
                    }
                    [weakSelf onBack];
                    
                } else {
                    [SVProgressHUD showErrorWithStatus:rd.msg];
                }
            });
        };
        
        NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
        [dataDic setObject:_co.id forKey:@"id"];
        [dataDic setObject:self.nameTF.text forKey:@"name"];
        [dataDic setObject:self.iphoneTF.text forKey:@"phone"];
        [dataDic setObject:self.emailTF.text forKey:@"email"];
        [dataDic setObject:selectCto.id forKey:@"card_type"];
        [dataDic setObject:self.cardNoTF.text forKey:@"card_number"];
        
        [hm getRequetInterfaceData:dataDic withInterfaceName:@"/api/contacts/update"];
        
        
    }else{
        
        
        HttpManager *hm = [HttpManager createHttpManager];
        
        hm.responseHandler = ^(id responseObject) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                ResponseData *rd = [ResponseData mj_objectWithKeyValues:responseObject];
                
                if ([rd.code isEqualToString:SUCCESS] ) {
                    
                    if(weakSelf.backSuccessBlock){
                        weakSelf.backSuccessBlock();
                    }
                    [weakSelf onBack];
                    
                } else {
                    [SVProgressHUD showErrorWithStatus:rd.msg];
                }
            });
        };
        
        
        NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
        [dataDic setObject:self.nameTF.text forKey:@"name"];
        [dataDic setObject:self.iphoneTF.text forKey:@"phone"];
        [dataDic setObject:self.emailTF.text forKey:@"email"];
        [dataDic setObject:selectCto.id forKey:@"card_type"];
        [dataDic setObject:self.cardNoTF.text forKey:@"card_number"];
        
        
        [hm getRequetInterfaceData:dataDic withInterfaceName:@"/api/contacts/create"];
        
        
    }
    
    
   

}

- (IBAction)certificateTypeBtnOnTouch:(id)sender {

    [self.view endEditing:YES];

    NSMutableArray *typeArr = [[NSMutableArray alloc] init];
    ColumnTypeObj *idCardCto = [[ColumnTypeObj alloc] init];
    idCardCto.id = [NSNumber numberWithInt:2];
    idCardCto.name = @"身份证";
    [typeArr addObject:idCardCto];

    ColumnTypeObj *cto = [[ColumnTypeObj alloc] init];
    cto.id = [NSNumber numberWithInt:1];
    cto.name = @"护照";
    [typeArr addObject:cto];

    FESeletTypeView *seletTypeView = [FESeletTypeView sharedView:typeArr];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:seletTypeView];

    seletTypeView.handler = ^(id  _Nonnull type) {
        
        selectCto = type;
        _certificateTypeTF.text = selectCto.name;

    };
    [seletTypeView show];

}


@end
