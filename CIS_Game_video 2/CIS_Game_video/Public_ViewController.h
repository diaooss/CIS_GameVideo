//
//  Public_ViewController.h
//  CIS_Game_video
//
//  Created by huangfangwang on 13-7-16.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Public_ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIButton *eiditBtn;
}

@property (nonatomic,retain)UITableView * showTab;


- (void)changeInformation:(NSString *)titleName;

@end
