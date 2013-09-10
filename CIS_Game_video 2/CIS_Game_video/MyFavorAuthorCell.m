//
//  MyFavorAuthorCell.m
//  CustomCell
//
//  Created by huanfang_liu on 13-7-16.
//  Copyright (c) 2013年 huanfang. All rights reserved.
//

#import "MyFavorAuthorCell.h"
#import "Header.h"
@implementation MyFavorAuthorCell
- (void)dealloc
{
    self.authorLogoView = nil;
    self.authorNameLabel = nil;
    self.popularImg = nil;
    self.popularLab = nil;
    self.countImg = nil;
    self.countLab = nil;
//    self.favorBtn = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _authorLogoView = [[UIImageView alloc] init];
        _authorLogoView.userInteractionEnabled =  YES;
        _authorLogoView.contentMode = UIViewContentModeScaleAspectFit;
        _authorLogoView.backgroundColor = [UIColor greenColor];
        _authorLogoView.layer.cornerRadius = 10.0;
        [self.contentView addSubview:_authorLogoView];
        //
        _authorNameLabel = [[UILabel alloc] init];
        _authorNameLabel.textAlignment = NSTextAlignmentLeft;
        _authorNameLabel.backgroundColor = [UIColor clearColor];
        _authorNameLabel.font = [UIFont systemFontOfSize:20.0];
        [_authorNameLabel setNumberOfLines:0];
        _authorNameLabel.highlightedTextColor = [UIColor whiteColor];
        [self.contentView addSubview:_authorNameLabel];
        //人气小图标
        self.popularImg = [[UIImageView alloc] init];
        self.popularImg.backgroundColor  = [UIColor greenColor];
        self.contentMode  = UIViewContentModeScaleAspectFit;
        self.popularImg.layer.cornerRadius = 3.0;
        self.popularImg.layer.masksToBounds = YES;
        [self.contentView addSubview:_popularImg];
        //作品数量小图标
        self.countImg = [[UIImageView alloc] init];
        self.countImg.backgroundColor  = [UIColor greenColor];
        self.contentMode  = UIViewContentModeScaleAspectFit;
        self.countImg.layer.cornerRadius = 3.0;
        self.countImg.layer.masksToBounds = YES;
        [self.contentView addSubview:_countImg];
        
        //人气标签
        _popularLab = [[UILabel alloc] init];
        _popularLab  =[[UILabel alloc] init];
        _popularLab.backgroundColor = [UIColor redColor];
        _popularLab.font = [UIFont systemFontOfSize:10.0];
        _popularLab.textColor = [UIColor blackColor];
        _popularLab.highlightedTextColor = [UIColor whiteColor];
        _popularLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_popularLab];
        
        //作品数量标签
        _countLab = [[UILabel alloc] init];
        _countLab  =[[UILabel alloc] init];
        _countLab.backgroundColor = [UIColor redColor];
        _countLab.font = [UIFont systemFontOfSize:10.0];
        _countLab.textColor = [UIColor blackColor];
        _countLab.highlightedTextColor = [UIColor whiteColor];
        _countLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_countLab];

        
        
        
        //
        _favorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _favorBtn.backgroundColor = [UIColor redColor];
        _favorBtn.showsTouchWhenHighlighted = YES;
        [_favorBtn setTitle:@"X" forState:UIControlStateNormal];
        [self.contentView addSubview:_favorBtn];
        _favorBtn.layer.cornerRadius = 20.0;

        
    }
    return self;
}
//通过手势,让取消关注的按钮随手势出现和消失.
-(void)cancelLike
{
    [UIView beginAnimations:nil context:nil];
    [UIView animateWithDuration:0.3 animations:^{
        
        if (_favorBtn.alpha ==0) {
            _favorBtn.alpha = 1;
            
        }else
            _favorBtn.alpha = 0;
    } completion:nil];
    
    [UIView commitAnimations];
   
   
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGSize cellSize = self.bounds.size;
        _authorLogoView.size = CGSizeMake(80, 80);
    _authorLogoView.frame = CGRectMake(5, 10, _authorLogoView.width, _authorLogoView.height);
    _authorNameLabel.frame = CGRectMake(_authorLogoView.right, 10, cellSize.width-130, cellSize.height/2);
    
    _popularImg.frame = CGRectMake(_authorLogoView.right+10, _authorNameLabel.bottom+10, 20, 20);
    _popularLab.frame = CGRectMake(_popularImg.right, _popularImg.top, 50, 20);
    _countImg.frame = CGRectMake(_popularLab.right+10, _popularLab.top, 20, 20);
    _countLab.frame = CGRectMake(_countImg.right, _countImg.top, 50, 20);
    _favorBtn.size = CGSizeMake(40, 40);
    _favorBtn.frame = CGRectMake(_authorNameLabel.right, (cellSize.height-40)/2, _favorBtn.width, _favorBtn.height);
    _favorBtn.alpha = 0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
