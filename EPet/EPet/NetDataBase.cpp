//
//  NetDataBase.cpp
//  EPet
//
//  Created by walter on 14-10-13.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#include "NetDataBase.h"
#include "Converter.h"

int NetDataBase::serialization(Byte *data)
{
    int i = 4; //set lenght;
    i += Converter::toBytes(data, i, 2);//seq.
    i += Converter::toBytes(data, i, NetSeesion::dialogId);
    i += Converter::toBytes(data, i, NetSeesion::uId);
    return i;
}

int NetDataBase::deserialization(Byte *data, int offset)
{
    offset += 8; //ignore seq and length;
    NetSeesion::dialogId = Converter::getInt(data, offset);
    NetSeesion::uId = Converter::getUInt64(data, offset);
    return  offset;
}