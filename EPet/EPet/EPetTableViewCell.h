//
//  EPetTableViewCell.h
//  EPet
//
//  Created by walter on 14-9-25.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPetTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UILabel *serviceCondition;

@end
