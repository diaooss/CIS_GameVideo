//
//  DefaultRootView.h
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-9-4.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Animation_Turn_View.h"
#import "Cell.h"


@interface DefaultRootView : UIView<UITableViewDataSource,UITableViewDelegate,CellDelegate,AnimationViewDelegate>
{
    Animation_Turn_View * animationView;//轮显
    UITableView *defaultListTab;
    
}
@property(nonatomic,assign)int mark;//

@end
