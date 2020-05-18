//
//  ServiceEvaluateCell.m
//  XiaoShunZiAPP
//
//  Created by Mac on 2018/6/1.
//  Copyright © 2018年 XiaoShunZi. All rights reserved.
//

#import "ServiceEvaluateCell.h"

@implementation ServiceEvaluateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.headImageView.layer setMasksToBounds:YES];
    [self.headImageView.layer setCornerRadius:self.headImageView.width/2.0];
    
    self.contentLabel.numberOfLines = 0;
    
    _starRate = [[TYStarRateView alloc] initWithFrame:CGRectMake(0, 0, 90, 15) numberOfStars:5];
    _starRate.scorePercent = 0/5.0;
    _starRate.allowIncompleteStar = NO;
    _starRate.hasAnimation = YES;
    _starRate.isSetting = NO;
    _starRate.delegate = self;
    [_starRateContainerView addSubview:_starRate];
    
    self.technicianNameLabel.textColor = COL2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
