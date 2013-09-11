//
//  Video.m
//  AnsirPro
//
//  Created by huangfangwang on 13-9-11.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "Video.h"

@implementation Video
-(id)initWithID:(int)ID
{
    self = [super init];
    if (self) {
        self.ID = ID;
    }
    return self;
}
-(id)initWithID:(int)ID
      videoName:(NSString *)videoName
   videoPicture:(NSString *)videoPicture
        videoID:(NSString *)videoID
    videoAuthor:(NSString *)videoAuthor
      videoTime:(NSString *)videoTime
   videoPopular:(NSString *)videoPopular
{
        [self initWithID:ID];
        self.videoName = videoName;
        self.videoPicture = videoPicture;
        self.videoID = videoID;
        self.videoAuthor = videoAuthor;
        self.videoTime = videoTime;
        self.videoPopular = videoPopular;
        return self;
}
-(id)initWithVideoName:(NSString *)videoName
          videoPicture:(NSString *)videoPicture
               videoID:(NSString *)videoID
           videoAuthor:(NSString *)videoAuthor
             videoTime:(NSString *)videoTime
          videoPopular:(NSString *)videoPopular
{
    self = [super init];
    if (self) {
        self.videoName = videoName;
        self.videoPicture = videoPicture;
        self.videoID = videoID;
        self.videoAuthor = videoAuthor;
        self.videoTime = videoTime;
        self.videoPopular = videoPopular;
    }
    return self;
}

@end
