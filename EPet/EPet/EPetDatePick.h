//
//  EPetDatePick.h
//  EPet
//
//  Created by walter on 14-9-22.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EpetDatePickDelegate;

@interface EPetDatePick : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,assign) id<EpetDatePickDelegate> pickOkDelegate;
@end

@protocol EpetDatePickDelegate <NSObject>

-(void) pickSetDateOk:(NSInteger)year month:(NSInteger) month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute;
@end
