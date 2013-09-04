//
//  Animation_Turn_View.m
//  CIS_Game_video
//
//  Created by huangfangwang on 13-7-15.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import "Animation_Turn_View.h"
#import "Header.h"
#define USE_BUTTONS YES

@implementation Animation_Turn_View

- (void)dealloc
{
    [_icarousel release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    _icarousel = [[iCarousel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [_icarousel setDataSource:self];
    [_icarousel setDelegate:self];
    [_icarousel setType:iCarouselTypeRotary];
    [self addSubview:_icarousel];
    //风火轮
#pragma mark --调用接口--------------先请求数据请求成功后加载!!图片
    return self;
}
#pragma mark iCarousel methods
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return 5;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index
 {
     GroupView * view = [[[GroupView alloc]initWithFrame:CGRectMake(0, 0, self.width-100, self.height)] autorelease];
     [view.nameLabel setAlpha:0];
     [view.timeLabel setAlpha:0];
     [view setDelegate:self];
     [view setVideoID:[NSString stringWithFormat:@"%lu",(unsigned long)index]];
     [view.asImageView setFrame: CGRectMake(0, 0,self.width-100, self.height)];
     if ([self.slideArry count]>0) {
         [view.asImageView setImageURL:[self.slideArry objectAtIndex:index]];
         //加ID
         
     }
     return view;
}
-(void)clickThePictureWith:(NSString *)videoID
{
    if (_delegate &&[_delegate respondsToSelector:@selector(transportVideoInformation:)]) {
        [_delegate performSelector:@selector(transportVideoInformation:)withObject:videoID];
    }
}
@end
