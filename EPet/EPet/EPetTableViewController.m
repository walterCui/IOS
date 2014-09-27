//
//  EPetTableViewController.m
//  EPet
//
//  Created by walter on 14-9-23.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#import "EPetTableViewController.h"
#import "EPetWaiterModel.h"
#import "EPetTableViewCell.h"
#import "EPetOrder.h"

@interface EPetTableViewController ()
@property (weak, nonatomic) IBOutlet UITableView *_tableView;
@property NSMutableArray *_SeniorserverArray;
@property NSString *_identifier;
@end

@implementation EPetTableViewController

-(instancetype)initwithNib
{
    return [self initWithNibName:@"EPetTableViewController" bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self._identifier = @"tableSeniorserverCell";
    self._SeniorserverArray = [[NSMutableArray alloc]init];
    [self._tableView registerNib:[UINib nibWithNibName:@"EPetTableViewCell" bundle:nil] forCellReuseIdentifier:self._identifier];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self freshView];
    self.title = @"选择护理师";
    self._tableView.dataSource = self;
    self._tableView.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.title = @"";
    self._tableView.delegate = nil;
    self._tableView.dataSource = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)freshView
{
    [self._SeniorserverArray removeAllObjects];
    
    EPetWaiterModel *item;
    
    for(int i  = 0; i < 40 ; i++)
    {
        item = [[EPetWaiterModel alloc] init];
        item.serviceId = 1;
        item.name = [[NSString alloc]initWithFormat:@"%d",i ];
        
        [self._SeniorserverArray addObject:item];
    }
    NSLog(@"sds%d", [self._SeniorserverArray count]);

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self._SeniorserverArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    EPetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self._identifier forIndexPath:indexPath];
    // Configure the cell...
    EPetWaiterModel *model = [self._SeniorserverArray objectAtIndex:indexPath.row];
    cell.name.text = model.name;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EPetWaiterModel *model = [self._SeniorserverArray objectAtIndex:indexPath.row];
    EPetOrder *order = [EPetOrder getOrder];
    order.serviceUid = model.serviceId;
    NSLog(@"click %@",model.name);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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
