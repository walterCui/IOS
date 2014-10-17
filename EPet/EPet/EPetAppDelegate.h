//
//  EPetAppDelegate.h
//  EPet
//
//  Created by walter on 14-9-3.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "EPetNetData.h"
#import "NetFacade.h"
#import "EPetCookie.h"

@interface EPetAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic) UINavigationController *navigationController;

@property BMKMapManager * mapManager;

+(void)subcribeResponseHandle:(short)code target:(id)target action:(SEL)action;
+(void)unsubcribeResponseHandle:(short)code;
@end
