//
//  AppDelegate.m
//  LoginDemo
//
//  Created by Apple on 2017/7/31.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "GuidePageViewController.h"
#import "CALayer+Transition.h"

@interface AppDelegate ()<GuidePageViewDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
   
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 测试的时候改变info 里的版本号就可以了
    NSArray *images = @[@"first",@"second",@"three",@"fourth"];
    BOOL y = [GuidePageViewController isShow];
    if (y) {
        GuidePageViewController *guidePageView = [[GuidePageViewController alloc] init];
        self.window.rootViewController = guidePageView;
        guidePageView.delegate = self;
        [guidePageView guidePageControllerWithImages:images];
        
    }else{
        [self clickEnter];
    }
    
    
    return YES;
}

- (void)clickEnter
{
    ViewController *vc = [[ViewController alloc] init];
    self.window.rootViewController = vc;
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
