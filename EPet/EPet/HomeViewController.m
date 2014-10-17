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
@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)adfa:(id)sender
{
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //navigation.
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:40/255.0 green:147/255.0 blue:248/255.0 alpha:0.5];
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
