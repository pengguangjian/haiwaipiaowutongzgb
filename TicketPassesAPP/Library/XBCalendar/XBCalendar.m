
//
//  XBCalendar.m
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/28.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "XBCalendar.h"
#define XBCalendarH 460

@implementation XBCalendar

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self addSubview:self.mTableBaseView];
        [self addSubview:self.mView];
        [self.mView addSubview:self.calenderView];
        [self.mView addSubview:self.queButton];
        WEAK_SELF;
        [self.calenderView setSelectBlock:^(LXCalendarDayModel *model){
            NSLog(@"%ld年 - %ld月 - %ld日 -%ld",model.year,model.month,model.day,model.firstWeekday);
            
            weakSelf.timeMoel = model;
        
        }];
        
        
        
    }
    return self;
}
- (void)muneButtonTaped:(UIButton *)button{
 
    
    [self hideMenu];
    
    if(!_timeMoel){
        return;
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(selectTimerEnd:)]){
        [self.delegate selectTimerEnd:self.timeMoel];
    }
}
//上
- (void)selectCalendarUpper{
    [self.calenderView selectUpper];
    if(!_timeMoel){
        return;
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(selectTimerEnd:)]){
        [self.delegate selectTimerEnd:self.timeMoel];
    }
}
//下
- (void)selectCalendarLower{
    [self.calenderView selectLowerL];
    if(!_timeMoel){
        return;
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(selectTimerEnd:)]){
        [self.delegate selectTimerEnd:self.timeMoel];
    }
}


///通知出现
- (void)showMenu{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    
    self.mTableBaseView.alpha = 0;
    self.mView.alpha = 1;
    self.mView .frame =  CGRectMake(0, SCREENH_HEIGHT, SCREEN_WIDTH, XBCalendarH + SYS_TabBarFloatHeight);
    [UIView animateWithDuration:0.3 animations:^{
        
        self.mView .frame =  CGRectMake(0, SCREENH_HEIGHT -XBCalendarH - SYS_TabBarFloatHeight, SCREEN_WIDTH, XBCalendarH + SYS_TabBarFloatHeight);
        self.mView.alpha = 1;
        self.mTableBaseView.alpha = 0.4;
    }];
    
}
///通知隐藏

- (void)hideMenu{
    
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.mView .frame =  CGRectMake(0, SCREENH_HEIGHT, SCREEN_WIDTH, XBCalendarH + SYS_TabBarFloatHeight);
                         self.mView. alpha = 0;
                         self.mTableBaseView.alpha = 0;
                         
                         
                     }
                     completion:^(BOOL finished){
                         
                         [self removeFromSuperview];
                         
                         
                     }];
    
}

-(void)bgTappedAction:(UITapGestureRecognizer *)tap
{
    [self hideMenu];
    
}
- (UIButton *)queButton{
    if(!_queButton){
        
        UIButton *muneButton1 = [[UIButton alloc]init];
        muneButton1.tag = 1001;
        muneButton1.frame = CGRectMake(30, 410, SCREEN_WIDTH - 60, 42);
        muneButton1.titleLabel.font = [UIFont systemFontOfSize:15];
        [muneButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [muneButton1 setTitle:NSBundleLocalizedString(@"确认") forState:UIControlStateNormal];
        [muneButton1 addTarget: self action: @selector(muneButtonTaped:) forControlEvents: UIControlEventTouchUpInside];
        muneButton1.backgroundColor = UIColorFromHex(0x56b157);
        [muneButton1.layer setCornerRadius:3.0f];
        [muneButton1.layer setMasksToBounds:YES];
    
        _queButton  = muneButton1;
        
    }
    return _queButton;
}
- (LXCalendarView *)calenderView{
    if(!_calenderView){
        LXCalendarView *calendarView =[[LXCalendarView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
        
        calendarView.currentMonthTitleColor =UIColorFromHex(0x2c2c2c);
        calendarView.lastMonthTitleColor =UIColorFromHex(0xa8a8a8);
        calendarView.nextMonthTitleColor =UIColorFromHex(0xa8a8a8);
        
        calendarView.isHaveAnimation = YES;
        
        calendarView.isCanScroll = NO;
        
        calendarView.isShowLastAndNextBtn = YES;
        
        calendarView.isShowLastAndNextDate = YES;
        //今天颜色
        calendarView.todayTitleColor = UIColorFromHex(0x56b157);
        //选择颜色
        calendarView.selectBackColor = UIColorFromHex(0x56b157);
        
        calendarView.selectTitleColor = [UIColor whiteColor];
        
        calendarView.backgroundColor =[UIColor whiteColor];
        
        [calendarView dealData];
        
        _calenderView = calendarView;
        
    }
    return _calenderView;
}

- (UIView *)mView{
    if(!_mView){
        _mView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENH_HEIGHT -XBCalendarH - SYS_TabBarFloatHeight, SCREEN_WIDTH, XBCalendarH + SYS_TabBarFloatHeight)];
        _mView.backgroundColor = [UIColor whiteColor];
        
        
    }
    return _mView;
    
}

- (UIView *)mTableBaseView{
    if(!_mTableBaseView){
        _mTableBaseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT )];
        _mTableBaseView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTappedAction:)];
        [_mTableBaseView addGestureRecognizer:bgTap];
    }
    return _mTableBaseView;
}
@end
