//
//  b4AppDelegate.m
//  hilfe
//
//  Created by Christoph Görn on 23.08.13.
//  Copyright (c) 2013 erd/G/eschoss. All rights reserved.
//

#import "b4AppDelegate.h"
#import "b4MainViewController.h"

@interface NSString (UUID)

+ (NSString *)uuid;

@end

@implementation NSString (UUID)

+ (NSString *)uuid
{
   NSString *uuidString = nil;
   CFUUIDRef uuid = CFUUIDCreate(NULL);
   if (uuid) {
      uuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(NULL, uuid));
      CFRelease(uuid);
   }
   
   return uuidString;
}

@end

@implementation b4AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
   
   if ([defaults objectForKey:@"UUID_USER_DEFAULTS_KEY"] == nil) {
      [defaults setObject:[NSString uuid] forKey:@"UUID_USER_DEFAULTS_KEY"];
      [defaults synchronize];
   }
   
   return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
   // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
   // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
   NSLog(@"going to background");
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
   // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
   // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
   
   // dump whole user defaults
   NSDictionary *bundleInfo = [[NSBundle mainBundle] infoDictionary];
   NSString *bundleId = [bundleInfo objectForKey: @"CFBundleIdentifier"];
   
   NSUserDefaults *appUserDefaults = [[NSUserDefaults alloc] init];
   NSLog(@"Start dumping userDefaults for %@", bundleId);
   NSLog(@"userDefaults dump: %@", [appUserDefaults persistentDomainForName: bundleId]);
   NSLog(@"Finished dumping userDefaults for %@", bundleId);
   // [appUserDefaults release];
   
   // inform our view controller we are entering the background
   UIWindow *window = [UIApplication sharedApplication].keyWindow;
   b4MainViewController *visibleViewController = (b4MainViewController *) window.rootViewController;
   
   [visibleViewController switchToBackgroundMode:YES];
   
   NSLog(@"now in background");
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
   // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
   NSLog(@"to foreground");
   
   // inform our view controller we are entering the background
   UIWindow *window = [UIApplication sharedApplication].keyWindow;
   b4MainViewController *visibleViewController = (b4MainViewController *)window.rootViewController;
   
   [visibleViewController switchToBackgroundMode:NO];
   
   [visibleViewController setUpdateInterval:[[NSUserDefaults standardUserDefaults] integerForKey:@"updateFrequency"]];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
   // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
   // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
