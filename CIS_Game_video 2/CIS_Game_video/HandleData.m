//
//  HandleData.m
//  000000000
//
//  Created by wangxitan on 13-4-19.
//  Copyright (c) 2013年 wangxitan. All rights reserved.
//

#import "HandleData.h"
#import "DataBase.h"
#import "Video.h"
@implementation HandleData
/*
 pic_url,price,promotion_price,nick,click_url,item_location,title,volume
 */
+(NSMutableArray*)allVideosInformation
{
    NSMutableArray * allArry = [[NSMutableArray alloc]initWithCapacity:1];
    sqlite3 * db = [DataBase openDB];
    sqlite3_stmt * stmt = nil;
    int flag = sqlite3_prepare_v2(db, "select * from huanfang", -1, &stmt, nil);
     NSLog(@"看看你是几---%d",flag);
    if (flag == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            int ID = sqlite3_column_int(stmt, 0);
            const unsigned char *CvideoName = sqlite3_column_text(stmt, 1);
            const unsigned char *CvideoPicture = sqlite3_column_text(stmt, 2);
            const unsigned char *CvideoID = sqlite3_column_text(stmt, 3);
            const unsigned char *CvideoAuthor = sqlite3_column_text(stmt, 4);
            const unsigned char *CvideoTime = sqlite3_column_text(stmt, 5);
            const unsigned char *CvideoPopular = sqlite3_column_text(stmt, 6);
            Video * video = [[Video alloc]initWithID:ID
                                           videoName:[NSString stringWithUTF8String:(const char * )CvideoName]
                                        videoPicture:[NSString stringWithUTF8String:(const char * )CvideoPicture]
                                             videoID:[NSString stringWithUTF8String:(const char * )CvideoID]
                                         videoAuthor:[NSString stringWithUTF8String:(const char * )CvideoAuthor]
                                           videoTime:[NSString stringWithUTF8String:(const char * )CvideoTime]
                                        videoPopular:[NSString stringWithUTF8String:(const char * )CvideoPopular]];
            [allArry addObject:video];
            [video release];
        }
    }
    sqlite3_finalize(stmt);
    NSLog(@"----------内部%d",[allArry count]);
    return [allArry autorelease];
}
+(void)insertOneVideo:(Video *)goods
{
    sqlite3 * db = [DataBase openDB];
    sqlite3_stmt * stmt = nil;
    int flag = sqlite3_prepare_v2(db, "insert into huanfang(videoName,videoPicture,videoID,videoAuthor,videoTime,videoPopular) values(?,?,?,?,?,?)", -1, &stmt, nil);
    NSLog(@"看看你是几---%d",flag);
    if (flag==SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [goods.videoName UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 2, [goods.videoPicture UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 3, [goods.videoID UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 4, [goods.videoAuthor UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 5, [goods.videoTime UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 6, [goods.videoPopular UTF8String], -1, nil);
        sqlite3_step(stmt);
        sqlite3_finalize(stmt);
    }
}
+(void)deleteOneVideo:(Video *)goods
{
    //干掉图片
    
    //
    sqlite3 * db = [DataBase openDB];
    sqlite3_stmt * stmt = nil;
    NSString * str = [NSString stringWithFormat:@"delete from huanfang where ID=%d",goods.ID];
    int flag =sqlite3_prepare_v2(db, [str UTF8String], -1, &stmt, nil);
    if (flag==SQLITE_OK) {
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
}
+(void)deleteAllVideo
{
    sqlite3 * db = [DataBase openDB];
    sqlite3_stmt * stmt = nil;
    int flag = sqlite3_prepare_v2(db, "delete * from huanfang", -1, &stmt, nil);
    if (flag==SQLITE_OK) {
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
}
@end
