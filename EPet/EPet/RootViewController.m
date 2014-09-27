//
//  RootViewController.m
//  EPet
//
//  Created by walter on 14-9-10.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#import "RootViewController.h"
#import "EPetChooseTimeViewController.h"
#import "EPetOrder.h"
#include "NetFacade.h"

@interface RootViewController ()
@property (weak, nonatomic) IBOutlet UIButton *_beauty;
@property (weak, nonatomic) IBOutlet UITabBar *_tabBar;
@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.toolbar.frame = CGRectMake(0, [[UIScreen mainScreen]bounds].size.height - 56, [[UIScreen mainScreen]bounds].size.width, 56);
    
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
    [self._tabBar setTintColor:[UIColor redColor]];
    //self.view.autoresizingMask =
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickbutton:(id)sender {
    if (sender==self._beauty) {
        
        NetFacade::GetInstance()->connect((char*)"192.168.1.139", 12000);
        return;
        [EPetOrder createOrder:OrderTypeBeauty];
        EPetChooseTimeViewController * chooseTime = [[EPetChooseTimeViewController  alloc] init];
        [self.navigationController pushViewController:chooseTime animated:YES];
    }
}
@end
