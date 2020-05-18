//
//  LXCalendarView.m
//  LXCalendar
//
//  Created by chenergou on 2017/11/2.
//  Copyright © 2017年 漫漫. All rights reserved.
//
#import "LXCalendarHead.h"
#import "LXCalendarView.h"
#import "LXCalendarHearder.h"
#import "LXCalendarWeekView.h"
#import "LXCalenderCell.h"
#import "LXCalendarMonthModel.h"
#import "NSDate+GFCalendar.h"
#import "LXCalendarDayModel.h"

@interface LXCalendarView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)LXCalendarHearder *calendarHeader; //头部
@property(nonatomic,strong)LXCalendarWeekView *calendarWeekView;//周
@property(nonatomic,strong)UICollectionView *collectionView;//日历
@property(nonatomic,strong)NSMutableArray *monthdataA;//当月的模型集合
@property(nonatomic,strong)NSDate *currentMonthDate;//当月的日期
@property(nonatomic,strong)UISwipeGestureRecognizer *leftSwipe;//左滑手势
@property(nonatomic,strong)UISwipeGestureRecognizer *rightSwipe;//右滑手势
@property(nonatomic,strong)LXCalendarDayModel *selectModel;
@property(nonatomic,strong)NSIndexPath *selectIndexPathI;


