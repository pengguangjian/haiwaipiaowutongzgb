//
//  BaseTabBarVC.m
//  TicketPassesAPP
//
//  Created by macbook on 2019/6/25.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import "BaseTabBarVC.h"
#import "HomeVC.h"
#import "MineVC.h"
#import "OlderListVC.h"
#import "BusinessVC.h"
#import "LogisticsVC.h"

@interface BaseTabBarVC ()

@end

@implementation BaseTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UITabBarItem *tabBarItem = [UITabBarItem  appearance];
    //未选中的
    NSMutableDictionary *norAttri = [NSMutableDictionary dictionary];
    norAttri[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    norAttri[NSForegroundColorAttributeName] = UIColorFromHex(0x6d6d6d);
    [tabBarItem setTitleTextAttributes:norAttri forState:UIControlStateNormal];
    //选中的
    NSMutableDictionary *selectAttri = [NSMutableDictionary dictionary];
    selectAttri[NSForegroundColorAttributeName] = UIColorFromHex(0x56b157);
    [tabBarItem setTitleTextAttributes:selectAttri forState:UIControlStateSelected];
    
    //Tabbar 未选中颜色
    if ([UIDevice currentDevice].systemVersion.floatValue < 10.0) {
        [UITabBar appearance].tintColor = UIColorFromHex(0x6d6d6d);
    } else {
        [UITabBar appearance].unselectedItemTintColor = UIColorFromHex(0x6d6d6d);
    }
    [UITabBar appearance].selectedImageTintColor = UIColorFromHex(0x56b157);
    
    [self setupChridViewController:[[HomeVC alloc] init] title:NSBundleLocalizedString(@"首页") normalImage:@"home" selectedImage:@"home_wei"];
    
    [self setupChridViewController:[[LogisticsVC alloc] init] title:NSBundleLocalizedString(@"物流") normalImage:@"logistics" selectedImage:@"logistics_wei"];
    
    [self setupChridViewController:[[OlderListVC alloc] init] title:NSBundleLocalizedString(@"订单") normalImage:@"older" selectedImage:@"older_wei"];
    
    [self setupChridViewController:[[BusinessVC alloc] init] title:NSBundleLocalizedString(@"商旅") normalImage:@"Business" selectedImage:@"Business_wei"];
    
    [self setupChridViewController:[[MineVC alloc] init] title:NSBundleLocalizedString(@"我的") normalImage:@"mine" selectedImage:@"mine_wei"];
}


- (void)setupChridViewController:(UIViewController *)vc title:(NSString *)title normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage{
    self.tabBarController.tabBar.tintColor = UIColorFromHex(0xffffff);
    vc.title = title;
    if (normalImage.length && selectedImage.length )
    {
        vc.tabBarItem.image = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:normalImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
    }
    BaseNavigationController * navVC=[[BaseNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:navVC];
    
}

@end
