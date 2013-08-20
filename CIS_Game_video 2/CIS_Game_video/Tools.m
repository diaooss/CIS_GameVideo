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
    [self labelMakeAnimation:notLabel];
    [view addSubview:notLabel];
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
@end
