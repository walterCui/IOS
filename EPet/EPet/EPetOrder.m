//
//  EPetOrder.m
//  EPet
//
//  Created by walter on 14-9-25.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#import "EPetOrder.h"

@implementation EPetOrder

static EPetOrder *_order;

+(EPetOrder *)createOrder:(OrderType)orderType
{
    switch (orderType) {
        case OrderTypeBeauty:
            _order = [[EPetOrderBeauty alloc]init];
            break;
            
        default:
            break;
    }
    
    return _order;
}

+(EPetOrder *)getOrder
{
    return _order;
}
@end


@implementation OrderDate

-(NSString *)description
{
    return [[NSString alloc] initWithFormat:@"%d-%d-%d %d:%d",self.year,self.month,self.day,self.hour,self.minute ];
}

-(instancetype)init:(NSInteger)yearValue month:(NSInteger)monthValue day:(NSInteger)dayValue hour:(NSInteger)hourValue minute:(NSInteger)minuteValue
{
    self.year = yearValue;
    self.month = monthValue;
    self.day = dayValue;
    self.hour = hourValue;
    self.minute = minuteValue;
    
    return [self init];
}

-(instancetype)init:(NSDate *)date
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents * com = [cal components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit| NSMinuteCalendarUnit fromDate:date];
    return [self init:[com year] month:[com month] day:[com day] hour:[com hour] minute:[com minute]];
}

@end

@implementation EPetOrderBeauty



@end