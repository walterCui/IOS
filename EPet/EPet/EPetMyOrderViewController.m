//
//  EPetMyOrderViewController.m
//  EPet
//
//  Created by walter on 14-10-11.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#import "EPetMyOrderViewController.h"
#import "EPetOrderMode.h"
#import "EPetOrderInfoTableViewCell.h"
#import "EPetAppDelegate.h"

@interface EPetMyOrderViewController ()
@property (weak, nonatomic) IBOutlet UITableView *_tableView;
@property NSString *_identifier;
@property NSMutableArray *_orders;
@end

@implementation EPetMyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self._orders = [[NSMutableArray alloc]init];
    self._identifier = @"orderCell";
    [self._tableView registerNib:[UINib nibWithNibName:@"EPetOrderInfoTableViewCell" bundle:nil] forCellReuseIdentifier:self._identifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateOrders];
    self._tableView.dataSource = self;
    self._tableView.delegate = self;
    
    NetFacade::GetInstance()->getOrderList();
    [EPetAppDelegate subcribeResponseHandle:requesCode::getOrderList target:self action:@selector(handleResponse:)];
}

-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [EPetAppDelegate unsubcribeResponseHandle:requesCode::getOrderList];
    self._tableView.delegate = nil;
    self._tableView.dataSource = nil;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [super viewWillDisappear:animated];
}

#pragma mark -table view.
-(void)updateOrders
{
    [self._orders removeAllObjects];
    EPetOrderMode *model;
    for(int i = 0; i < 10; i++)
    {
        model = [[EPetOrderMode alloc]init];
        [self._orders addObject:model];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self._orders count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    EPetOrderInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self._identifier forIndexPath:indexPath];
    // Configure the cell...
    EPetOrderMode *model = [self._orders objectAtIndex:indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EPetOrderMode *model = [self._orders objectAtIndex:indexPath.row];
    
    //show order info.
//    EPetOrderViewController *ovc = [[EPetOrderViewController alloc] init];
//    [self.navigationController pushViewController:ovc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76;
}


-(void)handleResponse:(EPetNetData*)data
{
    if(data == NULL)
        return;
    
    switch (data.code) {
        case requesCode::getOrderList:
        {
            NetRequestOrderListVO vo;
            vo.deserialization(data.data, 0);
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
