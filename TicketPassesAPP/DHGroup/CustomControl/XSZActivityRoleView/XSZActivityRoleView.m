//
//  XSZActivityRoleView.m
//  XiaoShunZiAPP
//
//  Created by Mac on 2019/4/15.
//  Copyright © 2019 XiaoShunZi. All rights reserved.
//

#import "XSZActivityRoleView.h"
#import "TPKeyboardAvoidingScrollView.h"

#define LINESPACE 3

@interface XSZActivityRoleView ()
{
    UIView *bgView;
    float bgViewHeight;
    UIButton *ensureBtn;
    
}
@end

@implementation XSZActivityRoleView

+ (instancetype)sharedView:(TicketModel*)model {
    
    static dispatch_once_t once;
    static XSZActivityRoleView *activityRoleView;
    dispatch_once(&once, ^ {
        activityRoleView = [[self alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, DEVICE_Height)];
        
        [activityRoleView setBackgroundColor:RGBA(0, 0, 0, 0.5)];
    
    });
    
    [activityRoleView initView:model];
    
    return activityRoleView;
    
}


- (void)initView:(TicketModel*)model
{
    
    for (UIView *v in self.subviews) {
        [v removeFromSuperview];
    }
    
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    //    [self addGestureRecognizer:tapGesture];
    
    bgViewHeight = 340+16+32;
    
    bgView = [[UIView alloc] init];
    [bgView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).with.offset(DEVICE_Height);
        make.size.mas_equalTo(CGSizeMake(285, bgViewHeight));
    }];
    
    
    UIView *topView = [[UIView alloc] init];
//    [topView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"RoleBG"]]];
    [topView setBackgroundColor:RGBA(86, 177, 87, 1.0)];
    [topView.layer setMasksToBounds:YES];
    [topView.layer setCornerRadius:12.5];
    [bgView addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).with.offset(0);
        make.left.equalTo(bgView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(285, 340));
    }];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *closeImage = [UIImage imageNamed:@"pop_close"];
    //UIImageRenderingModeAlwaysOriginal这个枚举值是声明这张图片要按照原来的样子显示，不需要渲染成其他颜色
    closeImage = [closeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [closeBtn setImage:closeImage forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnOnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:closeBtn];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).with.offset(16);
        make.centerX.equalTo(bgView);
        make.size.mas_equalTo(CGSizeMake(32, 32));
    }];
     
     
     UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 285, 40)];
     titleLabel.textColor = [UIColor whiteColor];
     titleLabel.font = [UIFont systemFontOfSize:18];
     titleLabel.text = model.notification_english_label;
     titleLabel.textAlignment = NSTextAlignmentCenter;
     titleLabel.backgroundColor = [UIColor clearColor];
     [topView addSubview:titleLabel];
    
    
    //套餐详情
    
    TPKeyboardAvoidingScrollView *sv = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 40, 285, 300-16)];
    sv.contentSize = (CGSize){sv.width, sv.height};
    //    outScrollView.pagingEnabled = YES;
    sv.delegate      = self;
    [sv setBackgroundColor:[UIColor clearColor]];
//    sv.bounces = NO;
    sv.showsHorizontalScrollIndicator = NO;
    sv.showsVerticalScrollIndicator = NO;
    [topView addSubview:sv];
    
    
    NSArray *componds = [model.notification_english_content componentsSeparatedByString:@"\n"];
    
    CGSize size = CGSizeMake(285-32,2000);
    CGSize contentLabelsize = [model.notification_english_content sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:size lineBreakMode:UILineBreakModeCharacterWrap];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:model.notification_english_content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:LINESPACE];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [model.notification_english_content length])];
    
    
    float contentHeight = contentLabelsize.height+((int)(contentLabelsize.height/14.0)-1)*LINESPACE+3+10;

    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 285-32, contentHeight)];
    descLabel.textColor = [UIColor whiteColor];
    descLabel.font = [UIFont systemFontOfSize:14];
    descLabel.attributedText = attributedString;
    descLabel.numberOfLines = 0;
    descLabel.textAlignment = NSTextAlignmentLeft;
    descLabel.backgroundColor = [UIColor clearColor];
    [sv addSubview:descLabel];
     
    sv.contentSize = (CGSize){sv.width, contentHeight};
    
}

- (void)closeBtnOnTouch:(id)sender
{
    [self tapGestureAction:nil];
}

- (void)checkDetailBtnOnTouch:(id)sender
{
    

    [self tapGestureAction:nil];
}

- (void)tapGestureAction:(UITapGestureRecognizer *)tapGesture
{
    [UIView animateWithDuration:0.5 animations:^{
        
        bgView.layer.transform = CATransform3DMakeTranslation(0, 0, 0);
        
        __block XSZActivityRoleView *weakSelf = self;
        
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [weakSelf removeFromSuperview];
        });
        
    } completion:^(BOOL finished){
        
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
