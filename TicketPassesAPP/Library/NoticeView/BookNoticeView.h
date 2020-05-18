//
//  BookNoticeView.h
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/30.
//  Copyright © 2019 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN



@interface BookNoticeView : UIView

+ (instancetype)sharedSingleton ;

///视图
@property (strong, nonatomic)  UIView *mView;
//白色背景
@property (strong, nonatomic)  UIView *headView;
//黑色背景
@property (strong, nonatomic)  UIView *mTableBaseView;

//标题
@property (strong , nonatomic) UILabel *title;
//确认
@property (strong , nonatomic) UIButton *queren;
//取消
@property (strong , nonatomic) UIButton *quxiao;
//内容
@property (nonatomic, strong) WKWebView *webView;
////内容
//@property (strong , nonatomic) UITextView *congtext;
//确认
@property (nonatomic, copy) void (^confirmBookNoticeViewBloak)(void);

- (void)showMenu;

- (void)hideMenu;

@end

NS_ASSUME_NONNULL_END
