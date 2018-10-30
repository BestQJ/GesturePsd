//
//  AppDelegate.m
//  GesturePsd
//
//  Created by 乔杰 on 2018/10/29.
//  Copyright © 2018 乔杰. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "GesturePsdCheckViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    if (Gesture_open_statu || Touch_id_open_statu) {
        self.window.rootViewController = [[GesturePsdCheckViewController alloc] init];
    }else {
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController: [HomeViewController new]];
    }
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}


- (void)showRootViewController {
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController: [HomeViewController new]];

}

@end
