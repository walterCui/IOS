//
//  EPetRootViewController.m
//  EPet
//
//  Created by walter on 14-10-10.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#import "EPetRootViewController.h"
#import "HomeViewController.h"
#import "EPetSignupViewController.h"
#import "EPetMyOrderViewController.h"
#import "EPetCustomerServiceViewController.h"

@interface EPetRootViewController ()

@end

@implementation EPetRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HomeViewController *homeView = [[HomeViewController alloc] init];
    UINavigationController *home = [[UINavigationController alloc] initWithRootViewController:homeView];
    //HomeViewController *home = [[HomeViewController alloc] init];
    EPetMyOrderViewController *myOrder = [[EPetMyOrderViewController alloc] init];
    EPetSignupViewController *signup = [[EPetSignupViewController alloc] init];
    EPetCustomerServiceViewController *cs = [[EPetCustomerServiceViewController alloc]init];
    //[cs setModalPresentationStyle: UIModalPresentationPopover];
    self.viewControllers = [[NSArray alloc] initWithObjects:home, myOrder,signup, cs,nil];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
