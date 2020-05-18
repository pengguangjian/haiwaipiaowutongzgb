//
//  CellHomeTopView.m
//  TicketPassesAPP
//
//  Created by macbook on 2019/6/27.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import "CellHomeTopView.h"
//#import "SGTagsView.h"

@interface CellHomeTopView ()

@property (nonatomic,strong) NSMutableArray *dataArray;

@end


@implementation CellHomeTopView

- (void)awakeFromNib {
    [super awakeFromNib];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSearch) name:SEARCHHISTORYNotification object:nil];
    
    self.boxView.layer.cornerRadius = 5;
    self.boxView.layer.shadowColor = UIColorFromHex(0x999999).CGColor;
    self.boxView.layer.shadowOffset = CGSizeMake(0, 0);
    self.boxView.layer.shadowOpacity = 0.9;
    self.boxView.layer.shadowRadius = 5;

    UIButton *yuyan = [[UIButton alloc]init];
    yuyan.hidden = YES;
    yuyan.titleLabel.font = [UIFont systemFontOfSize:15];
    [yuyan setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [yuyan addTarget: self action: @selector(muneButtonTaped:) forControlEvents: UIControlEventTouchUpInside];
    [yuyan setImage:[UIImage imageNamed:@"sanx_up"] forState:UIControlStateNormal];
    self.yuyan = yuyan;
    [self.contentView addSubview:self.yuyan];
    [self.yuyan mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.top.mas_equalTo(SYS_StatusBarHeight);
        maker.left.equalTo(self.contentView).offset(15);
        maker.width.mas_equalTo(60);
        maker.height.mas_equalTo(SYS_NavBarHeight);
    }];
    

    SDTagsView *sdTagsView =[[SDTagsView alloc]init];
    sdTagsView.frame =CGRectMake(0,0,0,0);
    WEAK_SELF;
    [sdTagsView setSelectTagsBloak:^(TagsModel *model){
        if(weakSelf.selectTagsModelBloak){
            weakSelf.selectTagsModelBloak(model);
        }
    }];
    self.tagsView = sdTagsView;
    [self.searchView addSubview:self.tagsView];
    
    self.sdView.pageControlStyle =  SDCycleScrollViewPageContolStyleNone;
//    self.sdView.placeholderImage = [UIImage imageNamed:@"ammie-ngo-690967-unsplash"];
//    self.sdView.localizationImageNamesGroup =@[[UIImage imageNamed:@"ammie-ngo-690967-unsplash"]];
    [self requestIndexbanner];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.tagsView.frame = CGRectMake(0, 0, CGRectGetWidth(self.searchView.frame), 60);
}

-(void)requestIndexbanner{
    WEAK_SELF;
    [AFHTTP requestIndexbannerSuccess:^(NSDictionary *dic) {
        
        NSArray *citydatas = dic[@"imgdatas"];
        if([citydatas isKindOfClass:[NSArray class]]){
            
            [weakSelf.dataArray removeAllObjects];
            [weakSelf.dataArray addObjectsFromArray:citydatas];
        }
        [weakSelf sdViewreloadData];
        
    }];
}
- (void)sdViewreloadData{
    
    NSMutableArray *urlarray = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in self.dataArray) {
        
        HomeADModel *mdoel = [HomeADModel mj_objectWithKeyValues:dic];
        [urlarray addObject:[NSURL SDURLWithString:mdoel.ab_img_url]];
        
    }
    if(urlarray.count > 0){
        self.sdView.imageURLStringsGroup = urlarray;
    }

}
-(NSMutableArray *)getDataArr{
   
    NSArray *arrarSearch =  [[NSUserDefaults standardUserDefaults] valueForKey:SEARCHHISTORY];
    NSArray *dataArr = arrarSearch ;// @[@{@"title":@"hahahhaha"}];
        NSMutableArray *tempArr =[NSMutableArray array];
        for (NSDictionary *dict in dataArr){
            TagsModel *model = [TagsModel mj_objectWithKeyValues:dict];
            [tempArr addObject:model];
        }
    
    
    return tempArr;
}
- (IBAction)clickClear:(id)sender {
    //清楚历史
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:SEARCHHISTORY];
    self.tagsView.tagsArr = [self getDataArr];
    
}

- (void)getSearch{

    self.tagsView.tagsArr = [self getDataArr];
}

- (void)muneButtonTaped:(UIButton *)button{
    if (self.addoreClickBloak) {
        self.addoreClickBloak();
    }
}

- (IBAction)startClick:(id)sender {
    if (self.startCitySelectBloak) {
        self.startCitySelectBloak();
    }
}
- (IBAction)endChick:(id)sender {
    if (self.endCitySelectBloak) {
        self.endCitySelectBloak();
    }
}
- (IBAction)switchChick:(id)sender {
    if (self.addroseSwitchBloak) {
        self.addroseSwitchBloak();
    }
}
- (IBAction)checkChlick:(id)sender {
    if (self.checkBloak) {
        self.checkBloak();
    }
}
- (IBAction)calendarChlick:(id)sender {
    if (self.selectTimerBloak) {
        self.selectTimerBloak();
    }
}

- (NSMutableArray *)dataArray{
    if(!_dataArray ){
        _dataArray  =  [[NSMutableArray  alloc]init];
    }
    return _dataArray ;
}
@end
