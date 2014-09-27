//
//  EPetAppDelegate.h
//  EPet
//
//  Created by walter on 14-9-3.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface EPetAppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic) UINavigationController *navigationController;

@property BMKMapManager * mapManager;
@end
