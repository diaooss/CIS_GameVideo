//
//  LeftViewController.h
//  CIS_Game_video
//
//  Created by huangfangwang on 13-7-16.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestTools.h"
#import "YouMiDelegateProtocol.h"
@interface LeftViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,myHttpRequestDelegate,YouMiDelegate>
{
    NSArray * _nameArry;
    NSArray * _pictureArry;
    UILabel *checkLabel;//签到的标签
    UIImage * _tempImage;
    UITableView * _setTableView;
    RequestTools *getInfoRequest;
    
}
@property(nonatomic,retain)NSDictionary *infoDic;//个人详情
@end
