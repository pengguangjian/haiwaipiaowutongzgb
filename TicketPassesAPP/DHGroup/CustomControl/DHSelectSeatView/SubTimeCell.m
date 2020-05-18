//
//  SubTimeCell.h
//  XiaoShunZiAPP
//
//  Created by Mac on 2018/6/8.
//  Copyright © 2018年 XiaoShunZi. All rights reserved.
//


#import "SubTimeCell.h"

@interface SubTimeCell ()
{
    CAShapeLayer *layer;
}
@end

@implementation SubTimeCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        self.timeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self.timeBtn setTitleColor:COL1 forState:UIControlStateNormal];
        [self.timeBtn setBackgroundColor:[UIColor whiteColor]];
        [self.timeBtn.layer setMasksToBounds:YES];
        [self.timeBtn.titleLabel setFont:[UIFont systemFontOfSize:13.f]];
//        [self.timeBtn.layer setBorderColor:COL3.CGColor];
//        [self.timeBtn.layer setBorderWidth:1.0];
        [self.timeBtn.layer setCornerRadius:3.0f];
        [self.timeBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:self.timeBtn];
        
        [self.timeBtn.titleLabel setNumberOfLines:0];
        
        
        layer = [[CAShapeLayer alloc] init];
        layer.frame = CGRectMake(0, 0 , self.timeBtn.frame.size.width, self.timeBtn.frame.size.height);
        layer.backgroundColor   = [UIColor clearColor].CGColor;

        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:layer.frame cornerRadius:3.0f];
        layer.path             = path.CGPath;
        layer.lineWidth         = 1.0f;
        layer.lineDashPattern    = @[@4, @4];
        layer.fillColor          = [UIColor clearColor].CGColor;
        layer.strokeColor       = [UIColor whiteColor].CGColor;

        [self.timeBtn.layer addSublayer:layer];
        
    }
    return self;
}

- (void)setSeatObj:(SeatObj*)so {
    
//    [self.timeBtn setTitle:[NSString stringWithFormat:@"%@ %@人座\n¥%@",so.seat_code,@"5",so.price] forState:UIControlStateNormal];
    [self.timeBtn setTitle:[NSString stringWithFormat:@"%@\n¥%@",so.seat_code,so.price] forState:UIControlStateNormal];
    
    if ([so.status intValue] == 0) {
        if ([so.is_available boolValue]) {
            so.status = [NSNumber numberWithInt:1];
        } else {
            so.status = [NSNumber numberWithInt:3];
        }
    }
    
    //1=可预订，2=休息，3=已预约,4=过期 5=选中
    switch ([so.status intValue]) {
        case 1:
        {
            layer.strokeColor = DEFAULTCOLOR1.CGColor;
//            [self.timeBtn.layer setBorderColor:DEFAULTCOLOR2.CGColor];
            [self.timeBtn setBackgroundColor:[UIColor whiteColor]];
            [self.timeBtn setTitleColor:DEFAULTCOLOR1 forState:UIControlStateNormal];
            self.timeBtn.enabled = YES;
            break;
        }
        case 2:
        {
            layer.strokeColor = [UIColor clearColor].CGColor;
            [self.timeBtn.layer setBorderColor:SEPARATORCOLOR.CGColor];
            [self.timeBtn setBackgroundColor:SEPARATORCOLOR];
            [self.timeBtn setTitleColor:COL3 forState:UIControlStateNormal];
            self.timeBtn.enabled = NO;
            break;
        }
        case 3:
        {
            layer.strokeColor = [UIColor clearColor].CGColor;
            [self.timeBtn.layer setBorderColor:SEPARATORCOLOR.CGColor];
            [self.timeBtn setBackgroundColor:SEPARATORCOLOR];
            [self.timeBtn setTitleColor:COL3 forState:UIControlStateNormal];
            self.timeBtn.enabled = NO;
//            [self.timeBtn setTitle:[NSString stringWithFormat:@"%@\n约满",so.] forState:UIControlStateNormal];
            break;
        }
        case 4:
        {
            layer.strokeColor = [UIColor clearColor].CGColor;
            [self.timeBtn.layer setBorderColor:SEPARATORCOLOR.CGColor];
            [self.timeBtn setBackgroundColor:SEPARATORCOLOR];
            [self.timeBtn setTitleColor:COL3 forState:UIControlStateNormal];
            self.timeBtn.enabled = NO;
            break;
        }
        case 5:
        {
            layer.strokeColor = [UIColor clearColor].CGColor;
            [self.timeBtn.layer setBorderColor:DEFAULTCOLOR1.CGColor];
            [self.timeBtn setBackgroundColor:DEFAULTCOLOR1];
            [self.timeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.timeBtn.enabled = YES;
            break;
        }
        default:
            break;
    }
    
    
}

@end
