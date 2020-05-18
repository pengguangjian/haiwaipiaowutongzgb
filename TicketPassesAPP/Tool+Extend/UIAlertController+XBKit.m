//
//  UIAlertController+SBKit.m
//  shoubao_app
//
//  Created by 开涛 on 16/9/19.
//  Copyright © 2016年 shobaochuanmei. All rights reserved.
//

#import "UIAlertController+XBKit.h"

@implementation UIAlertController (XBKit)



+(UIAlertController *)showActionSheetwithTitle:(NSString *)title Message:(NSString *)message{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    return alertController;
}

+(UIAlertController *)showAlertwithTitle:(NSString *)title Message:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    return alertController;
}

+(void)showAlertwithTitle:(NSString *)title Message:(NSString *)message withVC:(UIViewController *)VC cancelBlock:(void (^)(id objc))cancelBlock withBlock:(void (^)(id objc))withBlock
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    
    if (cancelBlock) {
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
             cancelBlock(action);
            
            
        }]];
        
    }
    
    
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (withBlock) { withBlock(action); }
        
        
    }]];
    
    [VC presentViewController:alertController animated:YES completion:nil];
    
}

+(void)showAlertwithTitle:(NSString *)title Message:(NSString *)message withVC:(UIViewController *)VC withBlock:(void (^)(id objc))withBlock
{
    
    
    [self showAlertwithTitle:title Message:message withVC:VC cancelBlock:^(id objc){
    } withBlock:withBlock];
    
}

+(void)showAlertwithMessage:(NSString *)message withVC:(UIViewController *)VC withBlock:(void (^)(id objc))withBlock
{
    
    ///只有确认按钮时
    [self showAlertwithTitle:@"温馨提示" Message:message withVC:VC cancelBlock:nil  withBlock:withBlock];
    
    
}
@end
