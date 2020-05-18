//
//  UIViewController+SBKit.h
//  szshoubao
//
//  Created by xiao_shoubao on 16/6/13.
//  Copyright © 2016年 YQLshoubao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>


@interface UIViewController (XBKit)



#pragma +++++++++++++++++++设置导航栏按钮+++++++++++++++++++++

/**
 *  创建右上角按钮
 *
 *  @param name 按钮文字
 */
- (void)addRightBarButton:(NSString *)name;
/**
 *  创建右上角按钮
 *
 *  @param image 按钮图片
 */
- (void)addRightBarButtonImage:(UIImage *)image;
/**
 *  创建右上角按钮
 *
 *  @param systemItem 系统样式
 */
- (void)addRightBarButtonSystemItem:(UIBarButtonSystemItem)systemItem;
/**
 *  右上角按钮点击事件
 *
 *  @param sender 按钮
 */
- (void)clickRightBarButton:(UIButton *)sender;

//---------------------------------------------------------------

/**
 *  创建左上角按钮
 *
 *  @param name 按钮文字
 */
- (void)addLeftBarButton:(NSString *)name;

/**
 *  创建左上角按钮
 *
 *  @param image 按钮图片
 */
- (void)addLeftBarButtonImage:(UIImage *)image;
/**
 *  创建右上角按钮
 *
 *  @param systemItem 系统样式
 */
- (void)addLeftBarButtonSystemItem:(UIBarButtonSystemItem)systemItem;

/**
 *  左上角按钮事件
 *
 *  @param sender 按钮
 */
- (void)clickLeftBarButton:(UIButton *)sender;
//---------------------------------------------------------------



#pragma +++++++++++++++++++监听键盘+++++++++++++++++++++
/*  监听键盘
 *
 */
- (void)addKeyBoard;
//移除通知监听
- (void)removeKeyBoard;
/*
 *      键盘出来
 */
- (void)keyboardWillShow: (NSNotification *)notification;
/*
 *      键盘隐藏
 */
- (void)keyboardWillHide: (NSNotification *)notification;

#pragma +++++++++++++++++++返回上一层+++++++++++++++++++++
/**
 *  返回上一页
 */
-(void)onBack;

/**
 *  当前控制器的前一控制器
 *
 *  @return UIViewController
 */
- (UIViewController *)ToViewController;

/**
 *  当前控制器的前面的控制器
 *
 *  @param number 前面第几个控制器
 *
 *  @return UIViewController
 */
- (UIViewController *)ToViewControllerNumber:(NSInteger)number ;
/**
 *  识别哪个控制器
 *
 *  @param strClassName 控制器的名字
 *
 *  @return UIViewController
 */
- (UIViewController *)ToViewControllerName:(NSString *)strClassName;


/*
 *      找出当前页面的前面所有页面
 */
- (NSArray *)lookingViewControllers;



@end
