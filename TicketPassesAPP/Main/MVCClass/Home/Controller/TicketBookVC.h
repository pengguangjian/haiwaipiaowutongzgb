//
//  TicketBookVC.h
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/30.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "BaseViewController.h"
#import "TicketModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TicketBookVC : BaseViewController
@property (strong, nonatomic) IBOutlet UITextField *getOffTextField;
@property (strong, nonatomic) IBOutlet UILabel *getOffDescLabel;
@property (strong, nonatomic) IBOutlet UIView *getOffInputView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *getOffInputViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *getOffInputViewAlignTop;

@property (strong, nonatomic) IBOutlet UITextField *getOnTextField;
@property (strong, nonatomic) IBOutlet UILabel *getOnDescLabel;
@property (strong, nonatomic) IBOutlet UIView *getOnInputView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *getOnInputViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *getOnInputViewAlignTop;

@property (nonatomic, strong) TicketModel *model;

@property (nonatomic, copy) NSString *start_id;

@property (nonatomic, copy) NSString *end_id;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *phoneAndEmail;
@property (strong, nonatomic) IBOutlet UIView *contactView;
@property (strong, nonatomic) IBOutlet UILabel *seatLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *phoneAndEmailViewHeight;
@property (strong, nonatomic) IBOutlet UILabel *getOnLabel;
@property (strong, nonatomic) IBOutlet UILabel *getOffLabel;

@end

NS_ASSUME_NONNULL_END
