//
//  XBUtils.h
//  TheRiderAPP
//
//  Created by 肖世恒 on 2019/6/23.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XBUtils : NSObject

+ (BOOL)networkEnable;

+ (NSString *)getAppName;
+ (NSString *)getAppVersion;
+ (NSString *)getAppBuild;


#pragma mark 解析数据为model属性
+ (void)nslogPropertyWithDic:(NSDictionary *)dic;
#pragma mark 处理电话号码中间为*号
+ (NSString *)dealWithPhoneW:(NSString *)iphone;
#pragma mark 是不是电话 （YES：电话）
+ (BOOL)isPhone:(id)string;
#pragma mark 判断值是否为空，null，nil等...（YES：为空）
+ (BOOL)isValObject:(id)string;
#pragma mark 判断字符串值是否为空，null，nil等...（YES：为空）
+ (BOOL)isValString:(id)string;
#pragma mark 判断数组值是否为空，null，nil等...（YES：为空）
+ (BOOL)isValArray:(id)array;
#pragma mark 判断字典值是否为空，null，nil等...（YES：为空）
+ (BOOL)isValDictionary:(id)dic;
//UTF-8编码
+ (NSString *)encodeToPercentEscapeString:(NSString *)input;

#pragma mark  设置圆角
+ (void)setViewBorderRadius:(UIView *)view Radius:(CGFloat)radius;
+ (void)setViewBorderRadius:(UIView *)view Radius:(CGFloat)radius Widt:(CGFloat)width Color:(UIColor * _Nullable)color;

//登录
+ (void)SYSLogInRootController;
//退出
+ (void)SYSOutRootController;
//切换 控制器
+ (void)SYSRootController:(Class)rootController;
//切换语言重置当前界面
+ (void)SYSResetRootController;

@end

NS_ASSUME_NONNULL_END
