//
//  AppDelegate.m
//  ZLMultiPageSliding
//
//  Created by 周礼 on 17/5/12.
//  Copyright © 2017年 com.sky. All rights reserved.
//

#import "AppDelegate.h"
#import "ZLMultiPageViewController.h"
#import "ZLFirstViewController.h"
#import "ZLSecondViewController.h"
#import "ZLThirdViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    ZLFirstViewController *firstVc = [[ZLFirstViewController alloc] init];
    ZLSecondViewController *secondVc = [[ZLSecondViewController alloc] init];
    ZLThirdViewController *thirdVc = [[ZLThirdViewController alloc] init];
    ZLFirstViewController *fff = [[ZLFirstViewController alloc] init];
    
    ZLMultiPageViewController *multiPageVC = [[ZLMultiPageViewController alloc] initWithTitleArray:@[@"第一个",@"第二个",@"第三个",@"第四个"] pages:@[firstVc, secondVc, thirdVc,fff]];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:multiPageVC];
    self.window.rootViewController = navigationController;
    
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
