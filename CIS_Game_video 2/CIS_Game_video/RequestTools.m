//
//  RequestTools.m
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-8-30.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import "RequestTools.h"
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"
#import "JSONKit.h"
#import "MyNsstringTools.h"
#define UESRID (@"email")
#define USERPASSWORD (@"psw")

@implementation RequestTools
- (void)dealloc
{
    [httpRequest setDelegate:nil];
    httpRequest = nil;
    resultDic = nil;
    [super dealloc];
}
//根据字符串,发起异步请求
-(void )requestWithUrl_Asynchronous:(NSString *)urlStr
{
    httpRequest = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[MyNsstringTools changeStrWithUT8:urlStr]]];
    [httpRequest setDelegate:self];
    httpRequest.requestMethod = @"GET";
    httpRequest.timeOutSeconds = 5.0;
    [httpRequest startAsynchronous];
}
//根据字符串,发起同步请求
-(void )requestWithUrl_Synchronous:(NSString *)urlStr
{
    httpRequest = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[MyNsstringTools changeStrWithUT8:urlStr]]];
    [httpRequest setDelegate:self];
    httpRequest.requestMethod = @"GET";
    httpRequest.timeOutSeconds = 5.0;
    [httpRequest startSynchronous];
}
//头像上传
+(NSDictionary *)postHeaderImageToServerWitImage:(UIImage *)postImage requestStr:(NSString *)str
{
    NSData *imgData = UIImageJPEGRepresentation(postImage, 1.0);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[MyNsstringTools changeStrWithUT8:str]]];
    [request setPostBody:[NSMutableData dataWithData:imgData]];
    [request buildRequestHeaders];
    request.delegate = self;
    NSLog(@"header: %@", request.requestHeaders);
    [request addRequestHeader:@"Content-Type"value:@"text/plain"];
    [request startSynchronous];
    return [[request.responseData objectFromJSONData] valueForKey:@"status"];


    
}
//反馈信息上传
-(void)postFeedBackInfoWithUrlStr:(NSString *)urlStr infoDic:(NSDictionary *)dic
{
    NSString *s =  [dic JSONString];
    NSData *data = [s dataUsingEncoding:NSUTF8StringEncoding];

    httpRequest = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[urlStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [httpRequest setDelegate:self];
    httpRequest.requestMethod = @"POST";
    httpRequest.timeOutSeconds = 5.0;
    [httpRequest setPostBody:[NSData dataWithData:data]];
    [httpRequest startSynchronous];

    
}
////版本检测
//-(void)versionsCheck;

//类方法--根据请求返回的状态值,返回布尔值,以供判断
+(BOOL)requestReturnYesOrOkWithCheckUrl_Asynchronous:(NSString *)checkUrl//异步
{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[MyNsstringTools changeStrWithUT8:checkUrl]]];
    [request setRequestMethod:@"GET"];
    request.timeOutSeconds = 5.0;
    request.delegate  =self;
    [request startAsynchronous];
    if([[[request.responseData objectFromJSONData] valueForKey:@"status"]isEqualToString:@"ok"])
    {
        return YES;
    }
    return NO;
}
+(BOOL)requestReturnYesOrOkWithCheckUrl_Synchronous:(NSString *)checkUrl//同步
{
    NSLog(@"请求的串是:%@",checkUrl);
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[MyNsstringTools changeStrWithUT8:checkUrl]]];
    [request setRequestMethod:@"GET"];
    request.timeOutSeconds = 5.0;
    [request startSynchronous];//默认是同步请求
    if([[[request.responseData objectFromJSONData] valueForKey:@"status"]isEqualToString:@"ok"])
    {
        return YES;
    }
    return NO;
}
#pragma mark--ASI的请求代理方法
-(void)requestStarted:(ASIHTTPRequest *)request
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    resultDic = (NSDictionary *)[request.responseData objectFromJSONData];
    //回调代理
    if (self.delegate&&[self.delegate respondsToSelector:@selector(requestSuccessWithResultDictionary:)]) {
        [self.delegate requestSuccessWithResultDictionary:resultDic];
    }
}
#pragma mark--ASI的代理方法
-(void)requestFailed:(ASIHTTPRequest *)request
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    //回调代理
    resultDic = (NSDictionary *)[request.responseData objectFromJSONData];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(requestFailedWithResultDictionary:)]) {
        [self.delegate requestFailedWithResultDictionary:resultDic];
    }
    NSLog(@"requestFailed:%@",request.responseString);
}
@end
