//
//  CategoryListCell.m
//  CIS_Game_video
//
//  Created by huangfangwang on 13-9-3.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import "CategoryListCell.h"
#import "Header.h"
@implementation CategoryListCell
-(void)dealloc
{
    [self.timeLabel release];
    [self.attentionTimeLabel release];
    [self.nameLabel release];
    [self.videoID release];
    [self.asImageView release];
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    self.asImageView = [[AsynImageView alloc]initWithFrame:CGRectZero];
    [_asImageView setPlaceholderImage:[UIImage imageNamed:@"plant1.jpg"]];
    [self addSubview:_asImageView];
    [_asImageView release];
    
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:_nameLabel];
    [_nameLabel setNumberOfLines:0];
    [_nameLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [_nameLabel setBackgroundColor:[UIColor clearColor]];
    [_nameLabel release];
    
    
    
    self.attentionTimeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:_attentionTimeLabel];
    [_attentionTimeLabel setFont:[UIFont systemFontOfSize:13.0]];
    [_attentionTimeLabel release];
    
    
    self.timeLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:_timeLabel];
    [_timeLabel setFont:[UIFont systemFontOfSize:13.0]];
    [_timeLabel release];

    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGSize mainSize = self.frame.size;
    [_asImageView setFrame:CGRectMake(5, 5,120, mainSize.height-10)];
    [_nameLabel setFrame:CGRectMake((_asImageView.right+20), 10, mainSize.width-165, mainSize.height/2)];
    [_attentionTimeLabel setFrame:CGRectMake((_asImageView.right+20), _nameLabel.bottom, 50, 20)];
    [_timeLabel setFrame:CGRectMake(_attentionTimeLabel.right+60, _nameLabel.bottom, 50, 20)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
