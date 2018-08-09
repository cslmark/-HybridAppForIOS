//
//  ViewController.m
//  HybridDemo
//
//  Created by IanChen on 2018/8/7.
//  Copyright © 2018年 IanChen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backwardBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreashBtn;

- (IBAction)forwardClick:(UIBarButtonItem *)sender;
- (IBAction)backwardClick:(UIBarButtonItem *)sender;
- (IBAction)refreashClick:(UIBarButtonItem *)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view, typically from a nib.
    NSURL* baiUrl = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:baiUrl];
    [self.webView loadRequest:request];
    self.webView.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"request = %@", request);
    NSLog(@"navigationType = %ld", navigationType);
    NSLog(@"request.url = %@", request.URL);
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
     [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.forwardBtn.enabled = webView.canGoForward;
    self.forwardBtn.enabled = webView.canGoBack;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    self.forwardBtn.enabled = webView.canGoForward;
    self.forwardBtn.enabled = webView.canGoBack;
     [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


#pragma mark - BtnEvent IBoutlet
- (IBAction)forwardClick:(UIBarButtonItem *)sender {
    [self.webView goForward];
}

- (IBAction)backwardClick:(UIBarButtonItem *)sender {
    [self.webView goBack];
}

- (IBAction)refreashClick:(UIBarButtonItem *)sender {
    [self.webView reload];
}
@end
