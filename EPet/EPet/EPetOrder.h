//
//  EPetOrder.h
//  EPet
//
//  Created by walter on 14-9-25.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, OrderType)
{
    OrderTypeBeauty = 0
};
@class OrderDate;

//订单base.
@interface EPetOrder : NSObject

//用来标记用户选择的那位美容师或托管所.
@property NSInteger serviceUid;
@property OrderDate *time;
@property NSString *location;
+(EPetOrder *)createOrder:(OrderType)orderType;
+(EPetOrder *)getOrder;
@end

//时间.
@interface OrderDate : NSObject
@property NSInteger year;
@property NSInteger month;
@property NSInteger day;
@property NSInteger hour;
@property NSInteger minute;
-(instancetype)init:(NSInteger) yearValue month:(NSInteger)monthValue day:(NSInteger)dayValue hour:(NSInteger)hourValue minute:(NSInteger)minuteValue;
-(instancetype)init:(NSDate *)date;
@end

//美容师订单.
@interface EPetOrderBeauty : EPetOrder

@end
