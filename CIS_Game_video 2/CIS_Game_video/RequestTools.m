//
//  RequestTools.m
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-8-30.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import "RequestTools.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#define UESRID (@"email")
#define USERPASSWORD (@"psw")
#define CHECK_EMAIL @"http://121.199.57.44:88/webServer/EnabledEmail.ashx"//检测邮箱是否存在
#define REGISTER @"http://121.199.57.44:88/webServer/Register.ashx"//注册
#define LOGIN @"http://121.199.57.44:88/webServer/Login.ashx"//登陆
#define ATTENTION_AUTHOR @"http://121.199.57.44:88/webServer/CareAuthor.ashx"//关注作者
#define COLLECT_VIDOE @"http://121.199.57.44:88/webServer/FavoritesMovie.ashx"//收藏视频
#define SIGN_IN @"http://121.199.57.44:88/webServer/Signin.ashx"//签到
#define USER_INFOR @"http//121.199.57.44:88/webServer/GetUserInfoSample.ashx"//用户信息
#define AUTHOR_LIST @"http://121.199.57.44:88/webServer/GetAuthorlist.ashx"//作者列表
#define VIDOE_LIST @"http://121.199.57.44:88/webServer/GetMovielist.ashx"//视频列表
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)



@implementation RequestTools
- (void)dealloc
{
    [httpRequest setDelegate:nil];
    httpRequest = nil;
    _getDic = nil;
    [super dealloc];
}
-(NSString *)changStringForUTF:(NSString *)oldString
{
    return [[NSString stringWithString:oldString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
-(void )requestWithUrl:(NSString *)urlStr;
{
    httpRequest = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlStr]];
    [httpRequest setDelegate:self];
    httpRequest.requestMethod = @"GET";
    httpRequest.timeOutSeconds = 5.0;
    [httpRequest startAsynchronous];
}
//得到用户信息
-(void)getUserInformation
{
    NSString * requestStr = [USER_INFOR stringByAppendingString:[NSString stringWithFormat:@"?email=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_email"]]];
    [self requestWithUrl:[self changStringForUTF:requestStr]];
}
//每次20条作者信息
-(void)getAuthorInforWithCategory:(NSString *)category withPage:(int )page
{
    NSString * requestStr = [AUTHOR_LIST stringByAppendingString:[NSString stringWithFormat:@"?email=%@&category=%@&isCarelist=%d&dataPage=%d",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_email"],category,0,page]];
    [self requestWithUrl:[self changStringForUTF:requestStr]];
}
//每次20条视频信息
-(void)getVidoeInforWithCategory:(NSString *)category authorName:(NSString *)authorName withPage:(int )page
{
    NSString * requestStr = [VIDOE_LIST stringByAppendingString:[NSString stringWithFormat:@"?email=%@&category=%@&isCarelist=%d&dataPage=%d&author=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_email"],category,0,page,authorName]];
    [self requestWithUrl:[self changStringForUTF:requestStr]];
}

#pragma mark /*****  类方法直接判断状态    *****/
//
+(NSString *)isRequestSuccess:(NSString *)str
{
    ASIHTTPRequest*Request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [Request setRequestMethod:@"GET"];
    Request.timeOutSeconds = 5.0;
    [Request startSynchronous];
    if([[[Request.responseData objectFromJSONData] valueForKey:@"status"]isEqualToString:@"ok"])
    {
        return @"成功";
    }
    return @"失败";
}
//UTF-8转换
+(NSString *)changStringForUTF:(NSString *)oldString
{
    return [[NSString stringWithString:oldString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

//检测邮箱是否存在
+(NSString *)checkEmail:(NSString *)email
{
    NSString * requestStr = [CHECK_EMAIL stringByAppendingString:[NSString stringWithFormat:@"?email=%@",email]];
    //NSLog(@"%@",[self isRequestSuccess:[self changStringForUTF:requestStr]]);
    return [self isRequestSuccess:[self changStringForUTF:requestStr]];
}
//注册是否成功
+(NSString *)registerWithUserName:(NSString *)userName withEamil:(NSString *)email andPassWord:(NSString *)passWord
{
    NSString * requestStr = [REGISTER stringByAppendingString:[NSString stringWithFormat:@"?user_Name=%@&email=%@&psw=%@",userName,email,passWord]];
    return [self isRequestSuccess:[self changStringForUTF:requestStr]];
}
//登陆是否成功
+ (NSString *)loginWithEamil:(NSString *)email andPassWord:(NSString *)passWord
{
    NSString * requestStr = [LOGIN stringByAppendingString:[NSString stringWithFormat:@"?email=%@&psw=%@",email,passWord]];
    return [self isRequestSuccess:[self changStringForUTF:requestStr]];
}
//关注木一个作者---返回是否关注成功
+(NSString *)attentionOneAuthorWith:(NSString *)authorName ByUserEmaiil:(NSString *)userEmail
{
    NSString * requestStr = [ATTENTION_AUTHOR stringByAppendingString:[NSString stringWithFormat:@"?email=%@&authName=%@",userEmail,authorName]];
    return [self isRequestSuccess:[self changStringForUTF:requestStr]];
}
//收藏视频
+(NSString *)collectOneVidoe:(NSString *)moveID ByUser:(NSString*)userMeail;
{
    NSString * requestStr = [COLLECT_VIDOE stringByAppendingString:[NSString stringWithFormat:@"?email=%@&movieID=%@",userMeail,moveID]];
    return [self isRequestSuccess:[self changStringForUTF:requestStr]];
}
//签到--返回签到是否成功
+(NSString *)isSignIn:(NSString*)userMeail
{
    NSString * requestStr = [CHECK_EMAIL stringByAppendingString:[NSString stringWithFormat:@"?email=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_email"]]];//需要确定user_email
    return [self isRequestSuccess:[self changStringForUTF:requestStr]];
}



//接收成功
- (void)requestFinished:(ASIHTTPRequest *)request
{
    //接收到数据
    
    _getDic = (NSDictionary *)[request.responseData objectFromJSONData];
    //回调代理
    if (self.delegate&&[self.delegate respondsToSelector:@selector(backOneDic:)]) {
        [self.delegate backOneDic:_getDic];
    }
    NSLog(@"%@----------------------",_getDic);
}
-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"----------%@",request.responseString);
}
@end
