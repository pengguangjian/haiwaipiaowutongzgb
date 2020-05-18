//
//  AppDelegate.m
//  TicketPassesAPP
//
//  Created by macbook on 2019/6/25.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginVC.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AppDelegate+ThirdPartyRegister.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //
    [AvoidCrash becomeEffective];
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    //注册BuglySDK
    [self registerBuglySDK];
    
    //注册ShareSDK+
    [self registerShareSDK];
    //初始化
//    [UMConfigure initWithAppkey:UMAccount  channel:@"App Store"];
    //初始化
//    [[ZaloSDK sharedInstance] initializeWithAppId:ZAloAccount];
    // U-Share 平台设置
//    [self configUSharePlatforms];
//    [self confitUShareSettings];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    if(SYSIsLogined){
        BaseTabBarVC * homeVC = [[BaseTabBarVC alloc] init];
        self.window.rootViewController = homeVC;
        [self.window makeKeyAndVisible];
    }else{
        LoginVC * loginVC = [[LoginVC alloc] init];
        BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:loginVC];
        self.window.rootViewController = nav;
    }
    [self.window makeKeyAndVisible];
    
    return YES;
}
- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
}
- (void)configUSharePlatforms
{
    /* 设置Facebook的appKey和UrlString */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Facebook appKey:FBAccount appSecret:nil redirectURL:@""];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAccount appSecret:nil redirectURL:@""];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAccount appSecret:nil redirectURL:@""];
}
//zalo 不适用 这个这个api
//- (BOOL)application:(UIApplication *)app
//            openURL:(NSURL *)url
//            options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
//{
//    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
//    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
//    if (!result) {
//        // 其他如支付等SDK的回调
//        NSLog(@"其他SDK的回调  application");
//        // 其他如支付等SDK的回调
//        return [[ZDKApplicationDelegate sharedInstance]
//                application:nil
//                openURL:url sourceApplication:nil annotation:nil];
//    }
//
//
//    return result;
//}
// 支持所有iOS系统






- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    if([[url absoluteString] rangeOfString:@"wx27b40aa7846da36d://pay"].location == 0) { //你的微信开发者appid
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    } else {
        return [self Alipay:url];
    }
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if([[url absoluteString] rangeOfString:@"wx27b40aa7846da36d://pay"].location == 0) { //你的微信开发者appid
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    } else {
        return [self Alipay:url];
    }
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
    if([[url absoluteString] rangeOfString:@"wx27b40aa7846da36d://pay"].location == 0) { //你的微信开发者appid
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    } else {
        return [self Alipay:url];
    }
}


- (BOOL)Alipay:(NSURL *)url {
    /*
     9000 订单支付成功
     8000 正在处理中
     4000 订单支付失败
     6001 用户中途取消
     6002 网络连接出错
     */
    if ([url.host isEqualToString:@"safepay"]) {
        //这个是进程KILL掉之后也会调用，这个只是第一次授权回调，同时也会返回支付信息
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            [self AlipayWithResutl:resultDic];
        }];
        //跳转支付宝钱包进行支付，处理支付结果，这个只是辅佐订单支付结果回调
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [self AlipayWithResutl:resultDic];
        }];
        
    } else if ([url.host isEqualToString:@"platformapi"]) {
        //授权返回码
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            [self AlipayWithResutl:resultDic];
        }];
    }
    
    return YES;
    
}

- (void)AlipayWithResutl:(NSDictionary *)resultDic {
    NSString  *str = [resultDic objectForKey:@"resultStatus"];
    if (str.intValue == 9000) {
        // 支付成功
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PayResult" object:@"ali_success" userInfo:resultDic];
        
    } else {
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PayResult" object:@"fail" userInfo:resultDic];
    }
}


@end
