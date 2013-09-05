//
//  MovieDetailPage.m
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-8-22.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import "MovieDetailPage.h"
#import "Tools.h"
#import "PublciViewsTools.h"
#import "Header.h"
#import "MyNsstringTools.h"
#import "RequestTools.h"
#import "RequestUrls.h"
#define leftBtnColor [UIColor colorWithRed:98/255.0 green:138/255.0 blue:14/255.0 alpha:1]
#define rightBtnColor [UIColor colorWithRed:176/255.0 green:45/255.0 blue:35/255.0 alpha:1]
#define customBlueColor [UIColor colorWithRed:86.0/255.0 green:161.0/255.0 blue:217.0/255.0 alpha:1.0]
#define testColor [UIColor colorWithRed:77/255.0 green:88/255.0 blue:0/255.0 alpha:1.0]
@interface MovieDetailPage ()

@end
@implementation MovieDetailPage
- (void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIMoviePlayerControllerDidEnterFullscreenNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIMoviePlayerControllerDidExitFullscreenNotification" object:nil];
    theAuthorImageView = nil;
    movieInfoTextView = nil;
    movieNameLable = nil;
    durationLable = nil;
    movieWeb = nil;
    _detailRequest = nil;
    self.detailRequest.delegate = nil;
    self.detailDic = nil;
    self.movieId = nil;
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterFullScreen) name:@"UIMoviePlayerControllerDidEnterFullscreenNotification" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitFullScreen) name:@"UIMoviePlayerControllerDidExitFullscreenNotification" object:nil];
    }
    return self;
}
-(void)loadView
{
    self.view = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    [Tools navigaionView:self leftImageName:@"goBack.png" rightImageName:@"myFriends.png" title:@"影片详情"];
    movieWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 3, 320, self.view.height*0.5)];
    movieWeb.backgroundColor= [UIColor yellowColor];
    movieWeb.delegate = self;
    movieWeb.scalesPageToFit = YES;
    [self.view addSubview:movieWeb];
    durationLable = [UILabel labelWithRect:CGRectMake(0, movieWeb.bottom-33, movieWeb.width, 30) font:[UIFont systemFontOfSize:14]];
durationLable.text = @"<<  时长:9'16''  >>";
    durationLable.layer.cornerRadius = 5.0;
    durationLable.textAlignment = NSTextAlignmentCenter;
    durationLable.textColor = [UIColor whiteColor];
    durationLable.backgroundColor = [UIColor blackColor];
    durationLable.alpha = 0.8;
    [movieWeb addSubview:durationLable];
    
    
    movieNameLable = [UILabel labelWithRect:CGRectMake(5, movieWeb.bottom+5, durationLable.width-20, 20) font:[UIFont systemFontOfSize:16]];
    movieNameLable.layer.cornerRadius = 5.0;
    movieNameLable.textAlignment = NSTextAlignmentCenter;
    movieNameLable.textColor = [UIColor blackColor];
    movieNameLable.backgroundColor = [UIColor yellowColor];
    movieNameLable.alpha = 0.8;
    [self.view addSubview:movieNameLable];
    theAuthorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, movieWeb.bottom+40, 100, self.view.height-movieWeb.height-8-movieNameLable.height-130)];
    theAuthorImageView.backgroundColor= [UIColor yellowColor];
    [self.view addSubview:theAuthorImageView];
    theAuthorImageView.image = [UIImage imageNamed:@"headerimage.png"];
    
    movieInfoTextView = [[UITextView alloc] initWithFrame:CGRectMake(theAuthorImageView.right+5, movieNameLable.bottom+5, self.view.width-theAuthorImageView.width-15, theAuthorImageView.height+10)];
    movieInfoTextView.editable = NO;
    movieInfoTextView.text = @"开展评比达标表彰活动，是鼓励先进、鞭策后进、推动工作的一种手段。恰到好处的评比与表彰，能够激发相关部门与人员的工作热情，促进工作的开展、落实；能够树立好的典范，传递“正能量”，带动其他群体积极上进，推动事业的发展。";
    movieInfoTextView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:movieInfoTextView];
      for (int i = 0; i<2; i++) {
        UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom image:nil frame:CGRectMake(160*i, self.view.bottom-110, 160, 50) target:self action:nil];
        bottomBtn.backgroundColor = [UIColor blackColor];
        [bottomBtn setShowsTouchWhenHighlighted:YES];
        bottomBtn.tag = i*100+100;
        if (i==0) {
            [bottomBtn setTitle:@"关注作者" forState:UIControlStateNormal];
            bottomBtn.backgroundColor = rightBtnColor;
            [bottomBtn addTarget:self action:@selector(attentionTheAuthor) forControlEvents:UIControlEventTouchUpInside];
        }else{
            bottomBtn.backgroundColor = customBlueColor;
            [bottomBtn setTitle:@"分享视频" forState:UIControlStateNormal];
            [bottomBtn addTarget:self action:@selector(shareTheMovie) forControlEvents:UIControlEventTouchUpInside];
}
        [self.view addSubview:bottomBtn];
    }
    //测试
    self.detailRequest = [[RequestTools alloc]init];
    [_detailRequest setDelegate:self];
    NSString *movieID = [NSString stringWithFormat:@"?ID=%@",self.movieId];
    NSArray *strArry = [NSArray arrayWithObjects:GET_Moview_DETAIL,movieID,nil];
    
    [_detailRequest requestWithUrl_Asynchronous:[MyNsstringTools groupStrByAStrArray:strArry]];
    NSLog(@"请求详情:%@",[MyNsstringTools groupStrByAStrArray:strArry]);
    

}
- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [movieWeb stopLoading];
    movieWeb.delegate = nil;
}
-(void)exitFullScreen
{
    NSLog(@"退出全屏");
    [[UIDevice currentDevice] performSelector:@selector(setOrientation:) withObject:(id)UIDeviceOrientationPortrait];
}
-(void)enterFullScreen
{
    NSLog(@"全屏");
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        [[UIDevice currentDevice] performSelector:@selector(setOrientation:)
                                       withObject:(id)UIInterfaceOrientationLandscapeRight];
    }
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)loadMovieWithUrl:(NSString *)urlStr
{
    NSURLRequest *movieRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr ] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5.0];
    [movieWeb loadRequest:movieRequest];
}
#pragma mark--视频收藏
-(void)topRightCorenerBtnAction
{
    //收藏该视频
}
#pragma mark--关注作者
-(void)attentionTheAuthor
{
    
}
#pragma mark--分享视频
-(void)shareTheMovie
{
    [Tools makeShare];//分享内容二次定制,捆绑APP商店地址
}

#pragma mark--请求的回调方法
-(void)requestSuccessWithResultDictionary:(NSDictionary *)dic
{
    NSLog(@"链接:%@",[dic objectForKey:@"m_url"]);
    NSLog(@"详情字典:%@",dic);
    movieNameLable.text = [dic objectForKey:@"m_name"];
    movieInfoTextView.text = [dic objectForKey:@"m_description"];
    [self loadMovieWithUrl:[dic objectForKey:@"m_url"]];
    durationLable.text = [dic objectForKey:@"m_duration"];
}
-(void)requestFailedWithResultDictionary:(NSDictionary *)dic
{
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
