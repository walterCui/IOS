//
//  EPetAppDelegate.m
//  EPet
//
//  Created by walter on 14-9-3.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#import "EPetAppDelegate.h"
#import "HomeViewController.h"
#import "EPetRootViewController.h"

@interface handleWraper:NSObject

@property NSInteger code;
@property id target;
@property SEL action;

-(instancetype)init:(NSInteger)code target:(id)target action:(SEL)action;

@end

@implementation handleWraper
-(instancetype)init:(NSInteger)code target:(id)target action:(SEL)action
{
    self.code = code;
    self.target = target;
    self.action = action;
    return [super init];
}
@end

@implementation EPetAppDelegate


static NSMutableArray *handles;

static void handleResponse(short code,Byte* data)
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        handleWraper * temp;
        for(int i = 0, max = [handles count]; i < max; i++)
        {
            temp = handles[i];
            if(temp.code == code)
            {
                [temp.target performSelector:temp.action withObject:[[EPetNetData alloc]init:code dataValue:data]];
                //free memory;
                delete [] data;
                break;
            }
        }
    }];
}

+(void)subcribeResponseHandle:(short)code target:(id)target action:(SEL)action
{
    [handles addObject:[[handleWraper alloc]init:code target:target action:action]];
}
+(void)unsubcribeResponseHandle:(short)code
{
    handleWraper * temp;
    for(int i = [handles count]-1; i >= 0; i--)
    {
        temp = handles[i];
        if(temp.code == code)
        {
            [handles removeObjectAtIndex:i];
            break;
        }
    }
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //connect to net.
    NetFacade::GetInstance()->connect((char*)"192.168.1.139", 29001);
    NetFacade::GetInstance()->subscribeResponsHandle(-1, handleResponse);
    
    handles = [[NSMutableArray alloc]init];
    
    self.mapManager = [[BMKMapManager alloc] init];
    if([self.mapManager start:@"fhshEiSxp3n45QHq7dz5YpRF" generalDelegate:nil] == true)
        NSLog(@"baidu map is ok");
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    //add rootview.
    EPetRootViewController *rootView = [[EPetRootViewController alloc] init];
    
    self.window.rootViewController = rootView;
    
    //navigation.
    self.navigationController = [[UINavigationController alloc]init];
    //self.navigationController.delegate=self;
    [self.navigationController pushViewController:rootView animated:YES];
    [self.window addSubview:self.navigationController.view];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:40/255.0 green:147/255.0 blue:248/255.0 alpha:0.5];

    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
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
@end
