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
#import "AsynImageView.h"
#import "LoginPage.h"
#define leftBtnColor [UIColor colorWithRed:98/255.0 green:138/255.0 blue:14/255.0 alpha:1]
#define rightBtnColor [UIColor colorWithRed:176/255.0 green:45/255.0 blue:35/255.0 alpha:1]
#define customBlueColor [UIColor colorWithRed:86.0/255.0 green:161.0/255.0 blue:217.0/255.0 alpha:1.0]
#define testColor [UIColor colorWithRed:77/255.0 green:88/255.0 blue:0/255.0 alpha:1.0]
#import "HandleData.h"
#import "Video.h"
@interface MovieDetailPage ()
@end
@implementation MovieDetailPage
- (void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIMoviePlayerControllerDidEnterFullscreenNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIMoviePlayerControllerDidExitFullscreenNotification" object:nil];
//    [movieNameLable release];
    [nameBgImg release];
//    [durationLable release];
    [popularImg release];
    [popularLab release];
    [theAuthorImageView release];
    [authorNameLab release];
    [movieInfoTextView release];
    [movieWeb release];
    collectRequest.delegate = nil;
    [collectRequest release];
    _attentionTool.delegate = nil;
    [_attentionTool release];
    self.detailRequest.delegate = nil;
    self.detailRequest = nil;
    self.movieId = nil;
    self.detailDic = nil;
    
    
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
    
    nameBgImg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 30)];
    [self.view addSubview:nameBgImg];
    nameBgImg.backgroundColor = [UIColor redColor];
    
    movieNameLable = [UILabel labelWithRect:CGRectMake(50, 5, 260, 30) font:[UIFont systemFontOfSize:16]];
    movieNameLable.textAlignment = NSTextAlignmentLeft;
    movieNameLable.textColor = [UIColor blackColor];
    movieNameLable.backgroundColor = [UIColor yellowColor];
    movieNameLable.alpha = 0.8;
    [self.view addSubview:movieNameLable];
    

    movieWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, movieNameLable.bottom+5, 320, self.view.height*0.5)];
    movieWeb.backgroundColor= [UIColor yellowColor];
    movieWeb.delegate = self;
    movieWeb.scalesPageToFit = YES;
    movieWeb.scrollView.scrollEnabled = NO;
    [self.view addSubview:movieWeb];
    durationLable = [UILabel labelWithRect:CGRectMake(0, movieWeb.bottom-70, movieWeb.width/2, 30) font:[UIFont systemFontOfSize:14]];
