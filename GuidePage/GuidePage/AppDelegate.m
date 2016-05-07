//
//  AppDelegate.m
//  GuidePage
//
//  Created by gdm on 16/5/7.
//  Copyright © 2016年 辜东明. All rights reserved.
//

#import "AppDelegate.h"
#import "DMGudiePageViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    
    //判断是不是第一次启动应用
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"nofirstLaunch"])
    {//第一次启动应用
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"nofirstLaunch"];
        [self guideVC];
    }
    else//不是第一次启动应用
    {
        [self mainVC];
    }
    
    return YES;
}

-(void)guideVC
{
    //类型1：本地图片
    NSArray *imageUrlStr = @[@"img_index_01bg", @"img_index_02bg", @"img_index_03bg"];
    DMGudiePageViewController *gudieVC = [[DMGudiePageViewController alloc]initWithImageType:ImageName andImageArr:imageUrlStr andCurrentPageColor:[UIColor blueColor] andOtherPageColor:[UIColor lightGrayColor] andDidSelectedEnter:^{
        [self mainVC];
    }];
    //类型2：网络图片
//    NSArray *imageUrlStr = @[
//                             @"http://pic.qiantucdn.com/58pic/16/03/83/71m58PICtxj.jpg",
//                             @"http://pic.qiantucdn.com/58pic/19/41/25/56cd456cf319e.jpg",
//                             @"http://pic.qiantucdn.com/58pic/17/37/17/62S58PICF2C_1024.jpg"
//                             ];
//    DMGudiePageViewController *gudieVC = [[DMGudiePageViewController alloc]initWithImageType:ImageUrlStr andImageArr:imageUrlStr andCurrentPageColor:[UIColor blueColor] andOtherPageColor:[UIColor lightGrayColor] andDidSelectedEnter:^{
//        [self mainVC];
//    }];
    self.window.rootViewController = gudieVC;
}

-(void)mainVC
{
    //填更换的跟视图
    self.window.rootViewController = [UIViewController new];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
