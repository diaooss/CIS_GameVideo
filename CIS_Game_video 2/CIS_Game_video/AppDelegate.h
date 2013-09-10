//
//  AppDelegate.h
//  CIS_Game_video
//
//  Created by huangfangwang on 13-7-15.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    Reachability  *hostReach;

}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain)UINavigationController * rootNvc;
@end