durationLable.text = @"<<  时长:9'16''  >>";
    durationLable.layer.cornerRadius = 5.0;
    durationLable.textAlignment = NSTextAlignmentCenter;
    durationLable.textColor = [UIColor whiteColor];
    durationLable.backgroundColor = [UIColor blackColor];
    durationLable.alpha = 0.8;
    [movieWeb addSubview:durationLable];
    
    popularImg  = [[UIImageView alloc] initWithFrame:CGRectMake(durationLable.right+40, movieWeb.bottom-70, 30, 30)];
    [popularImg setBackgroundColor:[UIColor yellowColor]];
    [movieWeb addSubview:popularImg];
    popularLab = [[UILabel alloc] initWithFrame:CGRectMake(popularImg.right+10, movieWeb.bottom-70, 60, 30)];
    popularLab.font = [UIFont systemFontOfSize:11];
    popularLab.textAlignment = NSTextAlignmentCenter;
    [movieWeb addSubview:popularLab];
    
    
    theAuthorImageView = [[AsynImageView alloc] initWithFrame:CGRectMake(5, movieWeb.bottom+5, 100, self.view.height-movieNameLable.height-movieWeb.height-128)];
    theAuthorImageView.backgroundColor= [UIColor yellowColor];
    [self.view addSubview:theAuthorImageView];
    
    
    authorNameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, theAuthorImageView.height-20, theAuthorImageView.width, 20)];
    authorNameLab.textAlignment = NSTextAlignmentCenter;
    authorNameLab.backgroundColor = [UIColor redColor];
    authorNameLab.alpha = 0.5;
    [theAuthorImageView addSubview:authorNameLab];
    movieInfoTextView = [[UITextView alloc] initWithFrame:CGRectMake(theAuthorImageView.right+5, movieWeb.bottom+5, self.view.width-theAuthorImageView.width-15, theAuthorImageView.height)];
    movieInfoTextView.editable = NO;
    movieInfoTextView.textAlignment = NSTextAlignmentCenter;
    
    movieInfoTextView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:movieInfoTextView];
      for (int i = 0; i<2; i++) {
          
          UIImageView *frontBgImg = [[UIImageView alloc] initWithFrame:CGRectMake(160*i, self.view.bottom-110, 50, 50)];
          frontBgImg.backgroundColor = [UIColor yellowColor];
          [self.view addSubview:frontBgImg];
          [frontBgImg release];
          
        UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom image:nil frame:CGRectMake(50+160*i, self.view.bottom-110, 110, 50) target:self action:nil];
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
    NSLog(@"%@回来的ID",self.movieId);
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
    [self.detailRequest setDelegate:nil];
    collectRequest.delegate = nil;
    _attentionTool.delegate = nil;
    [movieWeb stopLoading];
    movieWeb.delegate = nil;
}
-(void)exitFullScreen
{
    NSLog(@"退出全屏");
    [[UIDevice currentDevice] performSelector:@selector(setOrientation:) withObject:(id)UIDeviceOrientationPortrait];
}
-(BOOL)isIn
{
    NSMutableArray* arry = [HandleData allVideosInformation];
    for(Video * obj in arry)
    {
        if ([obj.videoID isEqualToString:self.movieId]) {
            return NO;
        }
    }
    return YES;
}
-(void)enterFullScreen
{

    
    if ([self isIn]) {
        //NSLog(@"%@",self.detailDic);
        //为空判断
        ;
        Video * video = [[Video alloc]initWithVideoName:[[self.detailDic valueForKey:@"m_name"]isEqual:nil]?@"幻方":[self.detailDic valueForKey:@"m_name"]
                                           videoPicture:theAuthorImageView.fileName
                                                videoID:self.movieId
                                            videoAuthor:[[self.detailDic valueForKey:@"m_author"]isEqual:nil]?@"幻方":[self.detailDic valueForKey:@"m_author"]
                                              videoTime:[[self.detailDic valueForKey:@"m_duration"] isEqual:nil]?@"00:00":[self.detailDic valueForKey:@"m_duration"]
                                           videoPopular:[[NSString stringWithFormat:@"%@",[self.detailDic objectForKey:@"m_popular"]]isEqual:nil]?@"0":[NSString stringWithFormat:@"%@",[self.detailDic objectForKey:@"m_popular"]]];
        
        NSLog(@"---%@---%@-----%@------%@------%@------%@",video.videoID,video.videoName,video.videoTime,video.videoPopular,video.videoAuthor,video.videoPicture);
        [HandleData insertOneVideo:video];
        [video release];
    }
    
    NSLog(@"全屏");
//    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
//        [[UIDevice currentDevice] performSelector:@selector(setOrientation:)
//                                       withObject:(id)UIInterfaceOrientationLandscapeRight];
//    }
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
    if ([Tools isHaveLogin]==YES) {
                //进行按钮颜色的变化等.
        [self shouChang];

    }
    else{
        
        [Tools showLoginPagesByViewController:self];
   
        
    }
    
    //NSLog(@"SHOU----");
    


       
    
}
-(void)shouChang
{
    collectRequest = [[RequestTools alloc] init];
    [collectRequest setDelegate:self];
    NSString *nameStr = [NSString stringWithFormat:@"?email=%@&movieID=",    [[NSUserDefaults standardUserDefaults] objectForKey:@"user_email"]];
    NSArray *strArry = [NSArray arrayWithObjects:COLLECT_VIDOE,nameStr,self.movieId, nil];
    [collectRequest requestWithUrl_Asynchronous:[MyNsstringTools groupStrByAStrArray:strArry]];

}

#pragma mark--关注作者
-(void)attentionTheAuthor
{
    if ([Tools isHaveLogin]==YES) {
        [self guanzhu];
        NSLog(@"作者:%@",authorNameLab.text);

    }
    else
    {
        [Tools showLoginPagesByViewController:self];
        
    }
    
       
}
-(void)guanzhu
{
    //NSLog(@"作者:%@",authorNameLab.text);
    _attentionTool = [[RequestTools alloc]init];
    [_attentionTool setDelegate:self];
    NSArray *strArry = [NSArray arrayWithObjects:ATTENTION_AUTHOR,[NSString stringWithFormat:@"?email=%@&authName=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"user_email"],authorNameLab.text],nil];
    [_attentionTool requestWithUrl_Asynchronous:[MyNsstringTools groupStrByAStrArray:strArry]];

    
}
#pragma mark--分享视频
-(void)shareTheMovie
{
    [Tools makeShareWithString:@"#市场上可查看白色#http://weibo.com/u/3274767297?wvr=5&c=spr_web_sq_firefox_weibo_t001........sjnclsknlscnlkscnlskcnlsdkcnlskdcnlkdscnlksdcnlkcn" andImagePath:nil];//分享内容二次定制,捆绑APP商店地址
}
#pragma mark--请求的回调方法
-(void)requestSuccessWithResultDictionary:(NSDictionary *)dic
{
    NSLog(@"视频详情:%@",dic );
    self.detailDic = dic;

    if ([[dic allKeys] containsObject:@"m_url"]==YES){
    //NSLog(@"链接:%@",dic );
    movieNameLable.text = [dic objectForKey:@"m_name"];
    authorNameLab.text = [dic objectForKey:@"m_author"];
    movieInfoTextView.text = [dic objectForKey:@"m_description"];
    durationLable.text = [dic objectForKey:@"m_duration"];
    NSString *popularStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"m_popular"]];
    popularLab.text = popularStr;

    theAuthorImageView.imageURL = [MyNsstringTools changeStrWithUT8:[dic objectForKey:@"authImg"]];
    [self loadMovieWithUrl:[dic objectForKey:@"m_url"]];
    durationLable.text = [dic objectForKey:@"m_duration"];
    }
}
-(void)requestFailedWithResultDictionary:(NSDictionary *)dic
{
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [Tools openLoadsign:self.view WithString:@"正在加载..."];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [Tools closeLoadsign:self.view];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [Tools closeLoadsign:self.view];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
