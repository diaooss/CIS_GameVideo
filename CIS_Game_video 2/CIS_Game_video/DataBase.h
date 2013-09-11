//
//  DataBase.h
//  LessonSqlite
//
//  Created by cyy on 13-3-15.
//  Copyright (c) 2013年 LanOuKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface DataBase : NSObject

+ (sqlite3 *)openDB;
+ (void)closeDB;

@end
