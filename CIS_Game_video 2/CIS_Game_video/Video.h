//
//  Video.h
//  AnsirPro
//
//  Created by huangfangwang on 13-9-11.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Video : NSObject
@property (nonatomic,assign)int ID;
@property (nonatomic,copy)NSString * videoName;
@property (nonatomic,copy)NSString * videoPicture;
@property (nonatomic,copy)NSString * videoID;
@property (nonatomic,copy)NSString * videoAuthor;
@property (nonatomic,copy)NSString * videoTime;
@property (nonatomic,copy)NSString * videoPopular;
-(id)initWithID:(int)ID
      videoName:(NSString *)videoName
   videoPicture:(NSString *)videoPicture
        videoID:(NSString *)videoID
    videoAuthor:(NSString *)videoAuthor
      videoTime:(NSString *)videoTime
   videoPopular:(NSString *)videoPopular;

- (id)initWithID:(int)ID;

-(id)initWithVideoName:(NSString *)videoName
          videoPicture:(NSString *)videoPicture
               videoID:(NSString *)videoID
           videoAuthor:(NSString *)videoAuthor
             videoTime:(NSString *)videoTime
          videoPopular:(NSString *)videoPopular;
@end