@end
@implementation LXCalendarView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.currentMonthDate = [NSDate date];

        
        [self setup];
        
        
    }
    return self;
}
-(void)dealData{
    
    
    [self responData];
}
-(void)setup{
    [self addSubview:self.calendarHeader];
    
    LXWeakSelf(weakSelf);
    self.calendarHeader.leftClickBlock = ^{
        [weakSelf rightSlide];
    };
    
    self.calendarHeader.rightClickBlock = ^{
        [weakSelf leftSlide];

    };
    [self addSubview:self.calendarWeekView];
    
    [self addSubview:self.collectionView];
    
    self.lx_height = self.collectionView.lx_bottom;
    
    
    //添加左滑右滑手势
   self.leftSwipe =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
   self.leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.collectionView addGestureRecognizer:self.leftSwipe];
    
    self.rightSwipe =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
    self.rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.collectionView addGestureRecognizer:self.rightSwipe];
}
#pragma mark --左滑手势--
-(void)leftSwipe:(UISwipeGestureRecognizer *)swipe{
    
    [self leftSlide];
}
#pragma mark --左滑处理--
-(void)leftSlide{
    self.currentMonthDate = [self.currentMonthDate nextMonthDate];
    
    [self performAnimations:kCATransitionFromRight];
    [self responData];
}
#pragma mark --右滑处理--
-(void)rightSlide{
    //过去的日子
    NSDate *lastData = [self.currentMonthDate previousMonthDate];
    LXCalendarMonthModel *lastMonthModel = [[LXCalendarMonthModel alloc]initWithDate:lastData];
    //这月
    NSDate *monthData = [NSDate date];
    LXCalendarMonthModel *monthModel = [[LXCalendarMonthModel alloc]initWithDate:monthData];
    
    if(lastMonthModel.year < monthModel.year){
        return;
    }else if(lastMonthModel.year == monthModel.year){
        //等于年份的时候
        if(lastMonthModel.month < monthModel.month){
            return;
        }
    }else{
        //大于年份的时候 不用想 都是ok 的
    }

    self.currentMonthDate = [self.currentMonthDate previousMonthDate];
    [self performAnimations:kCATransitionFromLeft];
    
    [self responData];
}
#pragma mark --右滑手势--
-(void)rightSwipe:(UISwipeGestureRecognizer *)swipe{
   
    [self rightSlide];
}
#pragma mark--动画处理--
- (void)performAnimations:(NSString *)transition{
    CATransition *catransition = [CATransition animation];
    catransition.duration = 0.5;
    [catransition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    catransition.type = kCATransitionPush; //choose your animation
    catransition.subtype = transition;
    [self.collectionView.layer addAnimation:catransition forKey:nil];
}

#pragma mark--数据以及更新处理--
-(void)responData{
    
    [self.monthdataA removeAllObjects];
    
    //上月
    NSDate *previousMonthDate = [self.currentMonthDate previousMonthDate];
    
//    NSDate *nextMonthDate = [self.currentMonthDate  nextMonthDate];
    //本月
    LXCalendarMonthModel *monthModel = [[LXCalendarMonthModel alloc]initWithDate:self.currentMonthDate];
    //上月
    LXCalendarMonthModel *lastMonthModel = [[LXCalendarMonthModel alloc]initWithDate:previousMonthDate];
    
//     LXCalendarMonthModel *nextMonthModel = [[LXCalendarMonthModel alloc]initWithDate:nextMonthDate];
    
    self.calendarHeader.dateStr = [NSBundle getNian:[NSString stringWithFormat:@"%i",monthModel.year] Yue:[NSString stringWithFormat:@"%i",monthModel.month]];
    
    NSInteger firstWeekday = monthModel.firstWeekday;
    
    NSInteger totalDays = monthModel.totalDays;
    //周几
    NSInteger weekday = firstWeekday;
    for (int i = 0; i <42; i++) {
        
        LXCalendarDayModel *model =[[LXCalendarDayModel alloc]init];
        
        //配置外面属性
        [self configDayModel:model];
        
        model.row = i;
        model.firstWeekday = firstWeekday;
        model.totalDays = totalDays;
        
        model.month = monthModel.month;
        
        model.year = monthModel.year;
        
        
        //上个月的日期
        if (i < firstWeekday) {
            model.month = model.month -1;
            model.day = lastMonthModel.totalDays - (firstWeekday - i) + 1;
            model.isLastMonth = YES;
        }
        
        //当月的日期
        if (i >= firstWeekday && i < (firstWeekday + totalDays)) {
            
            model.day = i -firstWeekday +1;
            model.isCurrentMonth = YES;
            
            //标识是今天
            if ((monthModel.month == [[NSDate date] dateMonth]) && (monthModel.year == [[NSDate date] dateYear])) {
                if (i == [[NSDate date] dateDay] + firstWeekday - 1) {
                    
                    model.isToday = YES;
                    
                }                 
            }
            model.weekday = weekday;
            weekday ++;
            if(weekday>=7){
                weekday = 0;
            }
            
        }
         //下月的日期
        if (i >= (firstWeekday + monthModel.totalDays)) {
            if(model.month == 12){
                model.year = model.year + 1;
                model.month = 1;
            }else{
                model.month = model.month  + 1;
            }
            model.month = model.month + 1;
            model.day = i -firstWeekday - monthModel.totalDays +1;
            model.isNextMonth = YES;
            
        }
        
        [self.monthdataA addObject:model];
        
    }
    
    
    [self.monthdataA enumerateObjectsUsingBlock:^(LXCalendarDayModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ((obj.year == self.selectModel.year) && (obj.month == self.selectModel.month) && (obj.day == self.selectModel.day)) {
            obj.isSelected = YES;
        }
    }];
    [self.collectionView reloadData];
    
}
-(void)configDayModel:(LXCalendarDayModel *)model{
    

    //配置外面属性
    model.isHaveAnimation = self.isHaveAnimation;
    
    model.currentMonthTitleColor = self.currentMonthTitleColor;
    
    model.lastMonthTitleColor = self.lastMonthTitleColor;
    
    model.nextMonthTitleColor = self.nextMonthTitleColor;
    
    model.selectBackColor = self.selectBackColor;
    
    model.selectTitleColor = self.selectTitleColor;
    
    model.isHaveAnimation = self.isHaveAnimation;
    
    model.todayTitleColor = self.todayTitleColor;
    
    model.isShowLastAndNextDate = self.isShowLastAndNextDate;

}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.monthdataA.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIndentifier = @"cell";
    LXCalenderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifier forIndexPath:indexPath];
    if (!cell) {
        cell =[[LXCalenderCell alloc]init];
        
    }
    
    cell.model = self.monthdataA[indexPath.row];

    cell.backgroundColor =[UIColor whiteColor];
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    LXCalendarDayModel *model = self.monthdataA[indexPath.row];
    model.isSelected = YES;
    //选中的day
    self.selectModel = model;
    [self.monthdataA enumerateObjectsUsingBlock:^(LXCalendarDayModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj != model) {
            obj.isSelected = NO;
        }
    }];
    
    if (self.selectBlock) {
        self.selectBlock(model);
    }
    self.selectIndexPathI = indexPath;
    [collectionView reloadData];
    
}
- (void)selectUpper{
    //不能超过今天
    
    NSInteger row  = self.selectIndexPathI.row - 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    LXCalendarDayModel *model = self.monthdataA[indexPath.row];
 
    NSDate *monthData = [NSDate date];
    LXCalendarMonthModel *monthModel = [[LXCalendarMonthModel alloc]initWithDate:monthData];
    if(model.year < monthModel.year){
        return;
    }else if(model.year == monthModel.year){
        //等于年份的时候
        if(model.month < monthModel.month){
            return;
        }
        if(model.month == monthModel.month){
            if(model.day < monthModel.day){
                return;
            }
        }
    }else{
        //大于年份的时候 不用想 都是ok 的
    }
    
    //上个月第一天
    //当前day
    LXCalendarDayModel *eyesmodel = self.monthdataA[self.selectIndexPathI.row];
    if(eyesmodel.day == 1){
        
        [self rightSlide];
        //并让最后一天选中
        NSInteger row = 0  ;
        for (int i = 41; i>=0; i--) {
            
            LXCalendarDayModel *model = self.monthdataA[i];
            if(model.isCurrentMonth){
                //当月
                row = model.row;
                break;
            }
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        [self collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];
        
        
    }else{
        [self collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];
    }

}
- (void)selectLowerL{
    //当前day
    LXCalendarDayModel *eyesmodel = self.monthdataA[self.selectIndexPathI.row];
    if(eyesmodel.day == eyesmodel.totalDays){
        //最后一天
        [self leftSlide];
        //并让选中第一天
        NSInteger row = 0  ;
        for (int i = 0; i<=41; i++) {
            
            LXCalendarDayModel *model = self.monthdataA[i];
            if(model.isCurrentMonth){
                //当月
                row = model.row;
                break;
            }
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        [self collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];
    }else{
        //下
        NSInteger row  = self.selectIndexPathI.row + 1;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        [self collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];
    }
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.calendarHeader.frame = CGRectMake(0, 0, self.lx_width, 50);
}
#pragma mark---懒加载
-(LXCalendarHearder *)calendarHeader{
    if (!_calendarHeader) {
        _calendarHeader =[LXCalendarHearder showView];
        _calendarHeader.frame = CGRectMake(0, 0, self.lx_width, 50);
        _calendarHeader.backgroundColor =[UIColor whiteColor];
    }
    return _calendarHeader;
}
-(LXCalendarWeekView *)calendarWeekView{
    if (!_calendarWeekView) {
        _calendarWeekView =[[LXCalendarWeekView alloc]initWithFrame:CGRectMake(0, self.calendarHeader.lx_bottom, self.lx_width, 50)];
        
        _calendarWeekView.weekTitles = @[NSBundleLocalizedString(@"周日"),
                                         NSBundleLocalizedString(@"周一"),
                                         NSBundleLocalizedString(@"周二"),
                                         NSBundleLocalizedString(@"周三"),
                                         NSBundleLocalizedString(@"周四"),
                                         NSBundleLocalizedString(@"周五"),
                                         NSBundleLocalizedString(@"周六")];
    }
    return _calendarWeekView;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        
        
        UICollectionViewFlowLayout *flow =[[UICollectionViewFlowLayout alloc]init];
        //325*403
        flow.minimumInteritemSpacing = 0;
        flow.minimumLineSpacing = 0;
        flow.sectionInset =UIEdgeInsetsMake(0 , 0, 0, 0);
        
        flow.itemSize = CGSizeMake(self.lx_width/7, 50);
        _collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, self.calendarWeekView.lx_bottom, self.lx_width, 6 * 50) collectionViewLayout:flow];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollsToTop = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        UINib *nib = [UINib nibWithNibName:@"LXCalenderCell" bundle:nil];
        [_collectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
        
        
    }
    return _collectionView;
}
-(NSMutableArray *)monthdataA{
    if (!_monthdataA) {
        _monthdataA =[NSMutableArray array];
    }
    return _monthdataA;
}
/*
 * 当前月的title颜色
 */
