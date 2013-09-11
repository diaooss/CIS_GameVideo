//
//  DataBase.m
//  LessonSqlite
//
//  Created by cyy on 13-3-15.
//  Copyright (c) 2013年 LanOuKeJi. All rights reserved.
//

#import "DataBase.h"

#define DBNAME @"HUANFANG.sqlite"

@implementation DataBase
static sqlite3 *db = nil;

+ (sqlite3 *)openDB
{
    if(db == nil)
    {
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *dataBaseDestinationPath = [documentPath stringByAppendingPathComponent:DBNAME];
        //NSLog(@" %@",dataBaseDestinationPath);//Documents中数据库路径
        
        NSFileManager *fm = [NSFileManager defaultManager];
        if([fm fileExistsAtPath:dataBaseDestinationPath] == NO)
        {
            //bundle中数据库路径
            NSString *dataBaseOriginPath = [[NSBundle mainBundle] pathForResource:DBNAME ofType:nil];
            NSError *err = nil;
            [fm copyItemAtPath:dataBaseOriginPath toPath:dataBaseDestinationPath error:&err];
            if(err != nil)//如果拷贝过程中出现错误 打印错误信息 并返回nil
            {
               // NSLog(@"%@",[err localizedDescription]);
                return nil;
            }
        }
        sqlite3_open([dataBaseDestinationPath UTF8String], &db);
    }
    return db;
}

+ (void)closeDB
{
    sqlite3_close(db);
}

@end
