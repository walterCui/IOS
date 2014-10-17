//
//  EPetDatePick.m
//  EPet
//
//  Created by walter on 14-9-22.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#import "EPetDatePick.h"

@interface EPetDatePick()

//@property UIDatePicker *_datePick;
@property UIPickerView *_datePick;
@property NSMutableArray *_pickerDay;
@property NSMutableArray *_pickerHour;
@property NSMutableArray *_pickerMinute;
@property NSMutableArray *_pickerHourDic;
@property UIButton *_ok;

@property NSInteger _currentDay;
@property NSInteger _currentyear;
@property NSInteger _currentMonth;

@end


@implementation EPetDatePick

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self initPickData];
       
        [self addViews:frame];
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

}

-(void)initPickData
{
    NSInteger numInMonth = [self numberofCurrentMonth];
    
    NSDateComponents * dateCom = [self getDataComponent];
    
    NSInteger day = [dateCom day];
    
    self._currentyear = [dateCom year];
    self._currentMonth = [dateCom month];
    self._currentDay = day;
    
    //set day.
    self._pickerDay = [[NSMutableArray alloc] init];
    for(int i = 0; i < 4; i++)
    {
        [self._pickerDay addObject:[NSString stringWithFormat:@"%d",day]];
        day = day + 1;
        if(day > numInMonth)
            day = 1;
    }
    
    //set hour.
    self._pickerHour = [[NSMutableArray alloc] init];
    for(int i = 1; i <= 24; i++)
    {
        [self._pickerHour addObject:[NSString stringWithFormat:@"%d",i]];
    }
    self._pickerHourDic = [[NSMutableArray alloc]init];
    [self._pickerHourDic addObject:self._pickerHour];
    //当天时间不能大于24.
    self._pickerHour = [[NSMutableArray alloc] init];
    for(int i = [dateCom hour]; i <= 24; i++)
    {
        [self._pickerHour addObject:[NSString stringWithFormat:@"%d",i]];
    }
    [self._pickerHourDic addObject:self._pickerHour];
    
    
    //set minute.
    self._pickerMinute = [[NSMutableArray alloc] init];
    [self._pickerMinute addObject:@"0"];
    [self._pickerMinute addObject:@"30"];
}

-(void)addViews:(CGRect)rect
{
    self._datePick = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height - 30)];
    self._datePick.delegate = self;
    self._datePick.dataSource = self;
    [self addSubview:self._datePick];
    
    
    self._ok = [[UIButton alloc]initWithFrame:CGRectMake(rect.size.width/2-20, rect.size.height - 30, 40, 30)];
    [self._ok setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self._ok setTitleColor:[UIColor whiteColor] forState:(UIControlStateHighlighted)];
    self._ok.layer.borderWidth = 1;
    [self._ok setTitle:@"确定" forState:UIControlStateNormal];
    [self._ok addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self._ok];
}

-(IBAction) done:(UIButton *)ok
{
    NSInteger selectedCom1 = [self._datePick selectedRowInComponent:0];
    NSInteger selectedCom2 = [self._datePick selectedRowInComponent:1];
    NSInteger selectedCom3 = [self._datePick selectedRowInComponent:2];
    
    NSInteger selectedMonth = self._currentMonth;
    NSInteger selectedYear = self._currentyear;
    NSInteger selectedDay = [[self._pickerDay objectAtIndex:selectedCom1] integerValue];
    if(selectedDay < self._currentDay)
        selectedMonth += 1;
    if(selectedMonth > 12)
    {
        selectedYear += 1;
        selectedMonth = 1;
    }
    
    NSInteger selectedHour = [[self._pickerHour objectAtIndex:selectedCom2] integerValue];
    NSInteger selectedMinute = [[self._pickerMinute objectAtIndex:selectedCom3] integerValue];
    if(self.pickOkDelegate != NULL)
        [self.pickOkDelegate pickSetDateOk:selectedYear month:selectedMonth day:selectedDay hour:selectedHour minute:selectedMinute];
    
}

-(NSDate*) getCurrentData
{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localDate = [date dateByAddingTimeInterval:interval];
    return localDate;
}

-(NSDateComponents *) getDataComponent
{
    NSDate *date = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents * com = [cal components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit| NSMinuteCalendarUnit fromDate:date];
    return com;
}

-(NSInteger)numberofCurrentMonth
{
    NSDate *today = [NSDate date];
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange days = [c rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:today];
    
    return days.length;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return (3);
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0)
        return [self._pickerDay count];
    else if(component == 1)
        return [self._pickerHour count];
    else
        return [self._pickerMinute count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == 0)
        return [self._pickerDay objectAtIndex:row];
    else if(component == 1)
        return [self._pickerHour objectAtIndex:row];
    else
        return [self._pickerMinute objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(component == 0)
    {
        if(row == 0)
        {
            self._pickerHour = [self._pickerHourDic objectAtIndex:1];
        }
        else
        {
            self._pickerHour = [self._pickerHourDic objectAtIndex:0];
        }
    
        [self._datePick selectRow:0 inComponent:1 animated:YES];
        [self._datePick reloadComponent:1];
    }

}
-(void)dealloc
{
    NSLog(@"epet data pick is dealloc");
    self._datePick = nil;
    self._ok = nil;
}
@end
