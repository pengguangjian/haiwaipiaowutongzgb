//
//  TicketListVC.m
//  TicketPassesAPP
//
//  Created by macbook on 2019/7/2.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import "TicketListVC.h"
#import "TicketListCell.h"
#import "TicketModel.h"
#import "BookNoticeView.h"
#import "TicketBookVC.h"
#import "XSZActivityRoleView.h"

@interface TicketListVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,XBCalendarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArray;
//时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

//选中
@property (nonatomic, strong) NSIndexPath *selectIndex;

@property (nonatomic, strong) NSString *time;

@property (nonatomic, strong) BookNoticeView *bookNoticeView;

@property (nonatomic, assign) NSInteger page;

@end

@implementation TicketListVC

//设置导航栏背景图片为一个空的image，这样就透明了
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.calendar.delegate = self;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.calendar.delegate = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //拼接
    NSString *titStr = [NSString stringWithFormat:@"%@-%@",self.startCityName,self.endCityiName];
    self.navigationItem.title = titStr;
    
    self.time = [NSString stringWithFormat:@"%ld-%ld-%ld",self.setout_time.year,self.setout_time.month,self.setout_time.day];
    self.timeLabel.text = [self gettime];

    [self upTableView];
    
    WEAK_SELF;
    self.bookNoticeView = [BookNoticeView sharedSingleton];
    [self.bookNoticeView setConfirmBookNoticeViewBloak:^(){
        
        [weakSelf goTicketBookVC];
        
    }];
    [self.tableView tableViewPullDown:^{

        [weakSelf loadFirstData];
    }];
    [self.tableView tableViewPullUp:^{

        [weakSelf loadMoreData];
    }];
    [self.tableView headerBeginRefreshing];
    
}

-(void)loadFirstData {
    
    self.page = 1;
    self.dataArray = [[NSMutableArray alloc] init];
    [self loadMoreData];
}

-(void)loadMoreData {
    
    WEAK_SELF;
    [AFHTTP requestHotcityOrigin_id:self.startCityid destination:self.endCityid setout_time:self.time page:self.page success:^(NSDictionary *dic){
        
        NSArray *citydatas = dic[@"citydatas"];
        if([citydatas isKindOfClass:[NSArray class]]){
            
//            [weakSelf.dataArray removeAllObjects];
            
            [weakSelf.tableView allEndRefreshing];
            
            if (citydatas.count<20) {
                [weakSelf.tableView endFooterRefreshingWithNoMoreData];
            }
            
            [weakSelf.dataArray addObjectsFromArray:citydatas];
        }
        [weakSelf.tableView reloadData];
        
        self.page++;
        
    } failure:^(NSError *error){
        [weakSelf.tableView headerEndRefreshing];
    }];
    
}

#pragma mark --- selectTimerEnd
- (void)selectTimerEnd:(LXCalendarDayModel *)model{
    self.setout_time = model;
    self.timeLabel.text = [self gettime];
    self.time = [NSString stringWithFormat:@"%ld-%ld-%ld",self.setout_time.year,self.setout_time.month,self.setout_time.day];
    [self.tableView headerBeginRefreshing];
}
- (NSString *)gettime{
    
    
    NSInteger  firstWeekday = self.setout_time.weekday;
    NSString *firstWeekdayStr; //周几
    if(firstWeekday == 0){
        //星期天
        firstWeekdayStr = NSBundleLocalizedString(@"周天");
    }else if (firstWeekday == 1){
        firstWeekdayStr = NSBundleLocalizedString(@"周一");
    }else if (firstWeekday == 2){
        firstWeekdayStr = NSBundleLocalizedString(@"周二");
    }else if (firstWeekday == 3){
        firstWeekdayStr = NSBundleLocalizedString(@"周三");
    }else if (firstWeekday == 4){
        firstWeekdayStr = NSBundleLocalizedString(@"周四");
    }else if (firstWeekday == 5){
        firstWeekdayStr = NSBundleLocalizedString(@"周五");
    }else if (firstWeekday == 6){
        firstWeekdayStr = NSBundleLocalizedString(@"周六");
    }
    
    //这月
    NSDate *monthData = [NSDate date];
    LXCalendarMonthModel *monthModel = [[LXCalendarMonthModel alloc]initWithDate:monthData];
    
    NSString *string;
    if(monthModel.year == self.setout_time.year){
        //年相等
        NSString *timedata = [NSBundle getYue:[NSString stringWithFormat:@"%i",self.setout_time.month] Ri:[NSString stringWithFormat:@"%i",self.setout_time.day]];
        
        string = [NSString stringWithFormat:@"%@ %@",timedata,firstWeekdayStr];
    
    }else{
        NSString *timedata = [NSBundle getNian:[NSString stringWithFormat:@"%i",self.setout_time.year] Yue:[NSString stringWithFormat:@"%i",self.setout_time.month] Ri:[NSString stringWithFormat:@"%i",self.setout_time.day]];
        
        string = [NSString stringWithFormat:@"%@ %@",timedata,firstWeekdayStr];
        
       
    }
    return string;
    
}
#pragma mark --- request ------


- (void)goTicketBookVC {
    
    [self.bookNoticeView hideMenu];
    
    TicketModel *model = [TicketModel mj_objectWithKeyValues:self.dataArray[self.selectIndex.row]];
    TicketBookVC *vc = [[TicketBookVC alloc]init];
    vc.start_id = model.station_begin;
    vc.end_id = model.station_end;
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark ----   IBAction ----

- (IBAction)showRIli:(id)sender {
    
    [self.calendar showMenu];
}
//前一天
- (IBAction)goquanyitian:(id)sender {
    
    [self.calendar selectCalendarUpper];
}
//后一天
- (IBAction)gohouyitian:(id)sender {
    
    [self.calendar selectCalendarLower];
}


#pragma mark ---- tableview ----

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CustomCellIdentifier = @"TicketListCell";
    TicketListCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    
    if (!cell)
    {
        UINib *nib = [UINib nibWithNibName:CustomCellIdentifier bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CustomCellIdentifier];
        cell = (TicketListCell *)[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    }
    
    cell.passengerNotesBtn.tag = indexPath.row;
    [cell.passengerNotesBtn addTarget:self action:@selector(passengerNotesBtnOnTouch:) forControlEvents:UIControlEventTouchUpInside ];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    TicketModel *model = [TicketModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
    cell.model = model;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    self.selectIndex = indexPath;
    
    [self.bookNoticeView showMenu];
    
}


#pragma mark -- DZNEmptyDataSetSource,DZNEmptyDataSetDelegate
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView  *)scrollView {
    return true;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView  *)scrollView
{
    if ([XBUtils networkEnable]) {
        return [UIImage imageNamed:@"img_blank"];;
    }else {
        return [UIImage imageNamed:@"img_nonetwork"];
    }
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    [self.tableView headerBeginRefreshing];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return 10;
}

- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)upTableView{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = UIColorFromHex(0xf6f6f6);
}


-(void)passengerNotesBtnOnTouch:(UIButton*)btn {
    
    TicketModel *model = [TicketModel mj_objectWithKeyValues:self.dataArray[btn.tag]];
    
    XSZActivityRoleView *activityDialogView = [XSZActivityRoleView sharedView:model];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:activityDialogView];
    
    [activityDialogView show];
    
}

@end
