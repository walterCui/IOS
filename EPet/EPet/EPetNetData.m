//
//  EPetNetData.m
//  EPet
//
//  Created by walter on 14-10-16.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#import "EPetNetData.h"

@implementation EPetNetData
-(instancetype)init:(short)codeValue dataValue:(Byte*) dataValue
{
    self.data = dataValue;
    self.code = codeValue;
    
    return [super init];
}
@end
