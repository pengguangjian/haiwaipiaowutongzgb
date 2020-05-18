//
//  AppDelegate+ThirdPartyRegister.m
//  TechnicianAPP
//
//  Created by Mac on 2018/4/9.
//  Copyright © 2018年 XiaoShunZi. All rights reserved.
//

#import "AppDelegate+ThirdPartyRegister.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
#import "WeiboSDK.h"

#import <Bugly/Bugly.h>

// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate (ThirdPartyRegister)
@end

@implementation AppDelegate (ThirdPartyRegister)



#pragma mark - 注册ShareSDK
- (void)registerShareSDK {
    
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    //    [ShareSDK]
    [ShareSDK registerActivePlatforms:@[@(SSDKPlatformTypeSinaWeibo),
                                        @(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformTypeQQ)] onImport:^(SSDKPlatformType platformType) {
                                            switch (platformType) {
                                                case SSDKPlatformTypeWechat:
                                                    [ShareSDKConnector connectWeChat:[WXApi class]];
                                                    break;
                                                case SSDKPlatformTypeQQ:
                                                    [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                                                    break;
                                                case SSDKPlatformTypeSinaWeibo:
                                                    [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                                                    break;
                                                default:
                                                    break;
                                            }
                                        }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                          
                          switch (platformType)
                          {
                              case SSDKPlatformTypeSinaWeibo:
                                  //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                                  [appInfo SSDKSetupSinaWeiboByAppKey:@"2537327789"
                                                            appSecret:@"bf2ac05d30d32752d00241badf7cfd81"
                                                          redirectUri:@"https://www.xsztn.cn"
                                                             authType:SSDKAuthTypeBoth];
                                  break;
                              case SSDKPlatformTypeWechat:
                                  [appInfo SSDKSetupWeChatByAppId:@"wx27b40aa7846da36d"
                                                        appSecret:@"6786a64a1d40c6cd312b1e14751dc149"];
                                  break;
                              case SSDKPlatformTypeQQ:
                                  [appInfo SSDKSetupQQByAppId:@"101810992"
                                                       appKey:@"fe4924f3e9807ea824b33fa30756261c"
                                                     authType:SSDKAuthTypeBoth];
                                  break;
                              default:
                                  break;
                          }
                          
                      }];
    
    [WXApi registerApp:@"wx27b40aa7846da36d"];
    
    
}



- (void)registerBuglySDK {
    //初始化Bugly
    [Bugly startWithAppId:@"3fd0657d73"];
}

@end
