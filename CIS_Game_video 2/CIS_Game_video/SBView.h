//
//  SBView.h
//  CIS_Game_video
//
//  Created by huangfangwang on 13-7-15.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBView : UIView <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain) UIScrollView * firstScr;//第一个推荐.
@property (nonatomic,retain) UIScrollView * secondScr;//最新的视频.
@property (nonatomic,retain) NSMutableArray * arry;

@property (nonatomic,assign) id taget;
@property (nonatomic,assign) SEL action;
- (void)addTaget:(id)taget action:(SEL)action;
- (void)changeData;
@end
