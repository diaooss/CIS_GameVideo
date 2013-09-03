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
    //风火轮
#pragma mark --调用接口--------------先请求数据请求成功后加载!!图片
    return self;
}
-(void)backOneDic:(NSDictionary *)dic
{
    _icarousel = [[iCarousel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [_icarousel setDataSource:self];
    [_icarousel setDelegate:self];
    [_icarousel setType:iCarouselTypeRotary];
    [self addSubview:_icarousel];
    NSLog(@"----*****%@",dic);
}
- (void)layoutSubviews
{
    [super layoutSubviews];
}

 #pragma mark -
 #pragma mark iCarousel methods
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return 5;
}
 - (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index
 {
     NSArray * arry = [NSArray arrayWithObjects:
                       @"http://121.199.57.44:88/images/m001.png",
                       @"http://121.199.57.44:88/images/m002.png",
                       @"http://121.199.57.44:88/images/003.gif",
                       @"http://121.199.57.44:88/images/m004.png",
                       @"http://121.199.57.44:88/images/m005.png",
                       @"http://121.199.57.44:88/images/m006.png",
                       @"http://121.199.57.44:88/images/m007.png",
                       @"http://121.199.57.44:88/images/m008.png",
                       @"http://121.199.57.44:88/images/m009.png",
                       @"http://121.199.57.44:88/images/m010.png",
                       @"http://121.199.57.44:88/images/m011.png",
                       @"http://121.199.57.44:88/images/m012.png",
                       nil];
     GroupView * view = [[[GroupView alloc]initWithFrame:CGRectMake(0, 0, self.width-100, self.height)] autorelease];
     [view.nameLabel setAlpha:0];
     [view.timeLabel setAlpha:0];
     [view setDelegate:self];
     [view setVideoID:[NSString stringWithFormat:@"%lu",(unsigned long)index]];
     [view.asImageView setFrame: CGRectMake(0, 0,self.width-100, self.height)];
     [view.asImageView setImageURL:[arry objectAtIndex:index]];
     return view;
     
}
-(void)clickThePictureWith:(NSString *)videoID
{
    if (_delegate &&[_delegate respondsToSelector:@selector(transportVideoInformation:)]) {
        [_delegate performSelector:@selector(transportVideoInformation:)withObject:videoID];
    }
}
@end
