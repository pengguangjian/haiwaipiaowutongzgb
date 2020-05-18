//
//  PaymentWebViewController.m
//  TicketPassesAPP
//
//  Created by xiaoshiheng on 2019/7/31.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "PaymentWebViewController.h"

@interface PaymentWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation PaymentWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.top.mas_equalTo(SYS_TopHeight);
        maker.right.left.bottom.equalTo(self.view);
    }];
    
    [self addLeftBarButtonImage:[UIImage imageNamed:@"navi_back"]];
    [self payment];
    
}
- (void)clickLeftBarButton:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)payment{
    
    self.navigationItem.title = @"Payment";
    
    NSString * urlStr = [NSString stringWithFormat:@"%@api/payment/create",HTTPAPI];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:url];
    // 如果有webMethod并且是POST,则POST方式组合提交
    [requestM setHTTPMethod:@"POST"];
    NSString * body = [NSString stringWithFormat:@"order_id=%@&order_type=%@",self.order_id,self.order_type];
    [requestM setHTTPBody:[body dataUsingEncoding: NSUTF8StringEncoding]];
    [self.webView loadRequest:requestM];
    
  
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBManager showLoading];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBManager hideAlert];
    int htmlWidth= [[webView stringByEvaluatingJavaScriptFromString: @"document.body.scrollWidth"] intValue];//获取 html 宽度
    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"var element = document.createElement('meta');  element.name = \"viewport\";  element.content = \"width=device-width,initial-scale=%f,minimum-scale=0.1,maximum-scale=2.0,user-scalable=yes\"; var head = document.getElementsByTagName('head')[0]; head.appendChild(element);", webView.frame.size.width / htmlWidth]];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBManager hideAlert];
}
- (UIWebView *)webView{
    if(!_webView){
        
        _webView = [[UIWebView alloc]init];
        _webView.delegate = self;
        
    }
    return _webView;
}


@end
