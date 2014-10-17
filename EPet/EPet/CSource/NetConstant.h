//
//  NetConstant.h
//  EPet
//
//  Created by walter on 14-10-13.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#ifndef __EPet__NetConstant__
#define __EPet__NetConstant__

#include <stdio.h>
class requesCode
{
public:
    static const short signup = 163;
    
    static const short signin = 160;
    
    static const short signout = 102;
    
    static const short connect = 101;
    
    static const short getBeauticianList = 162;
    
    static const short getOrderList = 169;
    
    static const short createOrder = 170;
};
#endif /* defined(__EPet__NetConstant__) */
