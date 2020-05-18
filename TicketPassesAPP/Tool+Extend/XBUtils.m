//
//  XBUtils.m
//  TheRiderAPP
//
//  Created by 肖世恒 on 2019/6/23.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import "XBUtils.h"

#define YT_API_HOST   @"example.com"

@implementation XBUtils


+ (BOOL)networkEnable {
    
    //Reachability的方法判断
    Reachability *reach = [Reachability reachabilityWithHostname:YT_API_HOST];
    return reach.isReachable;
}

+ (NSString *)getAppName{
    // app名称
    NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [infoPlist objectForKey:@"CFBundleDisplayName"];
    return appName;
}
+ (NSString *)getAppVersion{
    // app版本
    NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoPlist objectForKey:@"CFBundleShortVersionString"];
    return appVersion;
}
+ (NSString *)getAppBuild{
    //app build
    NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
    NSString *appBuild = [infoPlist objectForKey:@"CFBundleVersion"];
    return appBuild;
}

+ (void)nslogPropertyWithDic:(NSDictionary *)dic {
    
    if (![dic isKindOfClass:[NSDictionary class]]) {
        NSLog(@"无法解析为model，因为传入参数不是一个字典");
        return;
    }
    
    if (dic.count == 0) {
        NSLog(@"无法解析为model，因为该字典为空");
        return;
    }
    
    
    NSMutableString *strM = [NSMutableString string];
    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        NSString *className = NSStringFromClass([obj class]) ;
        NSLog(@"className:%@/n", className);
        if ([className isEqualToString:@"__NSCFString"] | [className isEqualToString:@"__NSCFConstantString"] | [className isEqualToString:@"NSTaggedPointerString"]) {
            [strM appendFormat:@"@property (nonatomic, copy) NSString *%@;\n",key];
        }else if ([className isEqualToString:@"__NSCFArray"] |
                  [className isEqualToString:@"__NSArray0"] |
                  [className isEqualToString:@"__NSArrayI"]){
            [strM appendFormat:@"@property (nonatomic, strong) NSArray *%@;\n",key];
        }else if ([className isEqualToString:@"__NSCFDictionary"]){
            [strM appendFormat:@"@property (nonatomic, strong) NSDictionary *%@;\n",key];
        }else if ([className isEqualToString:@"__NSCFNumber"]){
            [strM appendFormat:@"@property (nonatomic, copy) NSNumber *%@;\n",key];
        }else if ([className isEqualToString:@"__NSCFBoolean"]){
            [strM appendFormat:@"@property (nonatomic, assign) BOOL   %@;\n",key];
        }else if ([className isEqualToString:@"NSDecimalNumber"]){
            [strM appendFormat:@"@property (nonatomic, copy) NSString *%@;\n",[NSString stringWithFormat:@"%@",key]];
        }
        else if ([className isEqualToString:@"NSNull"]){
            [strM appendFormat:@"@property (nonatomic, copy) NSString *%@;\n",[NSString stringWithFormat:@"%@",key]];
        }else if ([className isEqualToString:@"__NSArrayM"]){
            [strM appendFormat:@"@property (nonatomic, strong) NSMutableArray *%@;\n",[NSString stringWithFormat:@"%@",key]];
        }
        
    }];
    NSLog(@"\n%@\n",strM);
}
+ (NSString *)dealWithPhoneW:(NSString *)iphone{
    
    if([self isPhone:iphone]){
     //取前3位
        NSString *headstr = [iphone substringToIndex:3];
    //取后4位
        NSString *tailstr = [iphone substringFromIndex:7];
    //中间拼接 3位 *  搞定
        NSString *dealstr = [NSString stringWithFormat:@"%@***%@",headstr,tailstr];
        
        return dealstr;
        
    }
    NSLog(@"垃圾 什么都是不是啊");
    return iphone;
}
+ (BOOL)isPhone:(id)string{
    if([self isValString:string]){
        return NO;
    }
    return YES;
//    NSString * PHS = @"^((\\+86)|(86))?(1[0-9])\\d{9}$";
//    NSPredicate *TalTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",PHS];
//    return [TalTest evaluateWithObject:string];
}
+ (BOOL)isValObject:(id)object{
    if(![object isKindOfClass:[NSObject class]]){
        NSLog(@"嘿SB，这不是对象");
        return YES;
    }
    if([object isKindOfClass:[NSString class]]){
        return [XBUtils isValString:object];
    }
    if([object isKindOfClass:[NSArray class]]){
        return [XBUtils isValArray:object];
    }
    if([object isKindOfClass:[NSDictionary class]]){
        return [XBUtils isValDictionary:object];
    }
    if(([object respondsToSelector:@selector(length)] && [(NSData *)object length] == 0)){
        return YES;
    }
    NSLog(@"排除4个类型后不为空");
    return NO;
}
#pragma mark 判断字符串是否为空，null，nil等...（YES：为空）
+ (BOOL)isValString:(id)string
{
    NSString *toString = [[NSString alloc]initWithFormat:@"%@",string];
    if(![toString isKindOfClass:[NSString class]]){
        NSLog(@"嘿SB，这不是字符串");
        return YES;
    }
    if (toString == nil || toString == NULL) {
        return YES;
    }
    if ([toString isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([toString isEqualToString:@""]) {
        return YES;
    }
    
    if ([toString isEqualToString:@"(null)"]) {
        return YES;
    }
    
    if ([toString isEqualToString:@"null"]) {
        return YES;
    }
    
    if ([toString isEqualToString:@"<null>"]) {
        return YES;
    }
    
    if ([toString stringByReplacingOccurrencesOfString:@" " withString:@""].length<=0) {
        return YES;
    }
    
    return NO;
}
#pragma mark 判断数组值是否为空，null，nil等...（YES：为空）
+ (BOOL)isValArray:(id)array{
    NSArray *toArray = [[NSArray alloc]initWithArray:array];
    if(![toArray isKindOfClass:[NSArray class]]){
        NSLog(@"嘿SB，这不是数组");
        return YES;
    }
    if (toArray == nil || toArray == NULL) {
        return YES;
    }
    if( [toArray isKindOfClass:[NSNull class]] ){
        return YES;
    }
    if( [toArray count] == 0){
        return YES;
    }
    return NO;
}
#pragma mark 判断字典值是否为空，null，nil等...（YES：为空）
+ (BOOL)isValDictionary:(id)dic{
    NSDictionary *toDic = [[NSDictionary alloc]initWithDictionary:dic];
    if(![toDic isKindOfClass:[NSDictionary class]]){
        NSLog(@"嘿SB，这不是字典");
        return YES;
    }
    if (toDic == nil || toDic == NULL) {
        return YES;
    }
    if( [toDic isKindOfClass:[NSNull class]] ){
        return YES;
    }
    if([toDic allKeys] == 0){
        return YES;
    }
    return NO;
}
//UTF-8编码
+ (NSString *)encodeToPercentEscapeString:(NSString *)input
{
    
    NSString *outputStr = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)input,
                                                              NULL,
                                                              (CFStringRef)@"*'();@+$,%#[]",
                                                              kCFStringEncodingUTF8));
    
    return outputStr;
    
}
+ (void)setViewBorderRadius:(UIView *)view Radius:(CGFloat)radiu{
    [XBUtils setViewBorderRadius:view Radius:radiu Widt:0 Color:nil];
}
+ (void)setViewBorderRadius:(UIView *)view Radius:(CGFloat)radius Widt:(CGFloat)width Color:(UIColor * _Nullable)color{
    [view.layer setCornerRadius:(radius)];
    [view.layer setMasksToBounds:YES];
    if(width != 0){
        [view.layer setBorderWidth:(width)];
        if(color != nil){
            [view.layer setBorderColor:[color CGColor]];
        }
    }
}
+ (CAAnimation*)exitAnim{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3f];
    animation.type = @"fade";
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    return animation;
}
//登录
+ (void)SYSLogInRootController{
    
    [XBUtils SYSRootController:[BaseTabBarVC class]];
}
//退出
+ (void)SYSOutRootController{
    
    [XBUtils SYSRootController:[LoginVC class]];
    
}
+ (void)SYSRootController:(Class)rootController{
    
    if([NSStringFromClass(rootController) isEqualToString:@"LoginVC"] || [NSStringFromClass(rootController) isEqualToString:@"RegisteredViewController"]){
        
        UIViewController * vc = [[rootController alloc] init];
        BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:vc];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [[UIApplication sharedApplication].keyWindow.layer addAnimation:[self exitAnim] forKey:nil];
        window.rootViewController = nav;
        [window makeKeyAndVisible];
        
    }else{
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [[UIApplication sharedApplication].keyWindow.layer addAnimation:[self exitAnim] forKey:nil];
        UIViewController * vc = [[rootController alloc] init];
        window.rootViewController = vc;
        [window makeKeyAndVisible];
    }
    
}
//切换语言重置当前界面
+ (void)SYSResetRootController{

    dispatch_async(dispatch_get_main_queue(), ^{
        if (SYSIsLogined) {
            [XBUtils SYSRootController:[BaseTabBarVC class]];
        }else{
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            if([window.rootViewController isKindOfClass:[BaseNavigationController class]]){
                BaseNavigationController *navc = (BaseNavigationController *)window.rootViewController;
                if([navc.topViewController isKindOfClass:[LoginVC class]]){
                    [XBUtils SYSRootController:[LoginVC class]];
                }else{
                    [XBUtils SYSRootController:[RegisteredViewController class]];
                }
            }
        }
        
    });
    
}
@end
