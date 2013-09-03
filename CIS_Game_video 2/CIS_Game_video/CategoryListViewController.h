//
//  CategoryListViewController.h
//  CIS_Game_video
//
//  Created by huangfangwang on 13-9-3.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _categoryTable;
}
@end
