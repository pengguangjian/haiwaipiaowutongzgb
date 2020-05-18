//
//  DHPaySuccessView.m
//  NAM BAC THONG
//
//  Created by caochun on 2019/10/16.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "DHPaySuccessView.h"

@interface DHPaySuccessView ()
{
    UIView *bgView;
    float bgViewHeight;
    UIButton *ensureBtn;
    
    int closeType;//1关闭 2查看订单
    
}
@end

@implementation DHPaySuccessView

+ (instancetype)sharedView {
    
    static dispatch_once_t once;
    static DHPaySuccessView *paySuccessView;
    dispatch_once(&once, ^ {
        paySuccessView = [[self alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, DEVICE_Height)];
        
        [paySuccessView setBackgroundColor:RGBA(0, 0, 0, 0.5)];
        
        
    });
    
    [paySuccessView initView];
    
    return paySuccessView;
    
}

- (void)initView {
    
    for (UIView *v in self.subviews) {
        [v removeFromSuperview];
    }
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    //    [self addGestureRecognizer:tapGesture];
    
    bgViewHeight = 320;
    
    bgView = [[UIView alloc] init];
    [bgView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).with.offset(DEVICE_Height);
        make.size.mas_equalTo(CGSizeMake(DEVICE_Width*0.9, bgViewHeight));
    }];
    
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *closeImage = [UIImage imageNamed:@"pop_close"];
    //UIImageRenderingModeAlwaysOriginal这个枚举值是声明这张图片要按照原来的样子显示，不需要渲染成其他颜色
    closeImage = [closeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [closeBtn setImage:closeImage forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnOnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:closeBtn];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).with.offset(0);
        make.right.equalTo(bgView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(32, 32));
    }];
    
     UIView *contentView = [[UIView alloc] init];
    [contentView setBackgroundColor:[UIColor whiteColor]];
    [contentView.layer setCornerRadius:20.0f];
    [bgView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(bgView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(DEVICE_Width*0.9-32-8, 250));
    }];
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"ic_paysuccess"];
    [bgView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).with.offset(32);
        make.centerX.equalTo(contentView);
        make.size.mas_equalTo(CGSizeMake(103.5, 53));
    }];
    
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.textColor = COL1;
    descLabel.font = [UIFont systemFontOfSize:20];
    descLabel.text = @"订单支付成功";
    descLabel.textAlignment = NSTextAlignmentCenter;
    descLabel.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:descLabel];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.equalTo(imageView.mas_bottom).with.offset(30);
        make.size.mas_equalTo(CGSizeMake(250, 20));
    }];
    
    
    UIButton *checkDetailBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [checkDetailBtn setTitle:@"查看订单" forState:UIControlStateNormal];
    [checkDetailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [checkDetailBtn setBackgroundColor:[UIColor whiteColor]];
    [checkDetailBtn.layer setMasksToBounds:YES];
    [checkDetailBtn.layer setCornerRadius:22.50f];
    [checkDetailBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [checkDetailBtn gradientButtonWithSize:CGSizeMake(150, 45) colorArray:@[(id)DEFAULTCOLOR1,(id)DEFAULTCOLOR2] percentageArray:@[@(0.0),@(1)] gradientType:GradientFromLeftToRight];
    [checkDetailBtn addTarget:self action:@selector(checkDetailBtnOnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:checkDetailBtn];
    
    [checkDetailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.bottom.equalTo(contentView).with.offset(-32);
        make.size.mas_equalTo(CGSizeMake(150, 45));
    }];
    
}

- (void)closeBtnOnTouch:(id)sender
{
    closeType = 1;
    [self tapGestureAction:nil];
}

- (void)checkDetailBtnOnTouch:(id)sender
{
    closeType = 2;
    if (self.handler) {
        self.handler();
    }
    [self tapGestureAction:nil];
}

- (void)tapGestureAction:(UITapGestureRecognizer *)tapGesture
{
    [UIView animateWithDuration:0.5 animations:^{
        
        bgView.layer.transform = CATransform3DMakeTranslation(0, 0, 0);
        
        __block DHPaySuccessView *weakSelf = self;
        
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [weakSelf removeFromSuperview];
        });
        
    } completion:^(BOOL finished){
        
        //返回首页
        
        [[Util topViewController].navigationController popToRootViewControllerAnimated:NO];
        
        UITabBarController *tabBar = (UITabBarController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
        if (closeType == 1) {
            //关闭
            [tabBar setSelectedIndex:0];
        } else {
            //查看订单
            [tabBar setSelectedIndex:2];
        }
    }];
}

- (void)show
{
    [UIView animateWithDuration:0.5 animations:^{
        bgView.layer.transform = CATransform3DMakeTranslation(0, -bgViewHeight-(DEVICE_Height-bgViewHeight)/2.0, 0);
        
    } completion:^(BOOL finished){
        
    }];
    
}


@end
