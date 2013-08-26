//
//  LeftViewController.h
//  CIS_Game_video
//
//  Created by huangfangwang on 13-7-16.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
    NSArray * _nameArry;
    NSArray * _pictureArry;
    BOOL _isCraete;
}
@end
