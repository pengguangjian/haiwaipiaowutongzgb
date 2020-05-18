//
//  PersonalVC.m
//  TicketPassesAPP
//
//  Created by macbook on 2019/6/27.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import "PersonalVC.h"
#import "ModifyThePhoneVC.h"
#import "ModifyThePwsVC.h"
#import "UIViewController+ImagePicker.h"

@interface PersonalVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *iphoneLabel;

@property (strong, nonatomic) UserModel *model;
@property (weak, nonatomic) IBOutlet UIButton *OutButton;

//是否有数据更新
@property (nonatomic,assign) BOOL isUpdata;


@end

@implementation PersonalVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSBundleLocalizedString(@"个人资料");
    
    [self.OutButton setTitle:NSBundleLocalizedString(@"退出登录") forState:UIControlStateNormal];
    
    ViewRadius(self.headImageView, 25);
    
    self.nameLabel.delegate = self;
//    self.headImageView 
    [self.headImageView sd_setImageWithURL:[NSURL SDURLWithString:self.model.head_img] placeholderImage:[UIImage imageNamed:@"headImage"]];
    self.nameLabel.text = self.model.nickname;
    self.iphoneLabel.text = [XBUtils dealWithPhoneW:self.model.account];
}
//- (void)willMoveToParentViewController:(UIViewController *)parent {
//    if(self.isUpdata){
//        self.isUpdata = NO;
//        if(self.backSuccessBlock){
//            self.backSuccessBlock();
//        }
//    }
//}
- (IBAction)outClick:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:SEARCHHISTORY];
    
    [[UserInfo sharedInstance]deleteLoginUserInfo];
    
    [XBUtils SYSOutRootController];
}

- (void)cancelEditing{
    [self.view endEditing:YES];
    self.navigationItem.rightBarButtonItem = nil;
    self.nameLabel.text = self.model.nickname;
}
-(void)clickRightBarButton:(UIButton *)sender{
    
    if(!kStringIsEmpty(self.nameLabel.text)){
        [MBManager showBriefAlert:NSBundleLocalizedString(@"请输入昵称")];
        return;
    }
    [self.view endEditing:YES];
    self.navigationItem.rightBarButtonItem = nil;
    WEAK_SELF;
    [AFHTTP requestUpdateuinfoNickname:self.nameLabel.text success:^(id data){
        weakSelf.model = nil;
//        [weakSelf onBack];
    }];
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self addRightBarButton: NSBundleLocalizedString(@"保存")];
    self.nameLabel.text = @"";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self cancelEditing];
}

- (IBAction)updateHead:(id)sender {
    
    [self cancelEditing];
    [self addPhoto];
    
}

- (IBAction)updatePhone:(id)sender {
    
    [self cancelEditing];
    ModifyThePhoneVC *modifyVC = [[ModifyThePhoneVC alloc] init];
    [self.navigationController pushViewController:modifyVC animated:YES];
}
- (IBAction)ChangePwa:(id)sender {
    
    ModifyThePwsVC *vc = [[ModifyThePwsVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 上传照片用方法
- (void)addPhoto
{
    WEAK_SELF;
    [self openChoiceWithCompleteBlock:^(NSDictionary *info) {
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        weakSelf.headImageView.image = image;
        
        [weakSelf requestUpdateimage:image];
    }];
    
}

- (void)requestUpdateimage:(UIImage *)image{
    
    WEAK_SELF;
    [AFHTTP requestUpdateimage:image Success:^(NSDictionary *responseObject) {
        
        
        weakSelf.model.head_img =  responseObject[@"file_path"];
        
        [[UserInfo sharedInstance] updateLoginUserInfo:weakSelf.model];
        
        [MBManager showBriefAlert:NSBundleLocalizedString(@"上传成功")];
    }];
    
}

- (UserModel *)model{
    if(!_model){
        _model = [[UserInfo sharedInstance] fetchLoginUserInfo];
    }
    return _model;
}


@end
