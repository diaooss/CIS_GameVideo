//
//  MyNsstringTools.h
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-9-3.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyNsstringTools : NSObject
//MD5加密,返回加密后的字符串
+ (NSString *)md5:(NSString *)string;
//字符串utf8转码,返回转码后的字符串
+(NSString *)changeStrWithUT8:(NSString *)oldStr;
//把扔进来的一堆字符串拼接,返回一个字符串,
+(NSString *)groupStrByAStrArray:(NSArray *)strArry;
//扔进来一个任意类型的对象,布尔,int string返回一个字符串
+(NSString *)makeNewStrByAnyObj:(id)object;
@end
