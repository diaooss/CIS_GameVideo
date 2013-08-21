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
@implementation AppDelegate

- (void)dealloc
{
    [self.rootNvc release];
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
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
    IIviewController.bounceOpenSideDurationFactor = 1.0;
    IIviewController.openSlideAnimationDuration = 0.5;
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
