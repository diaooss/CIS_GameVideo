//
//  JustWEBToShowSomeThing.m
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-8-22.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import "JustWEBToShowSomeThing.h"
#import "Tools.h"

@interface JustWEBToShowSomeThing ()

@end

@implementation JustWEBToShowSomeThing
- (void)dealloc
{
    m_web = nil;
    self.request = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithRequestUrl:(NSString *)urlStr
{
        NSURL *url = [NSURL URLWithString:urlStr];
    _request = [[NSURLRequest alloc] initWithURL:url];
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [Tools navigaionView:self leftImageName:@"goBack.png" title:@""];

    ///
    m_web = [[UIWebView alloc] initWithFrame:self.view.bounds];
    m_web.scalesPageToFit  = NO;
    m_web.delegate = self;
    
    m_web.dataDetectorTypes = UIDataDetectorTypePhoneNumber|UIDataDetectorTypeLink;
    [self.view addSubview:m_web];
    [m_web loadRequest:_request];
    m_web.autoresizingMask = YES;
 

	// Do any additional setup after loading the view.
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//        self.navigationItem.title = [m_web stringByEvaluatingJavaScriptFromString:@"document.title"];
    //document.location.href
    NSLog(@"出现");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [m_web stopLoading];
    [m_web setDelegate:nil];
}
-(void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
