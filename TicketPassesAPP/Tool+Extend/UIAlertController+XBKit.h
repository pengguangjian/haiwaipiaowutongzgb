//
//  UIAlertController+SBKit.h
//  shoubao_app
//
//  Created by 开涛 on 16/9/19.
//  Copyright © 2016年 shobaochuanmei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (XBKit)

///返回Sheet
+(UIAlertController *)showActionSheetwithTitle:(NSString *)title Message:(NSString *)message;
///返回Sheet
+(UIAlertController *)showAlertwithTitle:(NSString *)title Message:(NSString *)message;


///确认和取消 的提示
+(void)showAlertwithTitle:(NSString *)title Message:(NSString *)message withVC:(UIViewController *)VC cancelBlock:(void (^)(id objc))cancelBlock withBlock:(void (^)(id objc))withBlock;

///取消按钮 无效的情况
+(void)showAlertwithTitle:(NSString *)title Message:(NSString *)message withVC:(UIViewController *)VC withBlock:(void (^)(id objc))withBlock;

///只有确认按钮时
+(void)showAlertwithMessage:(NSString *)message withVC:(UIViewController *)VC withBlock:(void (^)(id objc))withBlock;


@end
