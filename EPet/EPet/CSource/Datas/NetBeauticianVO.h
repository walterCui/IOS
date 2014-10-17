//
//  NetBeauticianVO.h
//  EPet
//
//  Created by walter on 14-10-16.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#ifndef __EPet__NetBeauticianVO__
#define __EPet__NetBeauticianVO__

#include <stdio.h>
#include "NetDataBase.h"

class NetRequestBeauticianVO:public NetDataBase
{
public:
    NetRequestBeauticianVO();
    
    //序列化.
    //将数据写入到data中并返回写入的长度.
    virtual int serialization(Byte data[]);
    //反序列化.
    virtual int deserialization(Byte data[], int offset);
};

class NetBeauticianInfoVO
{
public:
    short index;
};
#endif /* defined(__EPet__NetBeauticianVO__) */
