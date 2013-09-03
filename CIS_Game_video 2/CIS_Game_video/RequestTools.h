//
//  RequestTools.h
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-8-30.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@protocol myHttpRequestDelegate;
@interface RequestTools : NSObject<ASIHTTPRequestDelegate>
{
    ASIHTTPRequest * httpRequest;//请求的执行者
    NSURL *requestUrl;
    NSDictionary * resultDic;//请求后的解析后的结果字典
}
@property(nonatomic,assign)id<myHttpRequestDelegate>delegate;//设置代理
//根据字符串,发起异步请求
-(void )requestWithUrl_Asynchronous:(NSString *)urlStr;
//根据字符串,发起同步请求
-(void )requestWithUrl_Synchronous:(NSString *)urlStr;
//类方法--根据请求返回的状态值,返回布尔值,以供判断
+(BOOL)requestReturnYesOrOkWithCheckUrl_Asynchronous:(NSString *)checkUrl;//异步
+(BOOL)requestReturnYesOrOkWithCheckUrl_Synchronous:(NSString *)checkUrl;//同步
@end
//定义请求工具的代理,以便进行监控和值回传
@protocol myHttpRequestDelegate <NSObject>
@optional
//请求成功
-(void)requestSuccessWithResultDictionary:(NSDictionary* )dic;
//请求失败
-(void)requestFailedWithResultDictionary:(NSDictionary* )dic;

@end
