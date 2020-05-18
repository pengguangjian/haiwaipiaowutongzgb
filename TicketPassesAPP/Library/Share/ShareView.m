//
//  ShareView.m
//  TicketPassesAPP
//
//  Created by xiaoshiheng on 2019/8/21.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "ShareView.h"
#define ShareViewH 80

@implementation ShareView

+ (ShareView *)sharedSingleton {
    
    ShareView *view =[[NSBundle mainBundle] loadNibNamed:@"ShareView" owner:nil options:nil].firstObject;
    
    return view;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.frame = CGRectMake(0, 0 , SCREEN_WIDTH, SCREENH_HEIGHT);
    [self.but1 setTitleIconInTop:@"faceBook"];
//    [self.but2 setTitleIconInTop:@"faceBook"];
    [self.but3 setTitleIconInTop:@"zalo"];
    self.backgroundColor = [UIColor clearColor];
    self.mTableBaseView.backgroundColor = [UIColor blackColor];
    UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTappedAction:)];
    [self.mTableBaseView addGestureRecognizer:bgTap];
    
}


///通知出现
- (void)showMenu{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];

    self.mTableBaseView.alpha = 0;
    self.mView.alpha = 1;
    self.mView .frame =  CGRectMake(0, SCREENH_HEIGHT, SCREEN_WIDTH, ShareViewH + SYS_TabBarFloatHeight);
    [UIView animateWithDuration:0.3 animations:^{
        
        self.mView .frame =  CGRectMake(0, SCREENH_HEIGHT -ShareViewH - SYS_TabBarFloatHeight, SCREEN_WIDTH, ShareViewH + SYS_TabBarFloatHeight);
        self.mView.alpha = 1;
        self.mTableBaseView.alpha = 0.4;
    }];
    
}
///通知隐藏

- (void)hideMenu{
    
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.mView .frame =  CGRectMake(0, SCREENH_HEIGHT, SCREEN_WIDTH, ShareViewH + SYS_TabBarFloatHeight);
                         self.mView. alpha = 0;
                         self.mTableBaseView.alpha = 0;
                         
                         
                     }
                     completion:^(BOOL finished){
                         
                         [self removeFromSuperview];
                         
                         
                     }];
    
}

-(void)bgTappedAction:(UITapGestureRecognizer *)tap
{
    [self hideMenu];
    
}
- (void)muneButtonTaped:(UIButton *)button{
    [self hideMenu];
}
- (IBAction)clickbut:(UIButton *)sender {
    
    [self hideMenu];
    
    if(self.selectSuccessBlock){
        self.selectSuccessBlock(sender);
    }

}

@end
