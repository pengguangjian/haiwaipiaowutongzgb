//
//  SDCollectionTagsViewCell.m
//  SDTagsView
//
//  Created by slowdony on 2017/9/9.
//  Copyright © 2017年 slowdony. All rights reserved.
//

#import "SDCollectionTagsViewCell.h"
#import "SDHelper.h"
#import "TagsModel.h"
@implementation SDCollectionTagsViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
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

-(void)setValueWithModel:(TagsModel *)model{
    
    NSString *title = [NSString stringWithFormat:@"%@-%@",model.startModel.cityname,model.endModel.cityname];
    
    self.title.text = [NSString stringWithFormat:@"%@",title];
    
}

@end
