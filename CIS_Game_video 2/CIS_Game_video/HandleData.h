//
//  HandleData.h
//  000000000
//
//  Created by wangxitan on 13-4-19.
//  Copyright (c) 2013年 wangxitan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Video;
@interface HandleData : NSObject
+(NSMutableArray*)allVideosInformation;
+(void)insertOneGoods:(Video *)goods;
+(void)deleteOneGoods:(Video *)goods;
+(void)deleteAllGoods;
@end
