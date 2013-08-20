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
    self.halfTitleLabel = nil;
    self.titleLabel = nil;
//    self.collectBtn = nil;
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
        _logoImageView.layer.cornerRadius = 10.0;
        _logoImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_logoImageView];
        //标题
        _titleLabel  =[[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        
        _titleLabel.font = [UIFont systemFontOfSize:15.0];
        
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.highlightedTextColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setNumberOfLines:0];
        [self.contentView addSubview:_titleLabel];
        //副标题
        _halfTitleLabel  =[[UILabel alloc] init];
        _halfTitleLabel.backgroundColor = [UIColor clearColor];
        
        _halfTitleLabel.textColor = [UIColor blackColor];
        [_halfTitleLabel setFont:[UIFont systemFontOfSize:11.0]];
        _halfTitleLabel.highlightedTextColor = [UIColor whiteColor];
        _halfTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_halfTitleLabel setNumberOfLines:0];
        [self.contentView addSubview:_halfTitleLabel];
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
    CGSize logoImageViewSize = CGSizeMake(80, 80);
//    CGSize titleLabelSize = [_titleLabel.text sizeWithFont:_titleLabel.font constrainedToSize:CGSizeMake(320, 20)];
//    CGSize halfTitleLabelSize = [_titleLabel.text sizeWithFont:_halfTitleLabel.font constrainedToSize:CGSizeMake(320, 20)];
    CGSize collectBtnSzie = CGSizeMake(40, 40);
    
    _logoImageView.frame = CGRectMake(10, 10, logoImageViewSize.width, logoImageViewSize.height);
    _titleLabel.frame = CGRectMake(_logoImageView.right+5, _logoImageView.top, 160, cellSize.height/2);
    _halfTitleLabel.frame = CGRectMake(_logoImageView.right+5, _titleLabel.bottom+5, _titleLabel.width, cellSize.height-_titleLabel.height-40);
    _collectBtn.frame = CGRectMake(_titleLabel.right+5, (cellSize.height-collectBtnSzie.height)/2, collectBtnSzie.width, collectBtnSzie.height);
    
        
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
