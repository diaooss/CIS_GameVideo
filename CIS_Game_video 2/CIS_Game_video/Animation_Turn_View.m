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
    return self;
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
 //create a numbered button
        UIImage *image = [UIImage imageNamed:@"test.png"];
        UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.width-100, self.height)] autorelease];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = index;
        return button;
 }
- (void)buttonTapped:(UIButton *)sender
{
    if (_delegate &&[_delegate respondsToSelector:@selector(transportVideoInformation:)]) {
        [_delegate performSelector:@selector(transportVideoInformation:)withObject:[sender backgroundImageForState:UIControlStateNormal]];
    }
}
@end
