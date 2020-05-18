//
//  RefundNoticeView.m
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/8/1.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "RefundNoticeView.h"
#import "WebModel.h"
#define BookNoticeViewH 430


@interface RefundNoticeView ()

@property (strong , nonatomic) TicketOrderModel *mdoel;

@property (strong , nonatomic) NSString *shouming;

@end

@implementation RefundNoticeView

//// 防止外部调用copy
//- (id)copyWithZone:(nullable NSZone *)zone {
//    return [BookNoticeView sharedSingleton];
//}
//// 防止外部调用mutableCopy
//- (id)mutableCopyWithZone:(nullable NSZone *)zone {
//    return [BookNoticeView sharedSingleton];
//}
//// 防止外部调用alloc 或者 new
//+ (instancetype)allocWithZone:(struct _NSZone *)zone {
//    return [BookNoticeView sharedSingleton];
//}

// 跟上面的方法实现有一点不同
+ (instancetype)sharedSingleton {
    static RefundNoticeView *_sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 要使用self来调用
        _sharedSingleton = [[self alloc] init];
    });
    return _sharedSingleton;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0 , SCREEN_WIDTH, SCREENH_HEIGHT);
        [self addSubview:self.mTableBaseView];
        [self addSubview:self.mView];
        
        [self.mView addSubview:self.title];
        [self.mView addSubview:self.webView];
        [self.mView addSubview:self.queren];
        [self.mView addSubview:self.quxiao];
        
        [self getRequest];
        
    }
    return self;
}
- (NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}
- (void)getRequest{
    
    WEAK_SELF;
    [AFHTTP requestInfoagreement444444success:^(NSDictionary *responseObject){
        WebModel *model = [WebModel mj_objectWithKeyValues:responseObject[@"content"]];
        weakSelf.shouming = [weakSelf filterHTML:model.content];
        [weakSelf.webView loadHTMLString:model.content baseURL:nil];
    }];
}


///通知出现
- (void)showMenu:(TicketOrderModel *)model
{
    
    _title.text = NSBundleLocalizedString(@"退票说明");
    [_queren setTitle:NSBundleLocalizedString(@"确认退款") forState:UIControlStateNormal];
    [_quxiao setTitle:NSBundleLocalizedString(@"取消") forState:UIControlStateNormal];
    self.mdoel = model;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.mTableBaseView.alpha = 0;
    self.mView.alpha = 1;
    self.mView .frame =  CGRectMake(0, SCREENH_HEIGHT, SCREEN_WIDTH, BookNoticeViewH + SYS_TabBarFloatHeight);
    [UIView animateWithDuration:0.3 animations:^{
        
        self.mView .frame =  CGRectMake(0, SCREENH_HEIGHT -BookNoticeViewH - SYS_TabBarFloatHeight, SCREEN_WIDTH, BookNoticeViewH + SYS_TabBarFloatHeight);
        self.mView.alpha = 1;
        self.mTableBaseView.alpha = 0.4;
    }];
    
}
///通知隐藏

- (void)hideMenu{
    
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.mView .frame =  CGRectMake(0, SCREENH_HEIGHT, SCREEN_WIDTH, BookNoticeViewH + SYS_TabBarFloatHeight);
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
- (void)lijidignpiao:(UIButton *)button{
    [self hideMenu];
    if(self.confirmRefundNoticeViewBloak){
        self.confirmRefundNoticeViewBloak(self.mdoel,self.shouming);
    }
}



#pragma mark ---- getview ---


- (UILabel *)title{
    if(!_title){
        _title = [[UILabel alloc]init];
        _title.frame = CGRectMake(0, 0, SCREEN_WIDTH, 45);
        _title.font = [UIFont systemFontOfSize:15];
        _title.textColor = [UIColor blackColor];
        _title.textAlignment = NSTextAlignmentCenter;
        
    }
    return _title;
}
//确认
- (UIButton *)queren{
    if(!_queren){
        _queren = [[UIButton alloc]init];
        _queren.frame = CGRectMake(SCREEN_WIDTH/2, BookNoticeViewH - 44, SCREEN_WIDTH/2, 44);
        _queren.titleLabel.font = [UIFont systemFontOfSize:15];
        [_queren setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_queren addTarget: self action: @selector(lijidignpiao:) forControlEvents: UIControlEventTouchUpInside];
        _queren.backgroundColor = UIColorFromHex(0x56b157);
        
    }
    return _queren;
}
//取消
- (UIButton *)quxiao{
    if(!_quxiao){
        _quxiao = [[UIButton alloc]init];
        _quxiao.frame = CGRectMake(0, BookNoticeViewH - 44, SCREEN_WIDTH/2, 44);
        _quxiao.titleLabel.font = [UIFont systemFontOfSize:15];
        [_quxiao setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_quxiao addTarget: self action: @selector(muneButtonTaped:) forControlEvents: UIControlEventTouchUpInside];
        _quxiao.backgroundColor = [UIColor whiteColor];
        
    }
    return _quxiao;
}
//内容
//- (UITextView *)congtext{
//    if(!_congtext){
//        _congtext = [[UITextView alloc]init];
//        _congtext.editable = NO;
//        _congtext.frame = CGRectMake(0, 45, SCREEN_WIDTH, BookNoticeViewH - 44 - 45);
//    }
//    return _congtext;
//}
- (WKWebView *)webView{
    if(!_webView){
        //创建WKWebview配置对象
        WKWebViewConfiguration*config = [[WKWebViewConfiguration alloc] init];
        config.preferences = [[WKPreferences alloc] init];
        config.preferences.minimumFontSize =10;
        config.preferences.javaScriptEnabled =YES;
        config.preferences.javaScriptCanOpenWindowsAutomatically =NO;
        
        NSMutableString *javascript = [NSMutableString string];
        [javascript appendString:@"document.documentElement.style.webkitTouchCallout='none';"];//禁止长按
        [javascript appendString:@"document.documentElement.style.webkitUserSelect='none';"];//禁止选择
        WKUserScript *noneSelectScript = [[WKUserScript alloc] initWithSource:javascript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        
        _webView = [[WKWebView alloc] init];
        _webView.frame = CGRectMake(0, 45, SCREEN_WIDTH, BookNoticeViewH - 44 - 45 - 2);
        [_webView.configuration.userContentController addUserScript:noneSelectScript];
        _webView.scrollView.scrollEnabled  = NO;
        
        
        UIView *lin = [[UIView alloc]init];
        lin.frame = CGRectMake(0,  BookNoticeViewH - 45, SCREEN_WIDTH, 1);
        lin.backgroundColor = UIColorFromHex(0xf6f6f6);
        [self.mView addSubview:lin];
        //        _webView.CTNavigationDelegate = self;
    }
    return _webView;
}


- (UIView *)mView{
    if(!_mView){
        _mView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENH_HEIGHT -BookNoticeViewH - SYS_TabBarFloatHeight, SCREEN_WIDTH, BookNoticeViewH + SYS_TabBarFloatHeight)];
        _mView.backgroundColor = [UIColor whiteColor];
        
        
    }
    return _mView;
    
}

- (UIView *)mTableBaseView{
    if(!_mTableBaseView){
        _mTableBaseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT )];
        _mTableBaseView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTappedAction:)];
        [_mTableBaseView addGestureRecognizer:bgTap];
    }
    return _mTableBaseView;
}

@end
