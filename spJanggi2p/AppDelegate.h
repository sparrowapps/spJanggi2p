//
//  AppDelegate.h
//  spJanggi2p
//
//  Created by  on 12. 6. 11..
//  Copyright (c) 2012년 SPARROWAPPS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JanggiViewController.h"

#ifdef FREE_APP
#import "CaulyViewController.h"
#endif

#ifdef FREE_APP
@interface AppDelegate : UIResponder <UIApplicationDelegate, CaulyProtocol>
#else
@interface AppDelegate : UIResponder <UIApplicationDelegate>
#endif
{
#ifdef FREE_APP
    BOOL _isBannerVisible;
#endif
}

@property (strong, nonatomic) UIWindow *window;

#ifdef FREE_APP
- (void) AddCaulyAD;
#endif

@end
