//
//  EPetCookie.m
//  EPet
//
//  Created by walter on 14-10-14.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#import "EPetCookie.h"

@interface EPetCookie()
@property BOOL _hasAccout;
@end

@implementation EPetCookie

static EPetCookie *_instance;

+(instancetype)instance
{
    if(_instance == NULL)
        _instance = [[EPetCookie alloc] init];
    return _instance;
}

-(BOOL)hasAccount
{
    return self._hasAccout;
}

-(instancetype)init
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    self.phoneNumber = [ud stringForKey:@"phoneT"];
    self.pwd = [ud stringForKey:@"pwd"];
    self._hasAccout = self.phoneNumber != NULL;
    return [super init];
}

-(void)updateWithChar:(char *)number password:(char *)password
{
    [self update:[[NSString alloc] initWithUTF8String:number] password:[[NSString alloc] initWithUTF8String:password]];
}
-(void)update:(NSString *)number password:(NSString *)password
{
    if([self.phoneNumber isEqualToString:number] && [self.pwd isEqualToString:password])
        return;
    self.phoneNumber = number;
    self.pwd = password;
    self._hasAccout = YES;
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    [ud setObject:self.phoneNumber forKey:@"phoneT"];
    [ud setObject:self.pwd forKey:@"pwd"];
    [ud synchronize];
}

-(void)clear
{
    self.phoneNumber = NULL;
    self.pwd = NULL;
    self._hasAccout = NO;
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
}
@end
