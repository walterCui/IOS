//
//  EPetCookie.h
//  EPet
//
//  Created by walter on 14-10-14.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EPetCookie : NSObject
@property NSString *phoneNumber;
@property NSString *pwd;
@property (readonly) BOOL hasAccount;
+(instancetype) instance;
-(void)updateWithChar:(char *)number password:(char*)password;
-(void)update:(NSString *)number password:(NSString *)password;
-(void)clear;
@end
