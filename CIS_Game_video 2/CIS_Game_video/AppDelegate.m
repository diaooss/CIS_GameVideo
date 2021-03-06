//
//  AppDelegate.m
//  CIS_Game_video
//
//  Created by huangfangwang on 13-7-15.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "IIViewDeckController.h"
#import "LeftViewController.h"
#import "WZGuideViewController.h"
#import "Reachability.h"
//
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import <TencentOpenAPI/QQApi.h>

//广告
#import "YouMiConfig.h"
@implementation AppDelegate


//初始化将要分享的平台
- (void)initAllPlatforms
{
    //initSina//新浪
    [ShareSDK connectSinaWeiboWithAppKey:@"3224078821"
                               appSecret:@"5ad0997882d85be5eb787afea08f16ad"
                             redirectUri:@"http://open.weibo.com/developers/identity/edit"];
    //initQQzone
    [ShareSDK connectQZoneWithAppKey:@"100520775"
                           appSecret:@"40c7bfff572e310870555ffc6576590f"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    //initQQFriend
    [ShareSDK connectQQWithQZoneAppKey:@"100520775"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    //微信
    [ShareSDK connectWeChatWithAppId:@"wx89d583dd8184e112"
                           wechatCls:[WXApi class]];
    
}
- (void)dealloc
{
    [self.rootNvc release];
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //广告
    [YouMiConfig launchWithAppID:@"a056be90c288eae7" appSecret:@"dc5552d38d1cc16a"];

    
    
    [ShareSDK registerApp:@"91c0678912e"];//初始化ShareSDK的App
    [self initAllPlatforms];
    /*/网络监控/*/
     
     // 监测网络情况
     [[NSNotificationCenter defaultCenter] addObserver:self
     selector:@selector(reachabilityChanged:)
     name: kReachabilityChangedNotification
     object: nil];
     hostReach = [[Reachability reachabilityWithHostName:@"http://www.baidu.com"] retain];
     [hostReach startNotifier];

     
     
     
     
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    //给windows贴一个照片
//    UIImageView *bgImg = [[[UIImageView alloc] initWithFrame:self.window.bounds] autorelease];
//    bgImg.image = [UIImage imageNamed:@"windowBg.png"];
//    [bgImg setBackgroundColor:[UIColor greenColor]];
//    [self.window addSubview:bgImg];
    //增加标识，用于判断是否是第一次启动应用,以便显示引导画面
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    }
    //设定主视图控制器
    RootViewController * root = [[RootViewController alloc]init];
    self.rootNvc =[[UINavigationController alloc]initWithRootViewController:root];
    //建立左视图控制器
    LeftViewController * left = [[LeftViewController alloc]init];
    IIViewDeckController * IIviewController = [[IIViewDeckController alloc]initWithCenterViewController:_rootNvc leftViewController:left];
    //将抽屉添加到window上
    [IIviewController setRightSize:0];
    [IIviewController setPanningMode:IIViewDeckAllViewsPanning];
    [IIviewController setCenterhiddenInteractivity:IIViewDeckCenterHiddenNotUserInteractiveWithTapToClose];
    [self.window setRootViewController:IIviewController];
    //释放
    [left release];
    [IIviewController release];
    [_rootNvc release];
    [root release];
    [self.window makeKeyAndVisible];

    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        [WZGuideViewController show];
    }

    return YES;
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url wxDelegate:self];
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url sourceApplication:sourceApplication annotation:annotation wxDelegate:self];
}
#pragma mark--监控网络状态
- (void)reachabilityChanged:(NSNotification *)note {
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    if (status == NotReachable) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"幻方视频"
                                                        message:@"貌似断网了"
                                                       delegate:nil
                                              cancelButtonTitle:@"去看看" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
