//
//  My_MakeVipView.m
//  CIS_Game_video
//
//  Created by huangfangwang on 13-7-19.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import "My_MakeVipView.h"

@implementation My_MakeVipView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    UITextField * Idlabel = [[UITextField alloc]initWithFrame:CGRectMake(50, 50, 220, 40)];
    [Idlabel setPlaceholder:@"邮箱"];
    [Idlabel setBorderStyle:UITextBorderStyleRoundedRect];
    [self addSubview:Idlabel];
    [Idlabel release];
    
    
    UITextField * passLabel = [[UITextField alloc]initWithFrame:CGRectMake(50, 90, 220, 40)];
    [self addSubview:passLabel];
    [passLabel setBorderStyle:UITextBorderStyleRoundedRect];
    [passLabel setPlaceholder:@"密码"];
    [passLabel release];
    
    UIButton * pressButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [pressButton setFrame:CGRectMake(50, 150, 220, 40)];
    [self addSubview:pressButton];
    [pressButton setTitle:@"注册" forState:UIControlStateNormal];
    
}

@end
