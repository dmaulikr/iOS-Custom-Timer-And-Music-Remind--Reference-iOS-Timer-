//
//  TimerAppDelegate.m
//  Timer
//
//  Created by Mac on 2014/7/8.
//  Copyright (c) 2014年 Timer. All rights reserved.
//

#import "TimerAppDelegate.h"

@implementation TimerAppDelegate
{
    TimerViewController *TimerViewControllerdelegate;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    TimerViewControllerdelegate=[[TimerViewController alloc]init];
    return YES;
}
-(void)applicationWillResignActive:(UIApplication *)application
{ // 當應用程式要進入睡眠狀態時,可能要做儲存狀態,暫停等.
    
}
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
   
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
