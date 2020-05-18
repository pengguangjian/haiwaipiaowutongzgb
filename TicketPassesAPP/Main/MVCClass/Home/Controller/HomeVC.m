//
//  HomeVC.m
//  TicketPassesAPP
//
//  Created by macbook on 2019/6/27.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import "HomeVC.h"
#import "WebViewController.h"
#import "TicketListVC.h"
#import "HomeCityCListVC.h"
#import "CellHomeTopView.h"
#import "CellHomeButtomView.h"
#import "XBCalendar.h"
#import "TagsModel.h"
#import "CityModel.h"

@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,XBCalendarDelegate>
{}
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) CellHomeTopView * homeTopView;
///视图
@property (strong, nonatomic)  UIView *mView;
//白色背景
//@property (strong, nonatomic)  UIView *headView;
//黑色背景
@property (strong, nonatomic)  UIView *mTableBaseView;

//开始模型
@property (nonatomic, strong) CityModel *startModel;
//结束
@property (nonatomic, strong) CityModel *endModel;

//@property (nonatomic, strong) NSString *startCityid;
//
//@property (nonatomic, strong) NSString *endCityid;
//
//@property (nonatomic, strong) NSString *startCityName;
//
//@property (nonatomic, strong) NSString *endCityName;
//时间
@property (nonatomic, strong) LXCalendarDayModel *setout_time;

@property (nonatomic, strong) XBCalendar *calendar;

@property (nonatomic , strong) NSMutableArray *dataArray;


@end

@implementation HomeVC


- (void)dealloc {
    self.navigationController.delegate = nil;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.calendar.delegate = self;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.calendar.delegate = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    self.navigationItem.title = @"";
    [self.view addSubview:self.tableView];
    
    [self requestIndexarticle];

}

- (void)requestIndexarticle{
    WEAK_SELF;
    [AFHTTP requestIndexarticleSuccess:^(id responseObject) {
        
        [weakSelf.dataArray removeAllObjects];
        NSArray *newsdatas = responseObject[@"article_index"];
        if([newsdatas isKindOfClass:[newsdatas class]]){
            [weakSelf.dataArray addObjectsFromArray:newsdatas];
            [weakSelf collectionViewreloadData];
        }
        
    }];
}
- (void)collectionViewreloadData{
    [self.tableView reloadData];
}


#pragma mark --- selectTimerEnd
- (void)selectTimerEnd:(LXCalendarDayModel *)model{
    self.setout_time = model;
    [self uptime];
}
- (void)uptime{
//    NSLog(@"%ld年 - %ld月 - %ld日",self.setout_time.year,self.setout_time.month,self.setout_time.day);
    
    //这月
    NSDate *monthData = [NSDate date];
    LXCalendarMonthModel *monthModel = [[LXCalendarMonthModel alloc]initWithDate:monthData];
    
    NSString *string;
    if(monthModel.year == self.setout_time.year){
        //年相等
        string = [NSBundle getYue:[NSString stringWithFormat:@"%i",self.setout_time.month] Ri:[NSString stringWithFormat:@"%i",self.setout_time.day]];

        if(monthModel.month == self.setout_time.month &&
           monthModel.day == self.setout_time.day ){
           //月，日相等
            string = [string stringByAppendingString:[NSString stringWithFormat:@"  %@",NSBundleLocalizedString(@"今日")]];
        }
    }else{
        string = [NSBundle getNian:[NSString stringWithFormat:@"%i",self.setout_time.year] Yue:[NSString stringWithFormat:@"%i",self.setout_time.month] Ri:[NSString stringWithFormat:@"%i",self.setout_time.day]];
    }
    self.homeTopView.timerLb.text =  string;
    
}

#pragma mark ------  show vc---

- (void)muneButtonTaped:(UIButton *)button{
    
    [self hideMenu];
    if (button.tag == 1001) {
        if([NSBundle getLanguagekey] == LanguageZH){
            return;
        }
        [NSBundle setLanguage:LanguageZH];
    } else if (button.tag == 1002) {
        if([NSBundle getLanguagekey] == LanguageEN){
            return;
        }
        [NSBundle setLanguage:LanguageEN];
    } else if (button.tag == 1003) {
        if([NSBundle getLanguagekey] == LanguageVI){
            return;
        }
        [NSBundle setLanguage:LanguageVI];
    }
     [XBUtils SYSResetRootController];
}
- (void)openAnimation:(BOOL)open{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    if(open){
        self.homeTopView.yuyan.imageView.transform = CGAffineTransformMakeRotation(180 * (M_PI /180.0f));
        //        self.sanx_upImage.transform = CGAffineTransformMakeRotation(180 * (M_PI /180.0f));
    }else{
        self.homeTopView.yuyan.imageView.transform = CGAffineTransformIdentity;
        //        self.sanx_upImage.transform =CGAffineTransformIdentity;
    }
    [UIView commitAnimations];
}

