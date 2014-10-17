//
//  EPetSignupViewController.m
//  EPet
//
//  Created by walter on 14-9-25.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#import "EPetSignupViewController.h"
#import "EPetRootViewController.h"
#import "EPetAppDelegate.h"
#import "NetAccountVO.h"
#import "EPetCookie.h"

@interface EPetSignupViewController ()
@property (weak, nonatomic) IBOutlet UITextField *_number;
@property (weak, nonatomic) IBOutlet UITextField *_password;
@property (weak, nonatomic) IBOutlet UIButton *_setPwd;
@property (weak, nonatomic) IBOutlet UISegmentedControl *_segmented;
@property (weak, nonatomic) IBOutlet UIButton *_ok;
@property (weak, nonatomic) IBOutlet UIView *_identifyingCodeView;
@property (weak, nonatomic) IBOutlet UIView *_pwdView;
@property CGRect _pwdViewInitPos;
@property CGRect _codeViewInitPos;
@property NSInteger _forTabbar;
@end

@implementation EPetSignupViewController

-(instancetype)init
{
    self._forTabbar = -1;
    return [super init];
}
-(instancetype)init:(NSUInteger)forTabbar
{
    self._forTabbar = forTabbar;
    return [super init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self._segmented addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    self._pwdViewInitPos = self._pwdView.frame;
    self._codeViewInitPos = self._identifyingCodeView.frame;
    [self segmentAction:self._segmented];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [EPetAppDelegate subcribeResponseHandle:requesCode::signin  target:self action:@selector(handleResponse:)];
    [EPetAppDelegate subcribeResponseHandle:requesCode::signup  target:self action:@selector(handleResponse:)];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [EPetAppDelegate unsubcribeResponseHandle:requesCode::signin];
    [EPetAppDelegate unsubcribeResponseHandle:requesCode::signup];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)editDone:(id)sender {
    if(sender == self._password)
        [sender resignFirstResponder];
    else
    {
        [self._number resignFirstResponder];
    }
}
- (IBAction)okClick:(id)sender {
    
    [[EPetCookie instance] update:self._number.text password:self._password.text];
    switch (self._segmented.selectedSegmentIndex) {
        case 0:
            NetFacade::GetInstance()->signin([self._number.text UTF8String], self._password.text.UTF8String);
            break;
        case 1:
            NetFacade::GetInstance()->signup([self._number.text UTF8String], self._password.text.UTF8String);
            break;
        default:
            break;
    }
}
-(void)segmentAction:(UISegmentedControl *)seg
{
    switch (seg.selectedSegmentIndex) {
        case 0:
            self.title = @"登录";
            self._pwdView.frame = self._pwdViewInitPos;
            [self._identifyingCodeView setHidden:YES];
            [self._setPwd setHidden:NO];
            break;
        case 1:
            self.title = @"注册";
            self._pwdView.frame = self._codeViewInitPos;
            self._identifyingCodeView.frame = self._pwdViewInitPos;
            [self._identifyingCodeView setHidden:NO];
            [self._setPwd setHidden:YES];
            break;
        default:
            break;
    }
}

-(void)handleResponse:(EPetNetData*)data
{
    if(data == NULL)
        return;
    AccountVO *vo = new AccountVO();
    vo->deserialization(data.data, 0);
    switch (data.code) {
        case requesCode::signup:
            if(vo->ReturnCode == 0)
            {
                NetFacade::GetInstance()->signin([EPetCookie instance].phoneNumber.UTF8String, [EPetCookie instance].pwd.UTF8String);
            }
            else
            {
                [[EPetCookie instance] clear];
            }
            break;
        case requesCode::signin:
            if(vo->ReturnCode == 0)
            {
                [self.navigationController popViewControllerAnimated:YES];
                [EPetRootViewController instance].isSignin = YES;
                if(self._forTabbar >= 0)
                    [EPetRootViewController instance].selectedIndex = self._forTabbar;
            }
            else
            {
                [[EPetCookie instance] clear];
            }
            break;
        default:
            break;
    }
}
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    return  YES;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
