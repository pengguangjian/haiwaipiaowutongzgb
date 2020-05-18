//
//  CellHomeTopView.h
//  TicketPassesAPP
//
//  Created by macbook on 2019/6/27.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDHeader.h"
#import "TagsModel.h"
#import "HomeADModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CellHomeTopView : UITableViewCell

@property (weak, nonatomic) IBOutlet SDCycleScrollView *sdView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *endButton;

@property (weak, nonatomic) IBOutlet UIView *boxView;
@property (weak, nonatomic) IBOutlet UILabel *timerLb;

@property (weak, nonatomic) IBOutlet UIView *searchView;

@property (nonatomic,strong) SDTagsView *tagsView;

@property (nonatomic,strong) UIButton * yuyan;


- (void)getSearch;

@property (nonatomic, copy) void (^addoreClickBloak)(void);

@property (nonatomic, copy) void (^startCitySelectBloak)(void);

@property (nonatomic, copy) void (^endCitySelectBloak)(void);

@property (nonatomic, copy) void (^addroseSwitchBloak)(void);

@property (nonatomic, copy) void (^checkBloak)(void);

@property (nonatomic, copy) void (^selectTimerBloak)(void);

@property (nonatomic, copy) void (^selectTagsModelBloak)(TagsModel *model);




@end

NS_ASSUME_NONNULL_END
