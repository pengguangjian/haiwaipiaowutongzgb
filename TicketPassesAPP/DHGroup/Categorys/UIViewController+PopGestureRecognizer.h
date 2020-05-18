//
//  UIViewController+PopGestureRecognizer.h
//  TicketPassesAPP
//
//  Created by caochun on 2019/10/25.
//  Copyright © 2019 macbook. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (PopGestureRecognizer)
// 禁用侧滑返回手势
+ (void)popGestureClose:(UIViewController *)VC;
// 启用侧滑返回手势
+ (void)popGestureOpen:(UIViewController *)VC;

@end

NS_ASSUME_NONNULL_END
