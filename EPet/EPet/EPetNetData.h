//
//  EPetNetData.h
//  EPet
//
//  Created by walter on 14-10-16.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EPetNetData : NSObject
@property short code;
@property Byte *data;
-(instancetype)init:(short)codeValue dataValue:(Byte*) dataValue;
@end
