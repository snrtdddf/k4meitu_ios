//
//  SecPageH5Controller.m
//  K4Meitu
//
//  Created by simpleem on 8/30/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "SecPageH5Controller.h"
#import <WebKit/WebKit.h>
#import "Header.h"
#import "UIButton+ImageTitleSpacing.h"
@interface SecPageH5Controller ()<WKNavigationDelegate,WKUIDelegate>
@property (strong, nonatomic) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UIView *failureView;
@end

@implementation SecPageH5Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = White_COLOR;
    self.tabBarController.tabBar.hidden = YES;
    [self addTitleWithName:@"详情" wordNun:2];
    [self addBackButton:NO];
    [self addStatusBlackBackground];
    
    if (self.webView == nil) {
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT)];
    }
    
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.scrollView.alwaysBounceHorizontal = NO;
    self.webView.scrollView.alwaysBounceVertical = NO;
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    self.webView.scrollView.bounces = YES;
    self.webView.autoresizesSubviews = YES;
    self.webView.multipleTouchEnabled = YES;
    
    self.webView.contentMode = UIViewContentModeScaleAspectFit;
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    self.webView.configuration.preferences.javaScriptEnabled = YES;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [self.view addSubview:self.webView];
    
    // 进度条
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    progressView.tintColor = [UIColor colorWithRed:43/255.0f green:176/255.0f blue:255/255.0f alpha:1];//43 176 255
    progressView.trackTintColor = [UIColor whiteColor];
    [self.view addSubview:progressView];
    self.progressView = progressView;
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];

}
- (void)backButtonAction:(UIButton *)sender{
    if (self.webView.backForwardList.backList.count == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.webView goToBackForwardListItem:[self.webView.backForwardList.backList firstObject]];
    }
}

- (void)leftCloseButtonAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    
    //页面加载失败
    if ([webView.title containsString:@"Error report"] || [webView.title containsString:@"Tomcat"] || [webView.title containsString:@"403"]|| [webView.title containsString:@"404"] || [webView.title containsString:@"500"]) {
        [self addTitleWithName:@"页面加载失败" wordNun:6];
        [self setFailureViewUI];
    }
    
    NSString *title = self.webView.title;
    [self addTitleWithName:title wordNun:(int)title.length];
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
    [self setFailureViewUI];
}

- (void)setFailureViewUI{
    
    self.failureView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT)];
    self.failureView.backgroundColor = lightGray_Color;
    UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(IPHONE_WIDTH/2-0.16*IPHONE_WIDTH, IPHONE_HEIGHT/2-0.245*IPHONE_HEIGHT, 0.32*IPHONE_WIDTH, 0.18*IPHONE_HEIGHT)];
    iconImg.image = [UIImage imageNamed:@"failure"];
    [self.failureView addSubview:iconImg];
    
    UIButton *updateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    updateBtn.frame = CGRectMake(IPHONE_WIDTH/2-0.32*IPHONE_WIDTH, CGRectGetMaxY(iconImg.frame) + 0.03*IPHONE_HEIGHT, 0.64*IPHONE_WIDTH, 0.048*IPHONE_HEIGHT);
    [updateBtn setTitle:@"刷新      页面加载失败!" forState:UIControlStateNormal];
    [updateBtn setImage:[UIImage imageNamed:@"update_24"] forState:UIControlStateNormal];
    [updateBtn addTarget:self action:@selector(updateBtn) forControlEvents:UIControlEventTouchUpInside];
    [updateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    updateBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [updateBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5.0];
    [self.failureView addSubview:updateBtn];
    
    [self.webView addSubview:self.failureView];
}

- (void)updateBtn{
    [self.webView reload];
}

// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}
//// 在收到响应后，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
//
//}
//// 在发送请求之前，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
//
//}

// 创建一个新的WebView
//- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
//
//    return webView;
//}

/**
 *  web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(void (^)())completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler(YES);
                                                      }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action){
                                                          completionHandler(NO);
                                                      }]];
    
    [self presentViewController:alertController animated:YES completion:^{}];
}
/*
 1.从web界面中接收到一个脚本时调用
 2.这个协议中包含一个必须实现的方法，这个方法是提高App与web端交互的关键，它可以直接将接收到的JS脚本转为OC或Swift对象。（当然，在UIWebView也可以通过“曲线救国”的方式与web进行交互，著名的Cordova框架就是这种机制）
 
 */
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = Black_COLOR;
}
// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}
// 记得取消监听
- (void)dealloc {
    
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
