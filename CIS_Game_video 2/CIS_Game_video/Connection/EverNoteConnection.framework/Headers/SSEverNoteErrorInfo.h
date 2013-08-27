//
//  SSEverNoteErrorInfo.h
//  EverNoteConnection
//
//  Created by vimfung on 13-5-7.
//  Copyright (c) 2013年 vimfung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AGCommon/CMErrorInfo.h>
#import "ISSEverNoteDataOutput.h"

@interface SSEverNoteErrorInfo : CMErrorInfo
{
@private
    NSString *_identifier;
    NSString *_key;
}

@property (nonatomic,copy) NSString *identifier;

@property (nonatomic,copy) NSString *key;

/**
 *	@brief	创建应用错误信息
 *
 *	@param 	reader 	数据读取器
 *
 *	@return	错误信息
 */
+ (SSEverNoteErrorInfo *)applicationErrorWithReader:(id<ISSEverNoteDataOutput>)reader;

/**
 *	@brief	创建用户错误信息
 *
 *	@param 	reader 	数据读取器
 *
 *	@return	错误信息
 */
+ (SSEverNoteErrorInfo *)userErrorWithReader:(id<ISSEverNoteDataOutput>)reader;

/**
 *	@brief	创建系统错误信息
 *
 *	@param 	reader 	数据读取器
 *
 *	@return	错误信息
 */
+ (SSEverNoteErrorInfo *)systemErrorWithReader:(id<ISSEverNoteDataOutput>)reader;

/**
 *	@brief	创建未找到错误信息
 *
 *	@param 	reader 	数据读取器
 *
 *	@return	错误信息
 */
+ (SSEverNoteErrorInfo *)notFoundErrorWithReader:(id<ISSEverNoteDataOutput>)reader;

@end
