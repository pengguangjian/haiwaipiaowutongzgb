//
//  OlderListVC.m
//  TicketPassesAPP
//
//  Created by macbook on 2019/6/27.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import "OlderListVC.h"
#import "TicketOrderVC.h"
#import "LogisticsOrderVC.h"

#define titleViewhHHH 200

@interface OlderListVC ()<SGPageTitleViewDelegate,SGPageContentScrollViewDelegate>

///视图
@property (strong, nonatomic)  UIView *mView;
//白色背景
@property (strong, nonatomic)  UIView *headView;
//黑色背景
@property (strong, nonatomic)  UIView *mTableBaseView;
//
@property (strong, nonatomic) UIButton *titleButton;

@property (nonatomic, strong) SGPageTitleView *pageTitleView;

@property (nonatomic, strong) SGPageContentScrollView *pageScrollView;

@end

@implementation OlderListVC

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, titleViewhHHH, SYS_NavBarHeight)];
    [view addSubview:self.titleButton];
    self.navigationItem.titleView = view;
    
    [self.titleButton setTitleIconInRight:NSBundleLocalizedString(@"订票订单")];
    [self setTicketOrderVC];

}

- (void)cmdButtonTaped{
    
    [self showMenu];
}

- (void)muneButtonTaped:(UIButton *)button{
    
    [self hideMenu];
    if(button.tag == 1001){
        if([self.titleButton.titleLabel.text isEqualToString:NSBundleLocalizedString(@"订票订单")]){
            return;
        }
        [self upViewVC:@"TicketOrderVC"];
    }else{
        if([self.titleButton.titleLabel.text isEqualToString:NSBundleLocalizedString(@"物流订单")]){
            return;
        }
        [self upViewVC:@"LogisticsOrderVC"];
    }
}

- (void)upViewVC:(NSString *)type{
    
    [self.pageTitleView removeFromSuperview];
    self.pageTitleView = nil;
    [self.pageScrollView removeFromSuperview];
    self.pageScrollView = nil;
    [UIView animateWithDuration:0.3 animations:^(){
        
        if([type isEqualToString:@"TicketOrderVC"]){
            [self setTicketOrderVC];
        }else{
            [self setLogisticsOrderVC];
            
        }
    }];
    
}
- (void)openAnimation:(BOOL)open {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    if(open){
        
        self.titleButton.imageView.transform = CGAffineTransformMakeRotation(180 * (M_PI /180.0f));
//        self.sanx_upImage.transform = CGAffineTransformMakeRotation(180 * (M_PI /180.0f));
    }else{
        self.titleButton.imageView.transform = CGAffineTransformIdentity;
//        self.sanx_upImage.transform =CGAffineTransformIdentity;
    }
    [UIView commitAnimations];
}
///通知出现
- (void)showMenu{
    
    [self openAnimation:YES];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.headView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.mTableBaseView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.mView];
    self.headView.alpha = 0;
    self.mTableBaseView.alpha = 0;
    self.mView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.headView.alpha = 1;
        self.mView.alpha = 1;
        self.mTableBaseView.alpha = 0.5;
    }];
    
}
///通知隐藏

- (void)hideMenu{
    
    
    [self openAnimation:NO];
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.mView. alpha = 0;
                         self.mTableBaseView.alpha = 0;
                         self.headView.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         [self.headView removeFromSuperview];
                         [self.mView removeFromSuperview];
                         [self.mTableBaseView removeFromSuperview];
                         
                     }];
    
}

-(void)bgTappedAction:(UITapGestureRecognizer *)tap
{
    [self hideMenu];
  
}


