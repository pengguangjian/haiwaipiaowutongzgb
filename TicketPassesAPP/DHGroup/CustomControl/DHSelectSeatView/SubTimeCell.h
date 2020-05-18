//
//  SubTimeCell.h
//  XiaoShunZiAPP
//
//  Created by Mac on 2018/6/8.
//  Copyright © 2018年 XiaoShunZi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeatObj.h"

@interface SubTimeCell : UICollectionViewCell

@property (nonatomic, strong) UIButton *timeBtn;

- (void)setSeatObj:(SeatObj*)so;

@end
