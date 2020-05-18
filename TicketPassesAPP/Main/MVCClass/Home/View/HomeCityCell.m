//
//  HomeCityCell.m
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/21.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "HomeCityCell.h"

@implementation HomeCityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UIView *liview = [[UIView alloc]init];
    liview.backgroundColor =  UIColorFromHex(0xf6f6f6);
    [self.contentView addSubview:liview];
    
    [liview mas_makeConstraints:^(MASConstraintMaker *maker){
        
        maker.bottom.equalTo(self.contentView);
        maker.left.equalTo(self.contentView).offset(15);
        maker.right.equalTo(self.contentView);
        maker.height.mas_equalTo(1);
        
    }];
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
