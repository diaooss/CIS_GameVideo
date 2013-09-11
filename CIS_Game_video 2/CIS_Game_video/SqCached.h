//
//  SqCached.h
//  CacheTest
//
//  Created by mac on 8/28/13.
//  Copyright (c) 2013 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface SqCached : NSObject
{
    sqlite3 * _database;
    BOOL      _logEnabled;      //控制日志输出，defalut = YES
    BOOL      _logFaildEnabled;
    BOOL      _openDBSuccess;   
}

/**
 * @return      存储对象的单例
 */
+ (id)shareCache;



/**  增
 * 以 sql 语句为 replace - 若key，不存在，为增 - 若key，存在，为改 
 
 * @param data  OC基本数据局类型
 * @param key   数据存储的标示
 
 * @return      存储是否成功
 */
- (BOOL)setCacheData:(id)data ForKey:(NSString *)key;


/**  查
 * 以 select 语句 - 查找数据 - - 若不存在，返回 nil
 
 * @param key   存储的标示
 
 * @return      返回存储数据 
 */
- (id)cacheDataForKey:(NSString *)key;

/**  删
 * 以 delete 语句 - 删除数据 --
 
 * @param key   存储的表示 -
 
 * @return      删除是否成功
 */
- (BOOL)deleteDataForKey:(NSString *)key;


/**
 * 删除数据库中所有数据
 */
- (void)removeAllData;

/**
 * @param enabled           正常日志输出  -- default is YES
 * @param faildEnabled      错误日志输出  -- default is YES
 */
- (void)setLogEnabled:(BOOL)enabled andFaildLogEnabled:(BOOL)faildEnabled;

@end
