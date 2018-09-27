//
//  RegisterBrandViewController.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/3.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "RegisterBrandViewController.h"
#import "RegisterFirstStepViewController.h"
#import <WebKit/WebKit.h>


@interface RegisterBrandViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) WKWebViewConfiguration *wkConfig;
@end

@implementation RegisterBrandViewController

- (WKWebViewConfiguration *)wkConfig {
    if (!_wkConfig) {
        _wkConfig = [[WKWebViewConfiguration alloc] init];
        _wkConfig.allowsInlineMediaPlayback = YES;
        _wkConfig.allowsPictureInPictureMediaPlayback = YES;
        
        //设置configur对象的preferences属性的信息
        WKPreferences *preferences = [[WKPreferences alloc] init];
        _wkConfig.preferences = preferences;
        
        //是否允许与js进行交互，默认是YES的，如果设置为NO，js的代码就不起作用了
        preferences.javaScriptEnabled = YES;
        //        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        
    }
    return _wkConfig;
}

- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        

        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight) configuration:self.wkConfig];

        
        
        
        _wkWebView.navigationDelegate = self;
        
        _wkWebView.UIDelegate = self;
        
        [self.view addSubview:_wkWebView];
        
    }
    return _wkWebView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = csBlackColor;
    self.wkWebView.hidden = NO;
    self.title = @"注册";
    [self startLoad];

}


- (void)startLoad {
    
    NSString *urlString = @"http://www.niusb.com/zhuce.html";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
 
    [self.wkWebView loadRequest:request];
}
#pragma mark - WKWKNavigationDelegate Methods

/*
 *5.在WKWebViewd的代理中展示进度条，加载完成后隐藏进度条
 */

//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    CSLog(@"开始加载网页");

    
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    CSLog(@"加载完成");

}

//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    CSLog(@"加载失败");

}

    
@end
