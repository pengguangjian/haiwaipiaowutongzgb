//
//  BusCompanyInfoVC.m
//  TicketPassesAPP
//
//  Created by caochun on 2019/11/5.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "BusCompanyInfoVC.h"
#import "XSZContentScrollView.h"
#import "YDScrollView.h"
#import "BusImageVC.h"
#import "BackMoneyNoticeVC.h"
#import "BusCommentVC.h"

@interface BusCompanyInfoVC ()<MSNavSliderMenuDelegate>
{
    MSNavSliderMenu *navSliderMenu;
    NSMutableDictionary  *listVCQueue;
    
    int menuCount;
    
    YDScrollView *contentScrollView;
}

@end

@implementation BusCompanyInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"汽车运营商信息";
    
    [self createNavSliderMenu];
}

- (void)createNavSliderMenu {
    _menuType = MSNavSliderMenuTypeTitleOnly;
    menuCount = 3;
        
    self.automaticallyAdjustsScrollViewInsets = NO;
        
    MSNavSliderMenuStyleModel *model = [MSNavSliderMenuStyleModel new];
        
    NSArray *titles = @[@"退款须知", @"汽车图片", @"评论"];
        
    model.menuTitles = [titles copy];
        
    model.lineHeight = 3;//2
    model.titleLableFont = [UIFont systemFontOfSize:16];
    model.menuWidth = ((double)DEVICE_Width) / menuCount;
    model.menuHorizontalSpacing = 0.0f;
    model.sliderMenuTextColorForSelect = [UIColor whiteColor];
    model.sliderMenuTextColorForNormal = [UIColor whiteColor];
    model.autoSuitLineViewWithdForBtnTitle = YES;
        
    navSliderMenu = [[MSNavSliderMenu alloc] initWithFrame:(CGRect){0,SafeAreaTopHeight,DEVICE_Width,50} andStyleModel:model andDelegate:self showType:self.menuType];
    navSliderMenu.backgroundColor = RGBA(86, 177, 87, 0.8); //UIColorFromHex(0x56B157);
        
        //    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, DEVICE_Width, 0.5)];
        //    [lineView setBackgroundColor:RGB(244, 244, 244)];
        //    [navSliderMenu addSubview:lineView];
        
    [self.view addSubview:navSliderMenu];
        
    //如果只需要一个菜单 下面这些都可以不要  以下是个添加page视图的例子
        
    // 用于滑动的滚动视图
    contentScrollView = [[YDScrollView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight+50, screenWidth, screenHeight-SafeAreaTopHeight-50)];
    contentScrollView.contentSize = (CGSize){screenWidth*menuCount,contentScrollView.frame.size.height};
    //    contentScrollView.pagingEnabled = YES;
    contentScrollView.delegate      = self;
    contentScrollView.scrollsToTop  = NO;
    contentScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:contentScrollView];
        
    [self addListVCWithIndex:0];
        
}

#pragma mark - MSNavSliderMenuDelegate

#pragma mark scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == contentScrollView) {
        //用scrollView的滑动大小与屏幕宽度取整数 得到滑动的页数
        [navSliderMenu selectAtRow:(int)((scrollView.contentOffset.x+screenWidth/2.f)/screenWidth) andDelegate:YES];
        [self addListVCWithIndex:(int)(scrollView.contentOffset.x/screenWidth)+1];
        int row = (int)(scrollView.contentOffset.x/screenWidth);
    }
    
    
}

#pragma mark - MSNavSliderMenuDelegate
- (void)navSliderMenuDidSelectAtRow:(NSInteger)row {
    
    //让scrollview滚到相应的位置
    [contentScrollView setContentOffset:CGPointMake(row*screenWidth, contentScrollView.contentOffset.y)  animated:NO];
    
    //根据页数添加相应的视图
    [self addListVCWithIndex:row];
    
    
}

#pragma mark -addVC

- (void)addListVCWithIndex:(NSInteger)index {
    
    if (!listVCQueue) {
        listVCQueue = [[NSMutableDictionary alloc] init];
    }
    if (index<0 || index>=menuCount) {
        
        return;
    }
    //根据页数添加相对应的视图 并存入数组
    
    if (![listVCQueue objectForKey:@(index)]) {
        
        if (index == 0) {
            BackMoneyNoticeVC *vc = [[BackMoneyNoticeVC alloc] initWithNibName:@"BackMoneyNoticeVC" bundle:nil];
            vc.company_id = _trip_code;
            [vc beginAppearanceTransition:YES animated:YES];
            [self addChildViewController:vc];
            vc.view.left = index*screenWidth;
            vc.view.top  = 0;
            [contentScrollView addSubview:vc.view];
            [listVCQueue setObject:vc forKey:@(index)];
            
            return;
        } else if (index == 1) {
            BusImageVC *vc = [[BusImageVC alloc] initWithNibName:@"BusImageVC" bundle:nil];
            vc.company_id = _company_id;
            [vc beginAppearanceTransition:YES animated:YES];
            [self addChildViewController:vc];
            vc.view.left = index*screenWidth;
            vc.view.top  = 0;
            [contentScrollView addSubview:vc.view];
            [listVCQueue setObject:vc forKey:@(index)];
        } else {
            BusCommentVC *vc = [[BusCommentVC alloc] initWithNibName:@"BusCommentVC" bundle:nil];
            vc.company_id = _company_id;
            [vc beginAppearanceTransition:YES animated:YES];
            [self addChildViewController:vc];
            vc.view.left = index*screenWidth;
            vc.view.top  = 0;
            [contentScrollView addSubview:vc.view];
            [listVCQueue setObject:vc forKey:@(index)];
        }
        
        
    }
}



@end
