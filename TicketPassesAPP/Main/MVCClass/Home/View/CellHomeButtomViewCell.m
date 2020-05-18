//
//  CellHomeButtomViewCell.m
//  TicketPassesAPP
//
//  Created by xiaoshiheng on 2019/8/13.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "CellHomeButtomViewCell.h"

@implementation CellHomeButtomViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.bgImage.layer setMasksToBounds:YES];
    [self.bgImage.layer setCornerRadius:5.0f];
    self.namelabel.textColor = COL1;
    self.fubiaotilabel.textColor = COL2;
}

- (void)setModel:(CellHomeButtomModel *)model{
    
    _model = model;
    
    self.bgImage.contentMode = UIViewContentModeScaleToFill;
    [self.bgImage sd_setImageWithURL:[NSURL SDURLWithString:model.thumb] placeholderImage:kSetImage(@"ammie-ngo-690967-unsplash")];
    self.namelabel.text = model.title;
    self.fubiaotilabel.text = model.vice_title;
    
}


@end
