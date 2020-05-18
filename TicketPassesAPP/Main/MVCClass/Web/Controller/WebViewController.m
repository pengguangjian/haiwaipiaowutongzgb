//
//  WebViewController.m
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/11.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
#import "WebModel.h"

@interface WebViewController ()
<UIWebViewDelegate>

//@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation WebViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.top.mas_equalTo(SYS_TopHeight);
        maker.right.left.bottom.equalTo(self.view);
    }];

    if(self.webType == 0){
        [self.view addSubview:self.progressView];
        [self loadRequest:@"https://www.baidu.com"];
    }
    else if (self.webType == 1 || self.webType == 2){
        WEAK_SELF;
        [AFHTTP requestInfoagreementType:self.webType  success:^(NSDictionary *responseObject){
            WebModel *model = [WebModel mj_objectWithKeyValues:responseObject[@"content"]];
            weakSelf.navigationItem.title = model.title;
            [weakSelf.webView loadHTMLString:model.content baseURL:nil];
        }];
    }
    else if (self.webType == 5){
         WEAK_SELF;
        [AFHTTP requestNewsdetailNewsId:self.newsId  success:^(id responseObject){
            WebModel *model = [WebModel mj_objectWithKeyValues:responseObject[@"news_info"]];
            weakSelf.navigationItem.title = model.title;
            [weakSelf.webView loadHTMLString:model.content baseURL:nil];
        }];
    }
    else if (self.webType == 6){
        self.navigationItem.title = self.newsTiele;
        [self.webView loadHTMLString:self.newsContent baseURL:nil];
    }
    else{
        NSLog(@"类型不正确");
    }

}

- (void)loadRequest:(NSString *)urlString{
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    if([request.URL.absoluteString isEqualToString:@"about:blank"]){
        //本地
        return YES;
    }
    return NO;
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
#pragma mark -KVO

- (UIWebView *)webView{
    if(!_webView){
        _webView = [[UIWebView alloc]init];
        _webView.delegate = self;
        
//        [_webView.configuration.userContentController addUserScript:noneSelectScript];
        
    }
    return _webView;
}
//- (WKWebView *)webView{
//    if(!_webView){
//        //创建WKWebview配置对象
//        WKWebViewConfiguration*config = [[WKWebViewConfiguration alloc] init];
//        config.preferences = [[WKPreferences alloc] init];
//        config.preferences.minimumFontSize =10;
//        config.preferences.javaScriptEnabled =YES;
//        config.preferences.javaScriptCanOpenWindowsAutomatically =NO;
//
//        NSMutableString *javascript = [NSMutableString string];
//        [javascript appendString:@"document.documentElement.style.webkitTouchCallout='none';"];//禁止长按
//        [javascript appendString:@"document.documentElement.style.webkitUserSelect='none';"];//禁止选择
//        WKUserScript *noneSelectScript = [[WKUserScript alloc] initWithSource:javascript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//
//        _webView = [[WKWebView alloc] init];
//        [_webView.configuration.userContentController addUserScript:noneSelectScript];
//    }
//    return _webView;
//}
- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, SYS_TopHeight, SCREEN_WIDTH, 4)];
        _progressView.progressTintColor = [UIColor redColor];
        _progressView.trackTintColor = [UIColor clearColor];
        
    }
    return _progressView;
}
@end
