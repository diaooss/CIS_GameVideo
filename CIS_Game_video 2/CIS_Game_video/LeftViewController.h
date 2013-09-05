//
//  LeftViewController.h
//  CIS_Game_video
//
//  Created by huangfangwang on 13-7-16.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    NSArray * _nameArry;
    NSArray * _pictureArry;
    UILabel *checkLabel;//签到的标签
    UIImage * _tempImage;
    
    UITableView * _setTableView;
}
@property(nonatomic,copy)NSString * photoPath;
@end
