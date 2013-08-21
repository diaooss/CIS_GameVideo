//
//  Tools.m
//  NetTest
//
//  Created by huangfangwang on 13-8-19.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "Tools.h"
#import "Reachability.h"
#import "MBProgressHUD.h"
@implementation Tools
+(BOOL)isHaveNet
{
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    if ([reach currentReachabilityStatus]==NotReachable) {
        return NO;
    }
    return YES;
}
+(NSString *)currentNetState
{
    if (![self isHaveNet]) {
        return @"没有网噢噢噢噢---";
    }
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    if ([reach currentReachabilityStatus]==ReachableViaWiFi) {
        return @"WiFi";
    }
    return @"3G";
}
/*****************************/
+(void)addNotlabel:(UIView *)view
{
    UILabel * notLabel = [[UILabel alloc]initWithFrame:CGRectMake(-320, 50, 320, 40)];
    [notLabel setText:@"现在木有网---有木有"];
    [view addSubview:notLabel];

    [self labelMakeAnimation:notLabel];
    [notLabel release];
}
//加载一个动画
+(void)labelMakeAnimation:(UIView* )sender
{
    [UIView beginAnimations:nil context:nil];
    [sender setCenter:CGPointMake(160, 20)];
    [UIView animateWithDuration:2 delay:2 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
        [sender setCenter:CGPointMake(160, 20)];
    } completion:^(BOOL finished) {
        [sender setAlpha:0];
    }];
    [UIView commitAnimations];
}
//*****邮箱检测
+(BOOL)cheeckEmail: (NSString *) userEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:userEmail];
}
//***风火轮
+ (void)openLoadsign:(UIView* )view
{
    MBProgressHUD * hud =[MBProgressHUD showHUDAddedTo:view animated:YES];
    [hud setMode:MBProgressHUDModeIndeterminate];
    [hud setDetailsLabelText:@"正在努力加载......"];
}
+ (void)closeLoadsign:(UIView* )view
{
    [MBProgressHUD hideHUDForView:view animated:YES];
}
//***用户是否注册登陆
+(BOOL)isHaveLogin
{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    if ([user valueForKeyPath:@"user_name"]) {
        return YES;
    }
    return NO;
}
//发起评价
+(void)giveAppraiseForOurApp
{
    NSString *url = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d",626186545];//评论
    NSString *url2 = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=626186545"];//详情
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
//获得硬件信息
+(NSDictionary *)getMobileInfo;
{
    
    UIDevice *device_=[[UIDevice alloc] init];
    NSLog(@"设备所有者的名称－－%@",device_.name);
    NSString *userName = [NSString stringWithFormat:@"这是%@的手机,是爱疯4",device_.name];
    
    NSLog(@"设备的类别－－－－－%@",device_.model);
    NSString *vStr = [NSString stringWithFormat:@"手机是%@",device_.model];
    NSLog(@"设备的的本地化版本－%@",device_.localizedModel);
    NSLog(@"设备运行的系统－－－%@",device_.systemName);
    NSString *osStr = [NSString stringWithFormat:@"运行%@OS,版本号是:%@",device_.localizedModel,device_.systemVersion];
    NSLog(@"当前系统的版本－－－%@",device_.systemVersion);
    int a = [device_.systemVersion intValue];
    NSLog(@"ios%d版本",a);//
    
    NSLog(@"设备识别码－－－－－%@",device_.identifierForVendor.UUIDString);
    //得到设备屏幕高度,判断是爱疯5或以下.
    float screenHeight=[UIScreen mainScreen].bounds.size.height;
    NSLog(@"%f",screenHeight);
    return nil;
}
//获得当前版本号
+(NSString *)getNowAppVersions
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];

    
}


@end
