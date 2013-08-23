//
//  AuthorCell.m
//  CustomCell
//
//  Created by huanfang_liu on 13-7-16.
//  Copyright (c) 2013年 huanfang. All rights reserved.
//

#import "AuthorCell.h"
#import "Header.h"
@implementation AuthorCell
- (void)dealloc
{
    self.stateImgView = nil;
    self.nameLabel = nil;
    self.countLabel = nil;
//    self.likeBtn = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //指示小图标
        _stateImgView = [[UIImageView alloc] init];
        _stateImgView.contentMode = UIViewContentModeScaleToFill;
        _stateImgView.image = [UIImage imageNamed:@"DownAccessory.png"];

        [self.contentView addSubview:_stateImgView];
        //作者姓名
        _nameLabel = [[UILabel alloc] init];
        [_nameLabel setFont:[UIFont systemFontOfSize:15]];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.highlightedTextColor = [UIColor whiteColor];
        _nameLabel.backgroundColor = [UIColor clearColor];
        [_nameLabel setNumberOfLines:0];
        [self.contentView addSubview:_nameLabel];
        //数量
        _countLabel = [[UILabel alloc] init];
        [_countLabel setFont:[UIFont systemFontOfSize:15]];
        _countLabel.textAlignment = NSTextAlignmentLeft;
        _countLabel.textColor = [UIColor brownColor];
        _countLabel.highlightedTextColor = [UIColor whiteColor];
        _countLabel.backgroundColor = [UIColor clearColor];
        [_countLabel setNumberOfLines:0];
        [self.contentView addSubview:_countLabel];
        
        //
        _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _likeBtn.backgroundColor = [UIColor colorWithRed:95/255.0 green:112/255.0 blue:38/255.0 alpha:1];
        [_likeBtn setTitle:@">>" forState:UIControlStateNormal];
        _likeBtn.showsTouchWhenHighlighted = YES;
        _likeBtn.layer.cornerRadius = 15.0;
        [self.contentView addSubview:_likeBtn];
        
        
        
        
        
        
        
        
    }
    return self;
}
-(void)layoutSubviews
{
        [super layoutSubviews];
    CGSize cellSize = self.bounds.size;
    CGSize stateImageViewSize = CGSizeMake(36, 30);
    _stateImgView.frame = CGRectMake(0, (cellSize.height-30)/2, stateImageViewSize.width , stateImageViewSize.height);
    
    _nameLabel.frame = CGRectMake(_stateImgView.right, 0, 170, cellSize.height);
    _countLabel.frame = CGRectMake(_nameLabel.right, 0, 70, cellSize.height);
    _likeBtn.frame = CGRectMake(_countLabel.right+10, (cellSize.height-30)/2, 30, 30);
}
- (void)changeArrowWithUp:(BOOL)up
{
        if (up) {
            
            _stateImgView.image = [UIImage imageNamed:@"UpAccessory.png"];
        }else
        {
            _stateImgView.image = [UIImage imageNamed:@"DownAccessory.png"];
        }
        NSLog(@"参数是%d",up);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
