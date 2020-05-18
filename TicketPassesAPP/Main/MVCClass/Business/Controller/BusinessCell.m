//
//  BusinessCell.m
//  TicketPassesAPP
//
//  Created by xiaoshiheng on 2019/8/12.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "BusinessCell.h"

@implementation BusinessCell

- (void)awakeFromNib {
    [super awakeFromNib];

    // Initialization code
    [self.bgview.layer setMasksToBounds:YES];
    [self.bgview.layer setCornerRadius:5.0];
    
    [self.bgImage.layer setMasksToBounds:YES];
    [self.bgImage.layer setCornerRadius:5.0];
    
    
}

- (void)setModel:(BusinessModel *)model{
    
    _model = model;
    
    self.bgImage.contentMode = UIViewContentModeScaleToFill;
    [self.bgImage sd_setImageWithURL:[NSURL SDURLWithString:model.thumb] placeholderImage:kSetImage(@"12091039")];
    self.namelabel.text = model.title;
    self.fubiaotilabel.text = model.vice_title;

    NSLog(@"model.vice_title:%@",model.vice_title);
    
    
    
}

@end
