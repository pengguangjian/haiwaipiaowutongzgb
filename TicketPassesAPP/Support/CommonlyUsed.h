//
//  CommonlyUsed.h
//  NewBeauty
//
//  Created by macbook on 2018/8/22.
//  Copyright © 2018年 macbook. All rights reserved.
//

#ifndef CommonlyUsed_h
#define CommonlyUsed_h

#ifdef DEBUG

    //#define HTTPAPI @"http://www.vexevn.com.vn/"
//    #define HTTPAPI @"http://192.168.0.103:82/"
    #define HTTPAPI @"http://ticket.dottp.com/"
//    #define HTTPImageAPI @"http://www.vexevn.com.vn"
#define HTTPImageAPI @""

#else

    #define HTTPAPI @"http://ticket.dottp.com/"
    //    #define HTTPImageAPI @"http://www.vexevn.com.vn"
    #define HTTPImageAPI @""

#endif


//请求版本号
#define HTTPAPIVersion @"4"
//超时时间
#define HTTPTimeoutInterval 15
//标题
#define SYS_NAME [XBUtils getAppName]
//版本号
#define SYS_Version [XBUtils getAppVersion]

//获取屏幕的宽高
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height
//状态栏高度
#define SYS_StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
//导航栏
#define SYS_NavBarHeight 44.0
//TabBar高
#define SYS_TabBarHeight 49.0
//TabBar浮动高  0 或者 34
#define SYS_TabBarFloatHeight (SYS_StatusBarHeight>20?34:0)
//上高 状态栏 + 导航栏
#define SYS_TopHeight (SYS_StatusBarHeight + SYS_NavBarHeight)
//下高  TabBar高 + 浮动高
#define SYS_BottomHeight (SYS_TabBarHeight + SYS_TabBarFloatHeight)
//状态栏 + 导航栏 + 浮动高
#define SYS_DUD (SYS_StatusBarHeight + SYS_NavBarHeight + SYS_TabBarFloatHeight)
//状态栏 + 导航栏 + TabBar + 浮动高
#define SYS_ALLDUD (SYS_StatusBarHeight + SYS_NavBarHeight + SYS_TabBarHeight + SYS_TabBarFloatHeight)

//颜色
#define  UIColorFromRGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define UIColorFromRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
#define UIColorFromRGBRandomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define UIColorFromHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// View 圆角和加边框
#define ViewRadius(view, radius) [XBUtils setViewBorderRadius:view Radius:radius]
#define ViewBorderRadius(view, radius, width, color) [XBUtils setViewBorderRadius:view Radius:radius Widt:width Color:color]

//拼接字符
#define StringValue(object) [NSString stringWithFormat:@"%@",object]
#define StringFormat(format,...) [NSString stringWithFormat:format, ##__VA_ARGS__]

//是否登录
#define SYSIsLogined  [[UserInfo sharedInstance]isLogined]
//window
#define SYSWindow [[UIApplication sharedApplication] keyWindow]
//Delegate
#define SYSDelegate [[UIApplication sharedApplication] delegate]
///弱引用 weakSelf
#define WEAK_SELF __weak typeof(self) weakSelf = self
//强引用
#define STRONG_SELF __strong typeof(self) strongSelf = weakSelf
//获取图片资源
#define kSetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]
// 持久化
#define DEFAULTS   [NSUserDefaults standardUserDefaults]// 持久化
//宏定义检测block是否可用
#define BLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); };
//字符串不为空
#define kStringIsEmpty(str) (![XBUtils isValString:str])
//数组不为空
#define kArrayIsEmpty(array) (![XBUtils isValValArray:array])
//字典为空
#define kDictIsEmpty(dic) (![XBUtils isValDictionary:dic])
//不为空对象
#define kObjectIsEmpty(object) (![XBUtils isValObject:object])
// 系统性参数
#define IS_iPhoneX ((SYS_StatusBarHeight > 20) ? YES : NO)
// GCD 延迟
#define dispatch_async_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}



//** DEBUG LOG *********************************************************************************
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#define DLog( s, ... ) NSLog( @"< %@:(%d) > %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
# define JSLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define NSLog(FORMAT, ...) nil
#define DLog( s, ... )
#define JSLog(format, ...)
#endif


//** 获得当前的 年 月 日 时 分 秒 *****************************************************************************
#define  CurrentSec [[NSCalendar currentCalendar] component:NSCalendarUnitSecond fromDate:[NSDate date]]
#define  CurrentMin [[NSCalendar currentCalendar] component:NSCalendarUnitMinute fromDate:[NSDate date]]
#define  CurrentHour [[NSCalendar currentCalendar] component:NSCalendarUnitHour fromDate:[NSDate date]]
#define  CurrentDay  [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:[NSDate date]]
#define  CurrentMonth [[NSCalendar currentCalendar] component:NSCalendarUnitMonth fromDate:[NSDate date]]
#define  CurrentYear [[NSCalendar currentCalendar] component:NSCalendarUnitYear fromDate:[NSDate date]]

#endif /* CommonlyUsed_h */
