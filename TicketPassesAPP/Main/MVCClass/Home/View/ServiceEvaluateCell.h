//
//  ServiceEvaluateCell.h
//  XiaoShunZiAPP
//
//  Created by Mac on 2018/6/1.
//  Copyright © 2018年 XiaoShunZi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TYStarRateView.h"

@interface ServiceEvaluateCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UIView *starRateContainerView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *technicianLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) TYStarRateView *starRate;
@property (weak, nonatomic) IBOutlet UIView *tagContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagContainerViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *technicianNameLabel;
@end
