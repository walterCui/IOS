//
//  NetBeauticianVO.cpp
//  EPet
//
//  Created by walter on 14-10-16.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#include "NetBeauticianVO.h"

NetRequestBeauticianVO::NetRequestBeauticianVO()
{
    msgId = requesCode::getBeauticianList;
}

int NetRequestBeauticianVO::serialization(Byte *data)
{
    int i = NetDataBase::serialization(data);
    i += Converter::toBytes(data, i, NetSeesion::GetUID());
    i += Converter::toBytes(data, i, (short)1);//scoretype.
    return  i;
}

int NetRequestBeauticianVO::deserialization(Byte *data, int offset)
{
    int i = NetDataBase::deserialization(data, offset);
    return  i;
}