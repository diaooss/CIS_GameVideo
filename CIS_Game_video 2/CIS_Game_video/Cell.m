//
//  Cell.m
//  CELL
//
//  Created by huangfangwang on 13-8-28.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "Cell.h"
#import "GroupView.h"
@implementation Cell
-(void)dealloc
{
    [self.PicArry release];
    [self.scrollerView release];
    [super dealloc];
   
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.PicArry = [NSMutableArray arrayWithCapacity:2];
        // Initialization code
        CGSize mainSize = self.frame.size;
#pragma mark---这个宽度和cell 的宽度一样!!!!!手动添加
        mainSize.height = 230;
        self.scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 230)];
        [_scrollerView setContentSize:CGSizeMake(320*2, mainSize.height)];
        [self addSubview:_scrollerView];
        [_scrollerView setPagingEnabled:YES];
        [_scrollerView release];
        [_scrollerView setShowsHorizontalScrollIndicator:NO];
        
        for (int j=0; j<2; j++) {
            for (int i=0; i<6; i++) {
                GroupView * view = [[GroupView alloc]initWithFrame:CGRectMake(((mainSize.width-30)/3+10)*i+5, j*(mainSize.height-10)/2+5, (mainSize.width-30)/3, (mainSize.height-10)/2)];
                [_scrollerView addSubview:view];
                [view setTag:100+j*6+i];
                [view release];
                [view setDelegate:self];
                [self.PicArry addObject:view];
            }
        }
    }
    return self;
}
-(void)loadInforWithNetArry:(NSArray *)netArry
{
    int mark = 0;
    for (GroupView * obj in self.PicArry) {
        [obj.asImageView setImageURL:[netArry objectAtIndex:mark]];
        NSLog(@"-----------%@",[netArry objectAtIndex:mark]);
//        [obj.nameLabel setText:<#(NSString *)#>];//名字
//        [obj.timeLabel setText:<#(NSString *)#>];//时间
        [obj setVideoID:[NSString stringWithFormat:@"%d",mark]];//视频ID;
        mark++;
    }
}
//cell  再触发点击视图的时候走代理 去做事情
-(void)clickThePictureWith:(NSString *)videoID
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(accessPlayViewControllerWithVideoID:)]) {
        [self.delegate performSelector:@selector(accessPlayViewControllerWithVideoID:) withObject:videoID];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
