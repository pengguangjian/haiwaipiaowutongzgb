//
//  TicketListCell.h
//  TicketPassesAPP
//
//  Created by caochun on 2019/11/4.
//  Copyright © 2019 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketModel.h"
#import "TYStarRateView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TicketListCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *passengerNotesLabel;
@property (strong, nonatomic) IBOutlet UIImageView *LineImageView;
@property (strong, nonatomic) IBOutlet UIButton *passengerNotesBtn;
@property (strong, nonatomic) IBOutlet UILabel *startStationLable;
@property (strong, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (strong, nonatomic) IBOutlet UILabel *endStationLabel;
@property (strong, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *remainingTicketLabel;
@property (strong, nonatomic) IBOutlet UILabel *boardingPointLabel;
@property (strong, nonatomic) IBOutlet UILabel *busTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *busCompanyLabel;
@property (strong, nonatomic) IBOutlet UILabel *starLevelLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UIView *starContainerView;
@property (strong, nonatomic) IBOutlet UILabel *oldPriceLabel;

@property (strong, nonatomic) TYStarRateView *starRate;



@property (nonatomic,strong) TicketModel *model;
@end

NS_ASSUME_NONNULL_END
