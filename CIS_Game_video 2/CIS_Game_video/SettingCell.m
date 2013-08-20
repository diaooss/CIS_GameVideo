//
//  SettingCell.m
//  CustomCell
//
//  Created by huanfang_liu on 13-7-16.
//  Copyright (c) 2013年 huanfang. All rights reserved.
//

#import "SettingCell.h"
#import "Header.h"
@implementation SettingCell
- (void)dealloc
{
    self.setTitleLabel = nil;
    self.setSwitch = nil;
    self.setImageView = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _setImageView = [[UIImageView alloc] init];
        _setImageView.contentMode = UIViewContentModeScaleAspectFit;
//        _setImageView.backgroundColor = [UIColor greenColor];
        _setImageView.layer.cornerRadius = 10.0;
        [self.contentView addSubview:_setImageView];
        
        _setTitleLabel = [[UILabel alloc] init];
        _setTitleLabel.backgroundColor  =[UIColor clearColor];
        _setTitleLabel.textAlignment = NSTextAlignmentLeft;
        _setTitleLabel.font = [UIFont systemFontOfSize:20.0];
        _setTitleLabel.highlightedTextColor = [UIColor whiteColor];
        [self.contentView addSubview:_setTitleLabel];
        _setSwitch = [[UISwitch alloc] init];
        _setSwitch.thumbTintColor = [UIColor grayColor];
        _setSwitch.tintColor = [UIColor grayColor];
        _setSwitch.onTintColor = [UIColor colorWithRed:98/255.0 green:138/255.0 blue:14/255.0 alpha:1];
        [self.contentView  addSubview:_setSwitch];
        _setSwitch.on = YES;
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGSize cellSize = self.bounds.size;
    _setImageView.frame = CGRectMake(5, (cellSize.height-20)/2, 20, 20);
    _setTitleLabel.frame = CGRectMake(30, 0, 150, 44);
    CGFloat padding = cellSize.height-_setSwitch.height;
    _setSwitch.frame = CGRectMake(cellSize.width-_setTitleLabel.width+40, padding/2, 0, 0);
//    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
