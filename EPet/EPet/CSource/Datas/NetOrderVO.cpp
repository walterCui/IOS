//
//  NetOrderVO.cpp
//  EPet
//
//  Created by walter on 14-10-16.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#include "NetOrderVO.h"

NetRequestOrderListVO::NetRequestOrderListVO()
{
    msgId = requesCode::getOrderList;
}

int NetRequestOrderListVO::serialization(Byte *data)
{
    int i = NetDataBase::serialization(data);
    i += Converter::toBytes(data, i, NetSeesion::GetUID());
    i += Converter::toBytes(data, i, (short)1);//scoretype.
    return  i;
}

int NetRequestOrderListVO::deserialization(Byte *data, int offset)
{
    int index = NetDataBase::deserialization(data, offset);
    orderCount = Converter::getShort(data, index);
    if(orderCount > 0)
    {
        orders = new NetOrderVO[orderCount];
        
        for(int j = 0; j < orderCount; j++)
        {
            orders[j].order_id = Converter::getInt(data, index);
            orders[j].order_paied = Converter::getInt(data, index);
            orders[j].uin_customer = Converter::getInt64(data, index);
            
            orders[j].uin_worker = Converter::getInt64(data, index);
            
            orders[j].service_type = Converter::getInt(data, index);
            orders[j].service_id = Converter::getInt(data, index);
            orders[j].service_start_time = Converter::getInt(data, index);
            
            orders[j].worker_state = Converter::getInt(data, index);
            orders[j].order_state = Converter::getInt(data, index);
            
            orders[j].customer_evaluation = Converter::getInt(data, index);
            orders[j].customer_sue = Converter::getInt(data, index);

            orders[j].order_desc = Converter::getString(data, index);
            orders[j].customer_evaluation_desc = Converter::getString(data, index);
            orders[j].customer_sue_desc = Converter::getString(data, index);

        }
    }
    return  index;
}

NetCreateOrderVO::NetCreateOrderVO()
{
    msgId = requesCode::createOrder;
}

NetCreateOrderVO::NetCreateOrderVO(unsigned long long workerIdP,int serviceTypeP,int serviceIdP,int startTimeP,char *desP)
{
    msgId = requesCode::createOrder;
    workerId = workerIdP;
    serviceType = serviceTypeP;
    serviceId = serviceIdP;
    startTime = startTimeP;
    strcpy(des, desP);
}

int NetCreateOrderVO::serialization(Byte *data)
{
    int i = NetDataBase::serialization(data);
    i += Converter::toBytes(data, i, NetSeesion::GetUID());
    i += Converter::toBytes(data, i, workerId);
    i += Converter::toBytes(data, i, serviceType);
    i += Converter::toBytes(data, i, serviceId);
    i += Converter::toBytes(data, i, startTime);
    i += Converter::toBytes(data, i, des);
    return  i;
}

int NetCreateOrderVO::deserialization(Byte *data, int offset)
{
    int index = NetDataBase::deserialization(data, offset);
    return  index;
}