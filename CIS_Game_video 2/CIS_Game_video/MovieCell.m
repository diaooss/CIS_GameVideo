//
//  MovieCell.m
//  CustomCell
//
//  Created by huanfang_liu on 13-7-16.
//  Copyright (c) 2013年 huanfang. All rights reserved.
//

#import "MovieCell.h"
#import "Header.h"
@implementation MovieCell
- (void)dealloc
{
    self.logoImageView = nil;
    self.categoryLabel = nil;
    self.titleLabel = nil;
    self.timeLab = nil;
    self.timeImg = nil;
    self.popularImg = nil;
    self.popularLab = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //缩略图
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
        _logoImageView.backgroundColor = [UIColor grayColor];
        _logoImageView.layer.cornerRadius = 3.0;
        _logoImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_logoImageView];
        //标题
        _titleLabel  =[[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor redColor];
        _titleLabel.font = [UIFont systemFontOfSize:13.0];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.highlightedTextColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setNumberOfLines:0];
        [self.contentView addSubview:_titleLabel];
        //副标题
        _categoryLabel  =[[UILabel alloc] init];
        _categoryLabel.backgroundColor = [UIColor redColor];
        _categoryLabel.textColor = [UIColor blackColor];
        [_categoryLabel setFont:[UIFont systemFontOfSize:11.0]];
        _categoryLabel.highlightedTextColor = [UIColor whiteColor];
        _categoryLabel.textAlignment = NSTextAlignmentCenter;
        [self.logoImageView addSubview:_categoryLabel];
        //时长小图标
        self.timeImg = [[UIImageView alloc] init];
        self.timeImg.backgroundColor  = [UIColor greenColor];
        self.contentMode  = UIViewContentModeScaleAspectFit;
        self.timeImg.layer.cornerRadius = 3.0;
        self.timeImg.layer.masksToBounds = YES;
        [self.contentView addSubview:_timeImg];
        //人气小图标
        self.popularImg = [[UIImageView alloc] init];
        self.popularImg.backgroundColor  = [UIColor greenColor];
        self.contentMode  = UIViewContentModeScaleAspectFit;
        self.popularImg.layer.cornerRadius = 3.0;
        self.popularImg.layer.masksToBounds = YES;
        [self.contentView addSubview:_popularImg];

        //时长标签
        _timeLab = [[UILabel alloc] init];
        _timeLab  =[[UILabel alloc] init];
        _timeLab.backgroundColor = [UIColor redColor];
        _timeLab.font = [UIFont systemFontOfSize:10.0];
        _timeLab.textColor = [UIColor blackColor];
        _timeLab.highlightedTextColor = [UIColor whiteColor];
        _timeLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_timeLab];

        //人气标签
        _popularLab = [[UILabel alloc] init];
        _popularLab  =[[UILabel alloc] init];
        _popularLab.backgroundColor = [UIColor redColor];
        _popularLab.font = [UIFont systemFontOfSize:10.0];
        _popularLab.textColor = [UIColor blackColor];
        _popularLab.highlightedTextColor = [UIColor whiteColor];
        _popularLab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_popularLab];
        
        
        //
        
        _collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collectBtn setTitle:@"LIKE" forState:UIControlStateNormal];
        _collectBtn.showsTouchWhenHighlighted = YES;
        [_collectBtn setBackgroundColor:[UIColor colorWithRed:95/255.0 green:112/255.0 blue:38/255.0 alpha:1]];
        
        _collectBtn.layer.cornerRadius = 20.0;
        [self.contentView addSubview:_collectBtn];
        
        // Initialization code
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGSize cellSize  = self.bounds.size;
    CGSize logoImageViewSize = CGSizeMake(120, 100);
    CGSize collectBtnSzie = CGSizeMake(40, 40);
    
    _logoImageView.frame = CGRectMake(10, 10, logoImageViewSize.width, logoImageViewSize.height);
    _titleLabel.frame = CGRectMake(_logoImageView.right+5, _logoImageView.top, 130, cellSize.height/2);
    _categoryLabel.frame = CGRectMake(_logoImageView.width-50, _logoImageView.bottom-40, 50, 25);
    _collectBtn.frame = CGRectMake(_titleLabel.right+5, (cellSize.height-collectBtnSzie.height)/2, collectBtnSzie.width, collectBtnSzie.height);
    
    _timeImg.frame = CGRectMake(_titleLabel.left, _titleLabel.bottom+15, 20, 20);
    _timeLab.frame = CGRectMake(_timeImg.right,_titleLabel.bottom+15, 45, 20);
    _popularImg.frame = CGRectMake(_timeLab.right, _titleLabel.bottom+15, 20, 20);
    _popularLab.frame = CGRectMake(_popularImg.right,_titleLabel.bottom+15, 45, 20);


    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
