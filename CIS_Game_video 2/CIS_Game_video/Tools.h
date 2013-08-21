//
//  Tools.h
//  NetTest
//
//  Created by huangfangwang on 13-8-19.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject
//网络监测************
+(BOOL)isHaveNet;//判断是不是有网
+(void)addNotlabel:(UIView *)view;//没网时加载提醒
+(NSString * )currentNetState;//有网时当前的网络类型
//*****风火轮---
+ (void)openLoadsign:(UIView* )view;//创建
+ (void)closeLoadsign:(UIView* )view;//关闭
//********检测邮箱格式
+(BOOL)cheeckEmail: (NSString *) userEmail;
//*****判断是不是登陆过
+(BOOL)isHaveLogin;
//评价
+(void)giveAppraiseForOurApp;
//获得硬件信息
+(NSDictionary *)getMobileInfo;
//获得当前APP的版本号
+(NSString *)getNowAppVersions;
//获得当前应用在APP商店中地址
+(NSURL *)getTheAPPUrlInStore;

@end