- (void)setTicketOrderVC{
    
    [self.titleButton setTitleIconInRight:NSBundleLocalizedString(@"订票订单")];
    
    SGPageTitleViewConfigure *configure= [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleFont = [UIFont systemFontOfSize:15];
    configure.titleColor = UIColorFromHex(0x808080);
    configure.titleSelectedColor = UIColorFromHex(0x56b157);
    configure.indicatorColor = UIColorFromHex(0x56b157);
    configure.indicatorHeight = 2;
    configure.showBottomSeparator = NO;
    
    self.pageTitleView = [[SGPageTitleView alloc]initWithFrame:CGRectMake(0, SYS_TopHeight, SCREEN_WIDTH, 50) delegate:self titleNames:@[NSBundleLocalizedString(@"待支付"),NSBundleLocalizedString(@"待完成"),NSBundleLocalizedString(@"已完成"),NSBundleLocalizedString(@"已取消")] configure:configure];
    [self.view addSubview:self.pageTitleView];
    
//    1未支付 2已支付（未乘车） 3已支付（已乘车） 4取消
    TicketOrderVC *meigeiqian = [[TicketOrderVC alloc]init];
    meigeiqian.tickeType = @"1";
    TicketOrderVC *cooperation = [[TicketOrderVC alloc]init];
    cooperation.tickeType = @"2";
    TicketOrderVC *progress = [[TicketOrderVC alloc]init];
    progress.tickeType = @"3";
    TicketOrderVC *latest = [[TicketOrderVC alloc]init];
    latest.tickeType = @"4";
    NSArray *childs = @[meigeiqian,cooperation,progress,latest];
    
    self.pageScrollView = [[SGPageContentScrollView alloc]initWithFrame:CGRectMake(0, SYS_TopHeight + 50, SCREEN_WIDTH, SCREENH_HEIGHT - SYS_ALLDUD -50) parentVC:self childVCs:childs];
    self.pageScrollView.delegatePageContentScrollView = self;
    [self.view addSubview:self.pageScrollView];
}

- (void)setLogisticsOrderVC{
    
    [self.titleButton setTitleIconInRight:NSBundleLocalizedString(@"物流订单")];
    
    SGPageTitleViewConfigure *configure= [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleFont = [UIFont systemFontOfSize:15];
    configure.titleColor = UIColorFromHex(0x808080);
    configure.titleSelectedColor = UIColorFromHex(0x56b157);
    configure.indicatorColor = UIColorFromHex(0x56b157);
    configure.indicatorHeight = 2;
    configure.showBottomSeparator = NO;
    
    self.pageTitleView = [[SGPageTitleView alloc]initWithFrame:CGRectMake(0, SYS_TopHeight, SCREEN_WIDTH, 50) delegate:self   titleNames:@[NSBundleLocalizedString(@"已支付"),NSBundleLocalizedString(@"待完成"),NSBundleLocalizedString(@"已完成")] configure:configure];
    [self.view addSubview:self.pageTitleView];
//     1未支付 2支付订金（待完成） 3待支付尾款 4已完成（尾款支付）
    LogisticsOrderVC *meigeiqian = [[LogisticsOrderVC alloc]init];
    meigeiqian.logisticsType = @"2";
    LogisticsOrderVC *cooperation = [[LogisticsOrderVC alloc]init];
    cooperation.logisticsType = @"3";
    LogisticsOrderVC *progress = [[LogisticsOrderVC alloc]init];
    progress.logisticsType = @"4";
    NSArray *childs = @[meigeiqian,cooperation,progress];
    
    self.pageScrollView = [[SGPageContentScrollView alloc]initWithFrame:CGRectMake(0, SYS_TopHeight + 50, SCREEN_WIDTH, SCREENH_HEIGHT - SYS_ALLDUD -50) parentVC:self childVCs:childs];
    self.pageScrollView.delegatePageContentScrollView = self;
    [self.view addSubview:self.pageScrollView];
}


-(void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex{
    NSLog(@"选中的下标为%ld",selectedIndex);
    [self.pageScrollView setPageContentScrollViewCurrentIndex:selectedIndex];
}

-(void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex{
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}
-(void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView index:(NSInteger)index{
    NSLog(@"选中第%ld个控制器",index);
}

- (UIButton *)titleButton {
    if(!_titleButton){
        _titleButton = [[UIButton alloc]init];
        [_titleButton addTarget: self action: @selector(cmdButtonTaped) forControlEvents: UIControlEventTouchUpInside];
        _titleButton.frame = CGRectMake(0, 0, titleViewhHHH, SYS_NavBarHeight);
        [_titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _titleButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        [_titleButton setImage:[UIImage imageNamed:@"sanx_up"] forState:UIControlStateNormal];
        [_titleButton setIconInRightWithSpacing:10];
    }
    return _titleButton;
}

- (UIView *)mView{
    if(!_mView){
        _mView = [[UIView alloc]initWithFrame:CGRectMake(0, SYS_TopHeight, SCREEN_WIDTH, 81)];
        _mView.backgroundColor = [UIColor whiteColor];
        
        UIButton *muneButton1 = [[UIButton alloc]init];
        muneButton1.tag = 1001;
        muneButton1.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
        muneButton1.titleLabel.font = [UIFont systemFontOfSize:15];
        [muneButton1 setTitleColor:UIColorFromHex(0x808080) forState:UIControlStateNormal];
        [muneButton1 setTitle:NSBundleLocalizedString(@"订票订单") forState:UIControlStateNormal];
        [muneButton1 addTarget: self action: @selector(muneButtonTaped:) forControlEvents: UIControlEventTouchUpInside];
        [_mView addSubview:muneButton1];
        
        UIView *liveView = [[UIView alloc]initWithFrame:CGRectMake(15, 40, SCREEN_WIDTH - 30, 1)];
        liveView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_mView addSubview:liveView];
        
        UIButton *muneButton2 = [[UIButton alloc]init];
        muneButton2.tag = 1002;
        muneButton2.frame = CGRectMake(0, 41, SCREEN_WIDTH, 40);
        muneButton2.titleLabel.font = [UIFont systemFontOfSize:15];
        [muneButton2 setTitleColor:UIColorFromHex(0x808080) forState:UIControlStateNormal];
        [muneButton2 setTitle:NSBundleLocalizedString(@"物流订单") forState:UIControlStateNormal];
        [muneButton2 addTarget: self action: @selector(muneButtonTaped:) forControlEvents: UIControlEventTouchUpInside];
        [_mView addSubview:muneButton2];

    }
    return _mView;
    
}
- (UIView *)headView{
    if(!_headView){
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENH_HEIGHT, SYS_TopHeight)];
        _headView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTappedAction:)];
        [_headView addGestureRecognizer:bgTap];
    }
    return _headView;
}
- (UIView *)mTableBaseView{
    if(!_mTableBaseView){
        _mTableBaseView = [[UIView alloc]initWithFrame:CGRectMake(0, SYS_TopHeight, SCREEN_WIDTH, SCREENH_HEIGHT - SYS_TopHeight)];
        _mTableBaseView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTappedAction:)];
        [_mTableBaseView addGestureRecognizer:bgTap];
    }
    return _mTableBaseView;
}

@end
