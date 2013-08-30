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
    NSData *finalData;
    NSDictionary * _getDic;

}
@property(nonatomic,assign)id<myHttpRequestDelegate>delegate;
//获取用户信息
-(void)getUserInformation;
//获取作者信息****每次20*****第几个请求
-(void)getAuthorInforWithCategory:(NSString *)category withPage:(int )page;
//获取视频信息
-(void)getVidoeInforWithCategory:(NSString *)category authorName:(NSString *)authorName withPage:(int )page;


//************************************************************
/*检测账号是否注册过----
 YES-可以注册***NO-不可以注册或者已经存在---
 */
+ (NSString *) checkEmail:(NSString *)email;
/*注册----
 YES-注册成功***NO-注册失败---
 */
+ (NSString *) registerWithUserName:(NSString *)userName withEamil:(NSString *)email andPassWord:(NSString *)passWord;
/*登陆----
 YES-登陆成功***NO-登陆失败---
 */
+ (NSString*) loginWithEamil:(NSString *)email andPassWord:(NSString *)passWord;
//关注一个作者...返回关注是否成功
+(NSString *)attentionOneAuthorWith:(NSString *)authorName ByUserEmaiil:(NSString*)userEmail;
//收藏视频.....返回收藏是否成功
+(NSString *)collectOneVidoe:(NSString *)moveID ByUser:(NSString*)userMeail;
//签到
+(NSString *)isSignIn:(NSString*)userMeail;
@end

//代理
@protocol myHttpRequestDelegate <NSObject>
@optional
-(void)backOneDic:(NSDictionary* )dic;
@end
