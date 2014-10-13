//
//  NetDataBase.h
//  EPet
//
//  Created by walter on 14-10-13.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#ifndef __EPet__NetDataBase__
#define __EPet__NetDataBase__

#include <stdio.h>
#include "IDataWraper.h"
#include "NetSession.h"

class NetDataBase : IDataWraper
{
public:
    //序列化.
    //将数据写入到data中并返回写入的长度.
    virtual int serialization(Byte data[]);
    //反序列化.
    virtual int deserialization(Byte data[], int offset);
};
#endif /* defined(__EPet__NetDataBase__) */
