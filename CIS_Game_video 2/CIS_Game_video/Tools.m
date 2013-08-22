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
#import <CommonCrypto/CommonDigest.h>
#define NavigationBGImage @"navbar.png"
#define NavigationBACKImage @"goBack.png"

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
    UILabel * notLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, -40, 320, 40)];
    [notLabel setText:@"网络貌似不给力了..."];
//    notLabel.alpha = 0.8;
    notLabel.textColor = [UIColor whiteColor];
    notLabel.backgroundColor = [UIColor lightGrayColor];
    [notLabel setTextAlignment:NSTextAlignmentCenter];
    [view addSubview:notLabel];
    [self labelMakeAnimation:notLabel];
    [notLabel release];
}
//加载一个动画
+(void)labelMakeAnimation:(UIView* )sender
{
    [UIView animateWithDuration:0.5 animations:^{
        [sender setCenter:CGPointMake(160, 20)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:3 animations:^{
            [sender setAlpha:0];
        } completion:^(BOOL finished) {
            nil;
        }];
    }];
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
+ (NSString *)md5:(NSString *)string
{
    if (string) {
        const char*cStr =[string UTF8String];
        unsigned char result[16];
        CC_MD5(cStr, strlen(cStr), result);
        return[NSString stringWithFormat:
               @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
               result[0], result[1], result[2], result[3],
               result[4], result[5], result[6], result[7],
               result[8], result[9], result[10], result[11],
               result[12], result[13], result[14], result[15]
               ];
        
    }
    return nil;
}
//公共的返回视图--导航条,不涉及抽屉,只是促使页面返回
+ (void)navigaionView:(UIViewController *)viewController leftImageName:(NSString *)imgName title:(NSString *)title
{
    viewController.navigationItem.title = title;
    [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:NavigationBGImage] forBarMetrics:UIBarMetricsDefault];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:NavigationBACKImage] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 40, 30)];
    viewController.navigationItem.title = title;
    [button addTarget:viewController action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithCustomView:button];
    [viewController.navigationItem setLeftBarButtonItem:bar];
    [bar release];
}
//便捷生成导航视图,不涉及抽屉.带右上角按钮
+ (void)navigaionView:(UIViewController *)viewController leftImageName:(NSString *)imgName rightImageName:(NSString *)rightImgName title:(NSString *)title
{
    viewController.navigationItem.title = title;
    [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:NavigationBGImage] forBarMetrics:UIBarMetricsDefault];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:NavigationBACKImage] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 40, 30)];
    viewController.navigationItem.title = title;
    [button addTarget:viewController action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithCustomView:button];
    [viewController.navigationItem setLeftBarButtonItem:bar];
    [bar release];
    //右上角按钮
    UIButton  *topRightCorenerBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    topRightCorenerBtn.frame = CGRectMake(280, 0, 40, 30);
    [topRightCorenerBtn addTarget:viewController action:@selector(topRightCorenerBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topRightCorenerBtn setBackgroundImage:[UIImage imageNamed:rightImgName] forState:UIControlStateNormal];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:topRightCorenerBtn];
    viewController.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];

}

//便捷生成导航视图,涉及抽屉,开拉抽屉.
+ (void)navigaionView:(UIViewController *)viewController deckVC:(id)deckViewController leftImageName:(NSString *)imgName title:(NSString *)title
{
    [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:NavigationBGImage] forBarMetrics:UIBarMetricsDefault];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 40, 30)];
    viewController.navigationItem.title = title;
    [button addTarget:deckViewController action:@selector(toggleLeftViewAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithCustomView:button];
    [viewController.navigationItem setLeftBarButtonItem:bar];
    [bar release];
}
//便捷生成导航视图,涉及抽屉.带右上角按钮
+ (void)navigaionView:(UIViewController *)viewController deckVC:(id)deckViewController leftImageName:(NSString *)imgName  rightImageName:(NSString *)rightImgName title:(NSString *)title
{
    [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:NavigationBGImage] forBarMetrics:UIBarMetricsDefault];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 40, 30)];
    viewController.navigationItem.title = title;
    [button addTarget:deckViewController action:@selector(toggleLeftViewAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithCustomView:button];
    [viewController.navigationItem setLeftBarButtonItem:bar];
    [bar release];
    //右上角按钮
    UIButton  *topRightCorenerBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    topRightCorenerBtn.frame = CGRectMake(280, 0, 40, 30);
    [topRightCorenerBtn addTarget:viewController action:@selector(topRightCorenerBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topRightCorenerBtn setBackgroundImage:[UIImage imageNamed:rightImgName] forState:UIControlStateNormal];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:topRightCorenerBtn];
    viewController.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
}
//便捷生成导航视图,涉及抽屉.无标题,带右上角按钮
+ (void)navigaionView:(UIViewController *)viewController deckVC:(id)deckViewController leftImageName:(NSString *)imgName  rightImageName:(NSString *)rightImgName
{
    [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:NavigationBGImage] forBarMetrics:UIBarMetricsDefault];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 40, 30)];
    [button addTarget:deckViewController action:@selector(toggleLeftViewAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithCustomView:button];
    [viewController.navigationItem setLeftBarButtonItem:bar];
    [bar release];
    //右上角按钮
    UIButton  *topRightCorenerBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    topRightCorenerBtn.frame = CGRectMake(280, 0, 40, 30);
    [topRightCorenerBtn addTarget:viewController action:@selector(topRightCorenerBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topRightCorenerBtn setBackgroundImage:[UIImage imageNamed:rightImgName] forState:UIControlStateNormal];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:topRightCorenerBtn];
    viewController.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
}
//便捷生成导航视图,涉及抽屉.不带标题
+ (void)navigaionView:(UIViewController *)viewController deckVC:(id)deckViewController leftImageName:(NSString *)imgName;
{
    [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar.png"] forBarMetrics:UIBarMetricsDefault];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 40, 30)];
    [button addTarget:deckViewController action:@selector(toggleLeftViewAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithCustomView:button];
    [viewController.navigationItem setLeftBarButtonItem:bar];
    [bar release];
}
+ (NSString *)calTimeMiss:(NSString *)dateString{
    NSDateFormatter * dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setTimeZone:[NSTimeZone defaultTimeZone]];
    [dateFormater setDateFormat:@"yyyyMMddhhmmss"];
    NSDate * createDate = [dateFormater dateFromString:dateString];
    NSString * strtime = @"1天前";
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:createDate];
    if (timeInterval <= 30) {
        strtime = @"刚刚";
    }else if (timeInterval > 60 && timeInterval < 60*60){
        NSString * strtime = [NSString stringWithFormat:@"%d%@",(int)timeInterval/60,@"分钟前"];
        return strtime;
    }else if (timeInterval >= 60*60 && timeInterval < 24*60*60){
        NSString * strtime = [NSString stringWithFormat:@"%d%@",(int)timeInterval/3600,@"小时前"];
        return strtime;
    }else {
        //        NSString * strtime = [NSString stringWithFormat:@"%d%@",(int)timeInterval/(60*60*24),@"天前"];
        strtime = @"N天前";
        return strtime;
    }
    return strtime;
}
@end
