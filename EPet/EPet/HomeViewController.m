//
//  HomeViewController.m
//  EPet
//
//  Created by walter on 14-9-10.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#import "HomeViewController.h"
#import "EPetChooseTimeViewController.h"
#import "EPetOrder.h"
#include "NetFacade.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *_beauty;
@property (weak, nonatomic) IBOutlet UIButton *_kennels;
@property (weak, nonatomic) IBOutlet UITabBar *_tabBar;
@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UITabBarController *d;
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

-(void)viewWillAppear:(BOOL)animated
{
    self._tabBar.selectedItem = [self._tabBar.items objectAtIndex:0];
    self._tabBar.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    self._tabBar.delegate = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    switch (item.tag) {
        case 0:
            break;
            
        default:
            break;
    }}

- (IBAction)clickbutton:(id)sender {
    if (sender==self._beauty) {
        
        //NetFacade::GetInstance()->connect((char*)"192.168.1.139", 12000);
        [EPetOrder createOrder:OrderTypeBeauty];
        EPetChooseTimeViewController * chooseTime = [[EPetChooseTimeViewController  alloc] init];
        [self.navigationController pushViewController:chooseTime animated:YES];
    }
    else if (sender==self._kennels) {
        [EPetOrder createOrder:OrderTypeKennels];
        EPetChooseTimeViewController * chooseTime = [[EPetChooseTimeViewController  alloc] init];
        [self.navigationController pushViewController:chooseTime animated:YES];
    }

}
@end
