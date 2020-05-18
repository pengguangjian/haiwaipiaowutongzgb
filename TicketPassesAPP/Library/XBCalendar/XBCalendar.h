//
//  XBCalendar.h
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/28.
//  Copyright © 2019 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXCalendarView.h"
#import "LXCalendarMonthModel.h"

NS_ASSUME_NONNULL_BEGIN



@protocol XBCalendarDelegate <NSObject>

- (void)selectTimerEnd:(LXCalendarDayModel *)model;

@end

@interface XBCalendar : UIView


///视图
@property (strong, nonatomic)  UIView *mView;
//白色背景
@property (strong, nonatomic)  UIView *headView;
//黑色背景
@property (strong, nonatomic)  UIView *mTableBaseView;

@property (strong, nonatomic)  LXCalendarView *calenderView;

@property (strong , nonatomic) UIButton *queButton;
//时间
@property (strong , nonatomic) LXCalendarDayModel *timeMoel;

@property (nonatomic, weak) id<XBCalendarDelegate> delegate;

- (void)showMenu;

- (void)hideMenu;

//上
- (void)selectCalendarUpper;
//下
- (void)selectCalendarLower;

@end

NS_ASSUME_NONNULL_END
