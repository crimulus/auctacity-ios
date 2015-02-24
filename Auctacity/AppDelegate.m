//
//  AppDelegate.m
//  Auctacity
//
//  Created by Tharp, Jeremy on 12/6/14.
//  Copyright (c) 2014 Tharp, Jeremy. All rights reserved.
//

#import "AppDelegate.h"
#import "AuthViewController.h"
#import "AuctionsTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self subscribeToNotifications];
    return YES;
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

- (void)subscribeToNotifications {

    // Successful Login
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(successfulLogin:)
                                                 name:@"SuccessfulLogin"
                                               object:nil];

    // Successful Logout
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(successfulLogout:)
                                                 name:@"SuccessfulLogout"
                                               object:nil];

}

- (void)successfulLogin:(NSNotification *)notification {

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AuctionsTableViewController *atvc = [sb instantiateViewControllerWithIdentifier:@"auctionsTableViewController"];
    atvc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;

    [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
        [self.window.rootViewController presentViewController:atvc
                                                     animated:YES
                                                   completion:^{
                                                       [self.window setRootViewController:atvc];
                                                   }];
    }];

}

- (void)successfulLogout:(NSNotification *)notification {

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AuthViewController *avc = [sb instantiateViewControllerWithIdentifier:@"authViewController"];
    avc.modalTransitionStyle = UIModalTransitionStylePartialCurl;

    [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
        [self.window.rootViewController presentViewController:avc
                                                     animated:YES
                                                   completion:^{
                                                       [self.window setRootViewController:avc];
                                                   }];
    }];

}

@end
