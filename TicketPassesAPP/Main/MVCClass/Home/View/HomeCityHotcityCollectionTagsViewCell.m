//
//  HomeCityHotcityCollectionTagsViewCell.m
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/30.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "HomeCityHotcityCollectionTagsViewCell.h"

@implementation HomeCityHotcityCollectionTagsViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    // Initialization code
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
     
        self.backgroundColor = [UIColor whiteColor];
        [self.layer setCornerRadius:16];
        [self.layer setMasksToBounds:YES];
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    
    UILabel *title = [[UILabel alloc] init];
    title.font = [UIFont systemFontOfSize:15];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = UIColorFromHex(0x6d6d6d);
    self.title = title;
    [self.contentView addSubview:title];
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.title.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

-(void)setValueWithModel:(CityModel *)model{

    self.title.text = [NSString stringWithFormat:@"%@",model.cityname];

}


@end
