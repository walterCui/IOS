//
//  EPetOrderViewController.m
//  EPet
//
//  Created by walter on 14-9-25.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#import "EPetOrderViewController.h"
#import "EPetRootViewController.h"
#import "EPetSignupViewController.h"
#import "EPetAppDelegate.h"

@interface EPetOrderViewController ()
@property (weak, nonatomic) IBOutlet UIButton *_ok;

@end

@implementation EPetOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [EPetAppDelegate subcribeResponseHandle:requesCode::createOrder target:self action:@selector(handleResponse:)];
    [EPetAppDelegate subcribeResponseHandle:requesCode::signin target:self action:@selector(handleResponse:)];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [EPetAppDelegate unsubcribeResponseHandle:requesCode::signin];
    [EPetAppDelegate unsubcribeResponseHandle:requesCode::createOrder];
    [super viewWillDisappear:animated];
}
- (IBAction)clickOk:(id)sender {
    if([EPetRootViewController instance].isSignin)
    {
        NetFacade::GetInstance()->createOrder(1, 1, 1, 1, (char*)"fijia");
    }
    else
    {
        if([EPetCookie instance].hasAccount)
        {
             NetFacade::GetInstance()->signin([EPetCookie instance].phoneNumber.UTF8String, [EPetCookie instance].pwd.UTF8String);
        }
        else
        {
            [self.navigationController pushViewController:[[EPetSignupViewController alloc] init] animated:YES];
        }
    }
}
-(void)handleResponse:(EPetNetData*)data
{
    if(data == NULL)
        return;
    
    switch (data.code) {
        case requesCode::createOrder:
        {
            NetCreateOrderVO vo;
            vo.deserialization(data.data, 0);
            if(vo.ReturnCode == 0)
            {
                //去支付.
            }
            break;
        }
        case requesCode::signin:
        {
            AccountVO vo;
            vo.deserialization(data.data, 0);
            if(vo.ReturnCode == 0)
                NetFacade::GetInstance()->createOrder(1, 1, 1, 1, (char*)"fijia");
            break;
        }
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