///通知出现
- (void)showMenu{
    
    [self openAnimation:YES];
    
//    [[UIApplication sharedApplication].keyWindow addSubview:self.headView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.mTableBaseView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.mView];
//    self.headView.alpha = 0;
    self.mTableBaseView.alpha = 0;
    self.mView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
//        self.headView.alpha = 1;
        self.mView.alpha = 1;
        self.mTableBaseView.alpha = 1;
    }];
    
}
///通知隐藏

- (void)hideMenu {
    
    [self openAnimation:NO];
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.mView. alpha = 0;
                         self.mTableBaseView.alpha = 0;
//                         self.headView.alpha = 0;
                     }
                     completion:^(BOOL finished){
//                         [self.headView removeFromSuperview];
                         [self.mView removeFromSuperview];
                         [self.mTableBaseView removeFromSuperview];
                         
                     }];
    
}

-(void)bgTappedAction:(UITapGestureRecognizer *)tap
{
    [self hideMenu];
    
}

#pragma mark ------  go vc---

- (void)goWebViewVc:(CellHomeButtomModel *)model{
    WebViewController *vc = [[WebViewController alloc]init];
    vc.webType = 6;
    vc.newsTiele = model.title;
    vc.newsContent = model.content;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)goTicketVc:(TagsModel *)model{
    
    if(!_setout_time){
        [MBManager showBriefAlert:NSBundleLocalizedString(@"请选择出发日期")];
        return;
    }
    self.startModel = model.startModel;
    self.endModel = model.endModel;
    [self.homeTopView.startButton setTitle:model.startModel.cityname forState:UIControlStateNormal];
    [self.homeTopView.endButton setTitle:model.endModel.cityname forState:UIControlStateNormal];
    
    TicketListVC *ticketVC = [[TicketListVC alloc] init];
    ticketVC.startCityid = model.startModel.ID;
    ticketVC.endCityid = model.endModel.ID;
    ticketVC.startCityName = model.startModel.cityname;
    ticketVC.endCityiName = model.endModel.cityname;
    ticketVC.setout_time = self.setout_time;
    ticketVC.calendar = self.calendar;
    [self.navigationController pushViewController:ticketVC animated:YES];
    
}
- (void)goTicket{
    
    if(!kStringIsEmpty(self.startModel.ID)){
        [MBManager showBriefAlert:NSBundleLocalizedString(@"请选择始发地")];
        return;
    }
    if(!kStringIsEmpty(self.endModel.ID)){
        [MBManager showBriefAlert:NSBundleLocalizedString(@"请选择目的地")];
        return;
    }
    if([self.startModel.ID isEqualToString:self.endModel.ID]){
        [MBManager showBriefAlert:NSBundleLocalizedString(@"始发地于目的地相同")];
        return;
    }
    if(!_setout_time){
        [MBManager showBriefAlert:NSBundleLocalizedString(@"请选择出发日期")];
        return;
    }
    
    
    NSArray *arrarSearch =  [[NSUserDefaults standardUserDefaults] valueForKey:SEARCHHISTORY];
    NSMutableArray *dataArr = [[NSMutableArray alloc]initWithArray:arrarSearch];
    
    NSString *searchID = [NSString stringWithFormat:@"%@+%@",self.startModel.ID,self.endModel.ID];
    BOOL stop = NO;
    for (NSDictionary *dicSearch in dataArr) {
        NSString *searchid = dicSearch[@"searchID"];
        if([searchid isEqualToString:searchID]){
            stop = YES;
            break;
        }
    }
    if(!stop){
        NSMutableDictionary *searchDic = [[NSMutableDictionary alloc]init];
        [searchDic setValue:[self.startModel mj_keyValues] forKey:@"startModel"];
        [searchDic setValue:[self.endModel mj_keyValues] forKey:@"endModel"];
        [searchDic setValue:searchID forKey:@"searchID"];
        if(arrarSearch.count > 4){
            
            [dataArr insertObject:searchDic atIndex:0];
            [dataArr removeObjectAtIndex:5];
            
        }else{
            [dataArr insertObject:searchDic atIndex:0];
        }
        [[NSUserDefaults standardUserDefaults] setObject:dataArr forKey:SEARCHHISTORY];
        [[NSNotificationCenter defaultCenter] postNotificationName:SEARCHHISTORYNotification object:nil];
    }
    
    TicketListVC *ticketVC = [[TicketListVC alloc] init];
    ticketVC.startCityid = self.startModel.ID;
    ticketVC.endCityid = self.endModel.ID;
    ticketVC.startCityName = self.startModel.cityname;
    ticketVC.endCityiName = self.endModel.cityname;
    ticketVC.setout_time = self.setout_time;
    ticketVC.calendar = self.calendar;
    [self.navigationController pushViewController:ticketVC animated:YES];
}
- (void)goStartCity{
    
    HomeCityCListVC *vc = [[HomeCityCListVC alloc] init];
    WEAK_SELF;
    [vc setStartCitySelectBloak:^(CityModel *model){
        
        weakSelf.startModel = model;
        [weakSelf.homeTopView.startButton setTitle:model.cityname forState:UIControlStateNormal];
    }];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)goEndCity{
    HomeCityCListVC *vc = [[HomeCityCListVC alloc] init];
    WEAK_SELF;
    [vc setEndCitySelectBloak:^(CityModel *model){
        
        weakSelf.endModel = model;
        [weakSelf.homeTopView.endButton setTitle:model.cityname forState:UIControlStateNormal];

    }];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)goSwitch{
    
    [UIView animateWithDuration:0.3 animations:^(){
        
        CityModel *tempstart = self.startModel;
        CityModel *tempend = self.endModel;
        
        self.startModel = tempend;
        self.endModel = tempstart;
        
        [self.homeTopView.startButton setTitle:self.startModel.cityname forState:UIControlStateNormal];
        [self.homeTopView.endButton setTitle:self.endModel.cityname forState:UIControlStateNormal];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.dataArray.count>0){
        return 2;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        static NSString *identifier = @"CellHomeTopView";
        CellHomeTopView *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.startButton setTitle:self.startModel.cityname forState:UIControlStateNormal];
        [cell.endButton setTitle:self.endModel.cityname forState:UIControlStateNormal];
        cell.timerLb.text = NSBundleLocalizedString(@"请选择出发日期");
        [cell.yuyan setTitleIconInRight:[NSBundle getLanguage]];
        [cell getSearch];
        
        self.homeTopView = cell;
        
        
        WEAK_SELF;
        [cell setCheckBloak:^(){
            [weakSelf goTicket];
        }];
        [cell setSelectTimerBloak:^(){
            [weakSelf.calendar showMenu];
        }];
        [cell setStartCitySelectBloak:^(){
            [weakSelf goStartCity];
        }];
        [cell setEndCitySelectBloak:^(){
            [weakSelf goEndCity];
        }];
        [cell setAddroseSwitchBloak:^(){
            [weakSelf goSwitch];
        }];
        [cell setAddoreClickBloak:^(){
            [weakSelf showMenu];
        }];
        [cell setSelectTagsModelBloak:^(TagsModel *model){
            [weakSelf goTicketVc:model];
        }];
        return cell;
    }else{
        
        static NSString *identifier = @"CellHomeButtomView";
        CellHomeButtomView *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell .itemArr = self.dataArray;
        WEAK_SELF;
        [cell setSelectTagsModelBloak:^(CellHomeButtomModel * _Nonnull model) {
            [weakSelf goWebViewVc:model];
        }];
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        
//        CGFloat  dd =(450.0/620.0)*(SCREENH_HEIGHT-SYS_BottomHeight);
        
        return 590;
    }else{
//
//        CGFloat  dd = SCREENH_HEIGHT-SYS_BottomHeight - ((450.0/620.0)*(SCREENH_HEIGHT-SYS_BottomHeight));
//
        CGFloat ww =  (SCREEN_WIDTH - 45) /2;
        CGFloat hh = hh = ww * 380.0f/330.0f+40;
        NSInteger dd = ceil(self.dataArray.count / 2.0);
        return dd * hh + 20 + 20*dd;
    }
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

#pragma mark -------

- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (CityModel *)endModel{
    if(!_endModel){
        _endModel = [CityModel new];
        _endModel.cityname_y =NSBundleLocalizedString(@"请选择目的地");
        _endModel.cityname_e =NSBundleLocalizedString(@"请选择目的地");
        _endModel.cityname_c = NSBundleLocalizedString(@"请选择目的地");
    }
    return _endModel;
}
- (CityModel *)startModel{
    if(!_startModel){
        _startModel = [CityModel new];
        _startModel.cityname_y = NSBundleLocalizedString(@"请选择始发地");
        _startModel.cityname_e = NSBundleLocalizedString(@"请选择始发地");
        _startModel.cityname_c = NSBundleLocalizedString(@"请选择始发地");
    }
    return _startModel;
}



- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT- SYS_BottomHeight)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = RGB(248, 248, 248);;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        
        [_tableView registerClass:[CellHomeButtomView class] forCellReuseIdentifier:@"CellHomeButtomView"];
        [_tableView registerNib:[UINib nibWithNibName:@"CellHomeTopView" bundle:nil] forCellReuseIdentifier:@"CellHomeTopView"];
    }
    return _tableView;
}

