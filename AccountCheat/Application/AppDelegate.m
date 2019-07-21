//
//  AppDelegate.m
//  AccountCheat
//
//  Created by Jersey on 2019/7/11.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "AppDelegate.h"

#import "JSDHomeViewController.h"
#import <MaterialComponents/MDCAppBarViewController.h>
#import <MaterialComponents/MDCAppBarNavigationController.h>
#import "JSDTabBarController.h"
#import "JSDUserPasswordCheckManage.h"
#import <JPUSHService.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    JSDTabBarController* tabBarVC = [[JSDTabBarController alloc] init];

    self.window.rootViewController = tabBarVC;
    [self.window makeKeyAndVisible];
    
    [self setupPushApplication:application Options:launchOptions];
    
    return YES;
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
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
    
    JSDUserPasswordCheckManage* checkManage = [JSDUserPasswordCheckManage sharedInstance];
    [checkManage checkPasswrod];// TODO:弹框逻辑待完善
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
}

- (void) setupPushApplication:(UIApplication *)application Options:(NSDictionary *)launchOptions {
    
    NSString *appKey = @"85b2fe79cf80674e73bb8a42";
    NSString *channel = @"channel";
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    
    BOOL isProduction = false;
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];  //
    
    [application registerForRemoteNotifications];
}


@end
