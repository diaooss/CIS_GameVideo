//
//  MyNsstringTools.m
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-9-3.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import "MyNsstringTools.h"
#import <CommonCrypto/CommonDigest.h>

@implementation MyNsstringTools
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
//UTF-8转换
+(NSString *)changeStrWithUT8:(NSString *)oldStr
{
    return [[NSString stringWithString:oldStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding还原字符串

}
//把扔进来的一堆字符串拼接,返回一个字符串,
+(NSString *)groupStrByAStrArray:(NSArray *)strArry
{
    NSString *tempStr = [NSString string];
    for ( int i= 0; i<[strArry count]; i++) {
        tempStr = [tempStr stringByAppendingString:[strArry objectAtIndex:i]];
    }
    return tempStr;
}

//扔进来一个任意类型的对象,布尔,int string返回一个字符串
+(NSString *)makeNewStrByAnyObj:(id)object;
{
    NSString *str = [NSString stringWithFormat:@"%@",object];
    return str;
}

@end
