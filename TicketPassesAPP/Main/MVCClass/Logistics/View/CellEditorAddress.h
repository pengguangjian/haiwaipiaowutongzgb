//
//  CellEditorAddress.h
//  TicketPassesAPP
//
//  Created by macbook on 2019/6/28.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CellEditorAddress : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *bianjibut;
@property (weak, nonatomic) IBOutlet UIButton *shanchubut;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *iphoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;


@property (nonatomic, copy) void (^editorClickBlock)(id model);

@property (nonatomic, copy) void (^removeClickBlock)(id model ,CellEditorAddress *cell);

@property (nonatomic,strong) id model;





@end

NS_ASSUME_NONNULL_END
