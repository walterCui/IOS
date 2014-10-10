//
//  EPetChooseTimeViewController.m
//  EPet
//
//  Created by walter on 14-9-19.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#import "EPetChooseTimeViewController.h"
#import "EPetLocationView.h"
#import "EPetTableViewController.h"
#import "EPetSeniorserverViewController.h"
#import "EPetOrder.h"

@interface EPetChooseTimeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *_location;
@property (weak, nonatomic) IBOutlet UIButton *_Ok;
@property (weak, nonatomic) IBOutlet UITextField *_locationDetail;
@property (strong, nonatomic) IBOutlet EPetDatePick *eptDate;
@property (weak, nonatomic) IBOutlet UITextField *_dateInput;
@property (weak, nonatomic) IBOutlet EPetLocationView *_baiduLoaction;
@end

@implementation EPetChooseTimeViewController

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
    
    //[self._dateInput addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventEditingDidBegin];
    
    self._dateInput.placeholder = @"请选择时间";
    EPetDatePick *datePick =[[EPetDatePick alloc]initWithFrame:CGRectMake(0, 0, 320, 240)];
    datePick.pickOkDelegate = self;
    self._dateInput.inputView = datePick;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"选择时间";
    EPetOrder *order = [EPetOrder getOrder];
    if(order.type == OrderTypeBeauty)
    {
        [self._Ok setTitle:@"选择美容师" forState:UIControlStateNormal];
    }
    else if (order.type == OrderTypeKennels)
    {
        [self._Ok setTitle:@"选择寄养所" forState:UIControlStateNormal];
    }
    [self._baiduLoaction viewWillAppear];
    
    [self._baiduLoaction startLocation];
    self._baiduLoaction.locationDelgate = self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.title = @"";
    self._baiduLoaction.locationDelgate = nil;
    [self._baiduLoaction stopLocation];
    [self._baiduLoaction viewWillDisappear];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    NSLog(@"dealloc");
}

- (IBAction)editDone:(id)sender {
    if(sender == self._locationDetail)
        [sender resignFirstResponder];
}
- (IBAction)chooseSeniorserver:(id)sender {
    
    if ([self._dateInput.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"请选择时间" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
    }
    else if ([self._locationDetail.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"请填写详细地址" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
    }

    else
    {
        EPetOrder *order = [EPetOrder getOrder];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        order.time = [[OrderDate alloc]init:[dateFormatter dateFromString:self._dateInput.text]];
        //order.time = [dateFormatter dateFromString:self._dateInput.text];
        //NSTimeInterval timeZoneOffset = [[NSTimeZone systemTimeZone] secondsFromGMT];
        //order.time = [order.time dateByAddingTimeInterval:timeZoneOffset];
        NSLog(@"%@",order.time);
        order.location = [[NSString alloc] initWithFormat:@"%@ %@", self._location.text,self._locationDetail ];
        EPetTableViewController * chooseSeniorServer = [[EPetSeniorserverViewController  alloc] initwithNib];
        [self.navigationController pushViewController:chooseSeniorServer animated:YES];
    }
}

-(void)pickSetDateOk:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute
{
    self._dateInput.text = [[NSString alloc] initWithFormat:@"%d-%d-%d %d:%d",year,month,day,hour,minute];
    
    [self._dateInput resignFirstResponder];
}

-(void)setCurrentAddress:(NSString *)address
{
    self._location.text = address;
}
@end
