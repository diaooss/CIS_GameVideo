//
//  SBView.m
//  CIS_Game_video
//
//  Created by huangfangwang on 13-7-15.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import "SBView.h"
#import "Header.h"
#import <QuartzCore/QuartzCore.h>
@implementation SBView
-(void)dealloc
{
    [self.secondScr release];
    [self.firstScr release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    UILabel * firstLa = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
    [firstLa setText:@"推荐播放"];
    [firstLa setTextColor:[UIColor brownColor]];
    [firstLa setBackgroundColor:[UIColor clearColor]];
    [firstLa setTextAlignment:NSTextAlignmentLeft];
    [self addSubview:firstLa];
    [firstLa setFont:[UIFont systemFontOfSize:18]];
    [firstLa release];
    
    //创建最新视频
    UILabel * secondLa = [[UILabel alloc]initWithFrame:CGRectMake(0,self.height/2, 320, 20)];
    [secondLa setText:@"最新视频"];
    [secondLa setBackgroundColor:[UIColor clearColor]];
    [secondLa setTextColor:[UIColor brownColor]];
    [secondLa setTextAlignment:NSTextAlignmentLeft];
    [self addSubview:secondLa];
    [secondLa setFont:[UIFont systemFontOfSize:18]];
    [secondLa release];
    self.firstScr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, 320, self.height/2-20)];
    [_firstScr setContentSize:CGSizeMake(900, self.height/2-20)];
    
    self.secondScr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.height/2+20, 320, self.height/2-20)];
    [_secondScr setContentSize:CGSizeMake(900, self.height/2-80)];
 
    for (int j=0; j<2; j++) {
                for (int i=0; i<6; i++) {
                    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    [btn setFrame:CGRectMake(10+120*i, 5, 100, self.height/2-30-40)];
                    btn.layer.cornerRadius = 15.0;
                    [btn setBackgroundColor:[UIColor colorWithRed:95/255.0 green:112/255.0 blue:38/255.0 alpha:1]];
                    [btn addTarget:self action:@selector(goIntoSomewhere:) forControlEvents:UIControlEventTouchUpInside];
                    [btn setTag:100*i];
                    UILabel * inforlabel = [[UILabel alloc]initWithFrame:CGRectMake(10+160*i, btn.frame.origin.y+btn.frame.size.height, 150, 40)];
                    [inforlabel setFont:[UIFont systemFontOfSize:12.0]];
                    [inforlabel setBackgroundColor:[UIColor clearColor]];
                    [inforlabel setTextAlignment:NSTextAlignmentCenter];
                    [inforlabel setLineBreakMode:NSLineBreakByWordWrapping];
                    [inforlabel setNumberOfLines:0];
                    if (j==0) {
//                        [btn setBackgroundImage:[UIImage imageNamed:@"test.png"] forState:UIControlStateNormal];//这里可以就收网络的图片
                        [inforlabel setText:@"城市基础会计师"];//这里可以用数组添加视频的名称
                        [_firstScr addSubview:btn];
                        [_firstScr addSubview:inforlabel];
                    }else{
//                        [btn setBackgroundImage:[UIImage imageNamed:@"test.png"] forState:UIControlStateNormal];//这里可以就收网络的图片
                        [inforlabel setText:@"lol欢迎你"];//这里可以用数组添加视频的名称
                        [_secondScr addSubview:btn];
                        [_secondScr addSubview:inforlabel];
                    }
                    [inforlabel release];
            }
    }
    [self addSubview:_firstScr];
    [_firstScr release];
    [self addSubview:_secondScr];
    [_secondScr release];
}
//数据更新方法
- (void)changeData
{
    [self layoutSubviews];
}
//addtaget方法;
- (void)addTaget:(id)taget action:(SEL)action
{
    self.taget = taget;
    self.action = action;
}
//button的关联方法;
-(void)goIntoSomewhere:(UIButton *)btn
{
    //传递一个Imaged对象过去;
    [self.taget performSelector:self.action withObject:[btn backgroundImageForState:UIControlStateNormal]];
}
@end