- (XBCalendar *)calendar{
    if (!_calendar) {
        _calendar = [[XBCalendar alloc] init];
        _calendar.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT);
        
    }
    return _calendar;
}

- (UIView *)mView{
    if(!_mView){
        _mView = [[UIView alloc]initWithFrame:CGRectMake(0, SYS_TopHeight, 100, 121)];
        _mView.backgroundColor = [UIColor whiteColor];
        
        UIButton *muneButton1 = [[UIButton alloc]init];
        muneButton1.tag = 1001;
        muneButton1.frame = CGRectMake(0, 0, 100, 40);
        muneButton1.titleLabel.font = [UIFont systemFontOfSize:15];
        [muneButton1 setTitleColor:UIColorFromHex(0x808080) forState:UIControlStateNormal];
        [muneButton1 setTitle:@"中文" forState:UIControlStateNormal];
        [muneButton1 addTarget: self action: @selector(muneButtonTaped:) forControlEvents: UIControlEventTouchUpInside];
        [_mView addSubview:muneButton1];
        
        UIView *liveView = [[UIView alloc]initWithFrame:CGRectMake(15, 40, 100 - 30, 1)];
        liveView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_mView addSubview:liveView];
        
        UIButton *muneButton2 = [[UIButton alloc]init];
        muneButton2.tag = 1002;
        muneButton2.frame = CGRectMake(0, 41, 100, 40);
        muneButton2.titleLabel.font = [UIFont systemFontOfSize:15];
        [muneButton2 setTitleColor:UIColorFromHex(0x808080) forState:UIControlStateNormal];
        [muneButton2 setTitle:@"English" forState:UIControlStateNormal];
        [muneButton2 addTarget: self action: @selector(muneButtonTaped:) forControlEvents: UIControlEventTouchUpInside];
        [_mView addSubview:muneButton2];
        
        UIView *liveView1 = [[UIView alloc]initWithFrame:CGRectMake(15, 81, 100 - 30, 1)];
        liveView1.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_mView addSubview:liveView1];
        
        UIButton *muneButton3 = [[UIButton alloc]init];
        muneButton3.tag = 1003;
        muneButton3.frame = CGRectMake(0, 81, 100, 40);
        muneButton3.titleLabel.font = [UIFont systemFontOfSize:15];
        [muneButton3 setTitleColor:UIColorFromHex(0x808080) forState:UIControlStateNormal];
        [muneButton3 setTitle:@"Tiếng Việt" forState:UIControlStateNormal];
        [muneButton3 addTarget: self action: @selector(muneButtonTaped:) forControlEvents: UIControlEventTouchUpInside];
        [_mView addSubview:muneButton3];
        
    }
    return _mView;
    
}
//- (UIView *)headView{
//    if(!_headView){
//        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENH_HEIGHT, SYS_TopHeight)];
//        _headView.backgroundColor = [UIColor clearColor];
//        UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTappedAction:)];
//        [_headView addGestureRecognizer:bgTap];
//    }
//    return _headView;
//}
- (UIView *)mTableBaseView{
    if(!_mTableBaseView){
        _mTableBaseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
        _mTableBaseView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTappedAction:)];
        [_mTableBaseView addGestureRecognizer:bgTap];
    }
    return _mTableBaseView;
}
@end
