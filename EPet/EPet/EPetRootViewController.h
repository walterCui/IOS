//
//  EPetRootViewController.h
//  EPet
//
//  Created by walter on 14-10-10.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPetRootViewController : UITabBarController<UITabBarControllerDelegate,UIAlertViewDelegate>
+(instancetype)instance;
@property BOOL isSignin;
@end
