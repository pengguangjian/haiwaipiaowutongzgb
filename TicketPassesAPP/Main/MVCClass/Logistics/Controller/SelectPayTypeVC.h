//
//  SelectPayTypeVC.h
//  TicketPassesAPP
//
//  Created by macbook on 2019/7/1.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import "BaseViewController.h"
#import "XSZRadioButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelectPayTypeVC : BaseViewController
@property (strong, nonatomic) IBOutlet UILabel *descLabel;
@property (strong, nonatomic) IBOutlet XSZRadioButton *alipayRadioBtn;
@property (strong, nonatomic) IBOutlet XSZRadioButton *wxRadioBtn;

//支付系统必要
@property (nonatomic,strong) NSString *order_id;
@property (nonatomic,assign) NSString *order_type;//1:购票 2：物流

@property (nonatomic,assign) BOOL isFromTicket;
@property (nonatomic,assign) BOOL isFromOrder;

- (IBAction)payBtnOnTouch:(id)sender;

@end

NS_ASSUME_NONNULL_END