-(void)setCurrentMonthTitleColor:(UIColor *)currentMonthTitleColor{
    _currentMonthTitleColor = currentMonthTitleColor;
}
/*
 * 上月的title颜色
 */
-(void)setLastMonthTitleColor:(UIColor *)lastMonthTitleColor{
    _lastMonthTitleColor = lastMonthTitleColor;
}
/*
 * 下月的title颜色
 */
-(void)setNextMonthTitleColor:(UIColor *)nextMonthTitleColor{
    _nextMonthTitleColor = nextMonthTitleColor;
}

/*
 * 选中的背景颜色
 */
-(void)setSelectBackColor:(UIColor *)selectBackColor{
    _selectBackColor = selectBackColor;
}
- (void)setSelectTitleColor:(UIColor *)selectTitleColor{
    _selectTitleColor = selectTitleColor;
}
/*
 * 选中的是否动画效果
 */

-(void)setIsHaveAnimation:(BOOL)isHaveAnimation{
    
    _isHaveAnimation  = isHaveAnimation;
}

/*
 * 是否禁止手势滚动
 */
-(void)setIsCanScroll:(BOOL)isCanScroll{
    _isCanScroll = isCanScroll;
    
    self.leftSwipe.enabled = self.rightSwipe.enabled = isCanScroll;
}

/*
 * 是否显示上月，下月的按钮
 */

-(void)setIsShowLastAndNextBtn:(BOOL)isShowLastAndNextBtn{
    _isShowLastAndNextBtn  = isShowLastAndNextBtn;
    self.calendarHeader.isShowLeftAndRightBtn = isShowLastAndNextBtn;
}


/*
 * 是否显示上月，下月的的数据
 */
-(void)setIsShowLastAndNextDate:(BOOL)isShowLastAndNextDate{
    _isShowLastAndNextDate =  isShowLastAndNextDate;
}
/*
 * 今日的title颜色
 */

-(void)setTodayTitleColor:(UIColor *)todayTitleColor{
    _todayTitleColor = todayTitleColor;
}
@end
