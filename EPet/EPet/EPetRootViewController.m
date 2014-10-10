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

@interface EPetRootViewController ()
@property (weak, nonatomic) IBOutlet UITabBar *_tabbar;

@end

@implementation EPetRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HomeViewController *home = [[HomeViewController alloc] init];
    
    self.viewControllers = [[NSArray alloc] initWithObjects:home, nil];
    
    self.selectedIndex = 0;
    // Do any additional setup after loading the view from its nib.
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.tabBar setTintColor:[UIColor redColor]];
    //self.tabBar.items = [[NSArray alloc] initWithObjects:[self._tabbar.items objectAtIndex:0], nil ];
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    //self._tabbar.selectedItem = [self._tabBar.items objectAtIndex:0];
}

-(void)viewWillDisappear:(BOOL)animated
{
    
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
