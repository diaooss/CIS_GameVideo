//
//  SqCached.m
//  CacheTest
//
//  Created by mac on 8/28/13.
//  Copyright (c) 2013 mac. All rights reserved.
//

#import "SqCached.h"
#import "JSONKit.h"

#define dbPath @"cache.db"
#define dbTable @"cacheTable"


@implementation SqCached


+ (id)shareCache
{
    static SqCached * cache = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[SqCached alloc] init];
    });
    
    return cache;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        [self setInfo];
        [self createTable];
    }
    
    return self;
}

- (void)setInfo
{
    _logFaildEnabled = YES;
    _logEnabled = YES;
    [self openTable];
}

- (BOOL)setCacheData:(id)data ForKey:(NSString *)key
{
    if (!_openDBSuccess) {
        [self logWithFaild:@"set cache faild"];
        return NO;
    }
    
    NSArray * type = @[@"__NSCFNumber",
                       @"__NSCFString",
                       @"__NSDictionaryI",
                       @"__NSDictionaryM",
                       @"__NSArrayI",
                       @"__NSArrayM",
                       @"NSConcreteData",
                       @"NSConcreteMutableData"];
    
    NSString * dataType = [NSString stringWithUTF8String:object_getClassName(data)];
    
    __block BOOL  isId ;
    
    [type enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if ([dataType isEqualToString:obj]) {
            
            isId = YES;
            *stop = YES;
        }else{
            
            isId = NO;
        }
    }];
    
    if (!isId) {
        
        [self logWithFaild:[NSString stringWithFormat:@"set data is faild , type == %@",dataType]];
        return NO;
    }
    
    BOOL setSuccess = NO;
    
    NSString * sql = [NSString stringWithFormat:@"replace into %@ (key,data) values (?, ?)",dbTable];
    
    sqlite3_stmt * stmt = [self prepareStatementForSql:sql];
    
    NSString * json = nil;
    NSData * jsonData = nil;
    
    if (stmt) {
        sqlite3_bind_text(stmt,
                          1,
                          key.UTF8String,
                          strlen(key.UTF8String),
                          nil);
        
        if ([data isKindOfClass:[NSData class]] ||
            [data isKindOfClass:[NSMutableData class]]) {
            
            jsonData = data;
        }else
            if ([data isKindOfClass:[NSString class]] ||
                [data isKindOfClass:[NSMutableString class]]) {
                
                jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
            }else {
                
                if ([data isKindOfClass:[NSNumber class]]) {
                    
                    json = [data stringValue];
                }else{
                    
                    json = [data JSONString];
                }
                
                if (json) {
                    
                    jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
                }else{
                    
                    jsonData = [data JSONData];
                }
            }

        
        sqlite3_bind_blob(stmt,
                          2,
                          jsonData.bytes,
                          jsonData.length,
                          nil);
        
        if (sqlite3_step(stmt) == SQLITE_DONE) {
            
            [self log:[NSString stringWithFormat:@"set cache success , key == %@",key]];
            setSuccess = YES;
        }else{
            
            [self logWithFaild:[NSString stringWithFormat:@"set cache faild , key == %@",key]];
            setSuccess = NO;
        }
        
        sqlite3_finalize(stmt);
    }
    return setSuccess;
}

- (id)cacheDataForKey:(NSString *)key{
    
    if (!_openDBSuccess) {
        [self logWithFaild:@"set cache faild"];
        return nil;
    }
    
    id result = nil;
    
    NSString * sql = [NSString stringWithFormat:@"select data from %@ where key = ?",dbTable];
    
    sqlite3_stmt * stmt = [self prepareStatementForSql:sql];
    
    if (stmt) {
        
        sqlite3_bind_text(stmt,
                          1,
                          key.UTF8String,
                          strlen(key.UTF8String),
                          nil);
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {

            const char * data = sqlite3_column_blob(stmt, 0);
            int data_size = sqlite3_column_bytes(stmt, 0);
            
            NSData * objData = [NSData dataWithBytes:data
                                              length:data_size];
            
            NSString * json = [[NSString alloc] initWithData:objData
                                                    encoding:NSUTF8StringEncoding];
            
            if (json) {
                
                id value = nil;
                
                result = json;  // 字符串
                
                if (result) {
                    
                    value = [json objectFromJSONString]; // 字典或者数组
                    
                    if (value) {
                        
                        result = value;
                        
                    }
                }
                
                
                NSNumberFormatter * formatter = [NSNumberFormatter new];
                
                value = [formatter numberFromString:json];
                
                if (value) {
                    
                    result = value;     //NSNumber
                }
            }else{
                
                result = objData;
            }
            
            sqlite3_finalize(stmt);
        }
    }
    
    if (result == nil) {
        
        [self logWithFaild:[NSString stringWithFormat:@"select value == nil , key == %@",key]];
    }
    
    return result;
}

