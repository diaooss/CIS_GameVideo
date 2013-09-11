//
//  RecordViewController.h
//  CIS_Game_video
//
//  Created by huangfangwang on 13-9-11.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    UITableView * _recordTab;
    UIButton *eiditBtn;
}
@property (nonatomic ,retain)NSMutableArray * recordArry;
@end
