//
//  MineVC.m
//  TicketPassesAPP
//
//  Created by macbook on 2019/6/27.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import "MineVC.h"
#import "PersonalVC.h"
#import "ShardVC.h"
#import "WebViewController.h"

@interface MineVC ()<UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *boxView;
//我的距上 高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mineLbY;
//背景板高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewBGY;
//菜单 距上高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *boxViewY;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *iphoneLabel;



@end

@implementation MineVC
- (void)dealloc {
    self.navigationController.delegate = nil;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self upViewData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    self.navigationItem.title = @"";
    ViewRadius(self.boxView, 5);
    if (IS_iPhoneX) {
        self.mineLbY.constant = 54;
        self.topViewBGY.constant = 224;
        self.boxViewY.constant = 174;
    }
    ViewRadius(self.headImageView, 35);
    
    [self upViewData];
}

- (void)upViewData {
    
    UserModel *model = [[UserInfo sharedInstance] fetchLoginUserInfo];
    [self.headImageView sd_setImageWithURL:[NSURL SDURLWithString:model.head_img] placeholderImage:[UIImage imageNamed:@"headImage"]];
    self.nameLabel.text = model.nickname;
    self.iphoneLabel.text = [XBUtils dealWithPhoneW:model.account];

}

- (IBAction)buttonChlick:(UIButton *)sender {
    
    if(sender.tag == 101){
        PersonalVC * personalVC = [[PersonalVC alloc] init];
//        WEAK_SELF;
//        [personalVC setBackSuccessBlock:^{
//            [weakSelf upViewData];
//        }];
        [self.navigationController pushViewController:personalVC animated:YES];
    }
    else if (sender.tag == 102){
        ShardVC *shardVC = [[ShardVC alloc] init];
        [self.navigationController pushViewController:shardVC animated:YES];
    }
    else if (sender.tag == 103){
        //客服电话
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",Telprompt];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    else if (sender.tag == 104){
        WebViewController *vc = [[WebViewController alloc]init];
        vc.webType = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (sender.tag == 105){
        WebViewController *vc = [[WebViewController alloc]init];
        vc.webType = 2;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        NSLog(@"其他");
    }
    
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}




@end