- (BOOL)deleteDataForKey:(NSString *)key
{
    NSString * sql = [NSString stringWithFormat:@"delete from %@ where key = ?",dbTable];
    
    BOOL isDelete = NO;
    
    sqlite3_stmt * stmt = [self prepareStatementForSql:sql];
    
    if (stmt) {
        
        sqlite3_bind_text(stmt,
                          1,
                          key.UTF8String,
                          strlen(key.UTF8String),
                          nil);
        
        if (sqlite3_step(stmt) == SQLITE_DONE) {
            
            [self log:[NSString stringWithFormat:@"delete data success where key == %@",key]];
            isDelete = YES;
        }else{
            
            [self logWithFaild:[NSString stringWithFormat:@"delete data faild where key == %@",key]];
            isDelete = NO;
        }
    }
    return isDelete;
}

- (void)removeAllData
{
    NSString * sql = [NSString stringWithFormat:@"delete from %@",dbTable];
    
    sqlite3_stmt * stmt = [self prepareStatementForSql:sql];
    
    if (stmt) {

        if (sqlite3_step(stmt) == SQLITE_DONE) {
            
            [self log:@"delete all data success"];
        }else{
            
            [self logWithFaild:@"delete all data faild"];
        }
    }
}

#pragma mark  ----------

- (void)createTable
{
    NSString * sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (key TEXT PRIMARY KEY, data BLOB)",dbTable];
    
    sqlite3_stmt * stmt = [self prepareStatementForSql:sql];
    
    if (stmt) {
        if (sqlite3_step(stmt) == SQLITE_DONE) {
            [self log:@"create table success"];
        }else{
            [self logWithFaild:@"create talbe faild"];
        }
    }
    
    sqlite3_finalize(stmt);
}

- (void)openTable
{
    if (sqlite3_open([self cachePath].fileSystemRepresentation, &_database) == SQLITE_OK) {
        [self log:(@"open db success")];
        _openDBSuccess = YES;
    }else{
        [self logWithFaild:(@"open db faild")];
        _openDBSuccess = NO;
    }
}

- (NSString *)cachePath
{
    NSString * path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
                       stringByAppendingPathComponent:dbPath];
    NSLog(@"path == %@",path);
    return path;
}
#pragma mark  -------- prepare ------

- (sqlite3_stmt *)prepareStatementForSql:(NSString *)sql
{
    sqlite3_stmt * stmt = nil;
    
    if (sqlite3_prepare_v2(_database,
                           sql.UTF8String,
                           -1,
                           &stmt,
                           NULL) == SQLITE_OK) {
        [self log:[NSString stringWithFormat:@"prepare sql success , sql == %@",sql]];
        return stmt;
    }else{
        [self logWithFaild:[NSString stringWithFormat:@"prepare sql faild , sql == %@",sql]];
        return nil;
    }
}



#pragma mark  -------- log  ---------

- (void)setLogEnabled:(BOOL)enabled andFaildLogEnabled:(BOOL)faildEnabled
{
    _logEnabled = enabled;
    _logFaildEnabled = enabled;
}

- (void)log:(NSString *)log
{
    if (_logEnabled) {
        NSLog(@"cache - : %@",log);
    }
}

- (void)logWithFaild:(NSString *)log
{
    if (_logFaildEnabled) {
        NSLog(@"cache - faild : %@",log);
    }
}

@end
