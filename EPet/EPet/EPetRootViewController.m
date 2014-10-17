//
//  EPetRootViewController.m
//  EPet
//
//  Created by walter on 14-10-10.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#import "EPetRootViewController.h"
#import "HomeViewController.h"
#import "EPetPlayerInfoViewController.h"
#import "EPetMyOrderViewController.h"
#import "EPetCustomerServiceViewController.h"
#import "EPetSignupViewController.h"
#import "EPetAppDelegate.h"
#import "NetAccountVO.h"

@interface EPetRootViewController ()
@property NSInteger _tabbarIndex;
@end


@implementation EPetRootViewController

static EPetRootViewController *_instance;

+(instancetype)instance
{
    return _instance;
}

-(instancetype) init
{
    self.isSignin = NO;
    _instance = self;
    return [super init];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    HomeViewController *home = [[HomeViewController alloc] init];
    //UINavigationController *home = [[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]];
    
    EPetMyOrderViewController *myOrder = [[EPetMyOrderViewController alloc] init];
    EPetPlayerInfoViewController *playerInfo = [[EPetPlayerInfoViewController alloc] init];
    EPetCustomerServiceViewController *cs = [[EPetCustomerServiceViewController alloc]init];
    //[cs setModalPresentationStyle: UIModalPresentationPopover];
    self.viewControllers = [[NSArray alloc] initWithObjects:home, myOrder,playerInfo, cs,nil];
    
    //self.selectedIndex = 0;
    [self.tabBar setTintColor:[UIColor redColor]];
   
    //set tabbarItem.
    UITabBarItem *item;
    NSArray *barNames = [[NSArray alloc]initWithObjects:@"首页",@"订单",@"我的",@"客服", nil];
    NSArray *barImage = [[NSArray alloc]initWithObjects:[UIImage imageNamed:@"But_ZhuYe_normal.PNG"],[UIImage imageNamed:@"But_DingDan_normal.PNG"],[UIImage imageNamed:@"But_WoDe_normal.PNG"],[UIImage imageNamed:@"But_DianHua_normal.PNG"], nil];
    for(int i = 0; i < 4; i++)
    {
        item = [self.tabBar.items objectAtIndex:i];
        item.title = [barNames objectAtIndex:i];
        item.tag = i;
        [item setImage:[barImage objectAtIndex:i]];
    }
    
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [EPetAppDelegate subcribeResponseHandle:requesCode::signin  target:self action:@selector(handleResponse:)];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [EPetAppDelegate unsubcribeResponseHandle:requesCode::signin];
    [super viewWillDisappear:animated];
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if(viewController.tabBarItem.tag == 3)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"服务时间为09:00 － 18:00" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫",nil];
        
        [alert show];
        return NO;
    }
    else if(viewController.tabBarItem.tag == 2 || viewController.tabBarItem.tag == 1)
    {
        if(self.isSignin)
            return  YES;
        else if(![EPetCookie instance].hasAccount)
        {
            EPetSignupViewController* s = [[EPetSignupViewController alloc] init:viewController.tabBarItem.tag];
            [self.navigationController pushViewController:s animated:YES];
            return  NO;
        }
        else
        {
            self._tabbarIndex = viewController.tabBarItem.tag;
            NetFacade::GetInstance()->signin([EPetCookie instance].phoneNumber.UTF8String, [EPetCookie instance].pwd.UTF8String);
        }
    }
    return YES;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:10086"]];
        UIWebView *phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
        [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
    }
}

-(void)handleResponse:(EPetNetData*)data
{
    if(data == NULL)
        return;
    AccountVO *vo = new AccountVO();
    vo->deserialization(data.data, 0);
    switch (data.code) {
        case requesCode::signin:
            if(vo->ReturnCode == 0)
            {
                self.selectedIndex = self._tabbarIndex;
                self.isSignin = YES;
            }
            else
            {
                [[EPetCookie instance] clear];
                EPetSignupViewController* s = [[EPetSignupViewController alloc] init:self._tabbarIndex];
                [self.navigationController pushViewController:s animated:YES];
            }
            break;
        default:
            break;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
