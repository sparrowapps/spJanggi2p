//
//  AppDelegate.m
//  spJanggi2p
//
//  Created by  on 12. 6. 11..
//  Copyright (c) 2012년 SPARROWAPPS. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Hide the status bar
    [UIApplication sharedApplication].statusBarHidden = YES;
    
    JanggiViewController *janggiViewController = [[JanggiViewController alloc]init ];
   
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
     self.window.rootViewController = janggiViewController;
    [janggiViewController release];
    janggiViewController = nil;
    [self.window makeKeyAndVisible];
    
#ifdef FREE_APP
    // 지역 체크!
    NSString   *countryCode = [[NSLocale currentLocale] objectForKey: NSLocaleCountryCode];
    NSLog(@"The device's specified countryCode is %@", countryCode);
    
    // embed AD
    _isBannerVisible = NO;
    
    if ([countryCode isEqualToString:@"KR"]) {
        [self AddCaulyAD];
    } else {
        //[self AddiAd];
    }
#endif 
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - CaulyAD
#ifdef FREE_APP
- (void)AddCaulyAD {
    [CaulyViewController initCauly:self];
    
    float yPos = self.window.rootViewController.view.frame.size.height - 48;

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if( [CaulyViewController requestBannerADWithViewController:self.window.rootViewController xPos:0 yPos:yPos adType:BT_IPHONE] == FALSE ) {
            NSLog(@"requestBannerAD failed");
        }

    } else {
        if( [CaulyViewController requestBannerADWithViewController:self.window.rootViewController xPos:20 yPos:20 adType:BT_IPAD_LARGE]  == FALSE ) {
            NSLog(@"requestBannerAD failed");
        }

    }
    
}

- (void)AdReceiveCompleted {
    NSLog(@"CaulyAD AdReceiveCompleted..");
    
    if (!_isBannerVisible) {
        [UIView beginAnimations:@"animateAdBannerOn" context:nil];
        [CaulyViewController moveBannerAD:self.window.rootViewController caulyParentview:nil xPos:0 yPos:self.window.rootViewController.view.frame.size.height - 48];
        [UIView commitAnimations];
        _isBannerVisible = YES;
    }
}

- (void)AdReceiveFailed {
    NSLog(@"CaulyAD AdReceiveFailed..");
    
    if (_isBannerVisible) {
        [UIView beginAnimations:@"animateAdBannerOff" context:nil];
        [CaulyViewController moveBannerAD:self.window.rootViewController caulyParentview:nil xPos:0 yPos:self.window.rootViewController.view.frame.size.height];
        [UIView commitAnimations];
        _isBannerVisible = NO;
    }
}

- (NSString *) devKey {
    return @"xRoh7Sqk";
}

- (NSString *) gender {
    return @"all";
}

- (NSString *) age {
    return @"all";
}

- (BOOL) getGPSInfo {
    return FALSE;
}

- (REFRESH_PERIOD) rollingPeriod {
    return SEC_30;
}

- (ANIMATION_TYPE) animationType {
    return FADEOUT;
}
#endif

@end
