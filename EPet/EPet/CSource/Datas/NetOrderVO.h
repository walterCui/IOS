//
//  NetOrderVO.h
//  EPet
//
//  Created by walter on 14-10-16.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#ifndef __EPet__NetOrderVO__
#define __EPet__NetOrderVO__

#include <stdio.h>
#include "NetDataBase.h"

class NetOrderVO
{
public:
    int order_id;
    int order_paied;
    long long uin_customer;
    long long uin_worker;
    int service_type;
    int service_id;
    int service_time_type;
    int service_start_time;
    int worker_state;
    int order_state;
    char *order_desc;
    int customer_evaluation ;
    char *customer_evaluation_desc;
    int customer_sue ;
    char *customer_sue_desc;
};

class NetRequestOrderListVO:public NetDataBase
{
public:
    NetRequestOrderListVO();
    //序列化.
    //将数据写入到data中并返回写入的长度.
    virtual int serialization(Byte data[]);
    //反序列化.
    virtual int deserialization(Byte data[], int offset);
    
public:
    int orderCount;
    NetOrderVO *orders;
};

class NetCreateOrderVO:public NetDataBase
{
public:
    NetCreateOrderVO();
    NetCreateOrderVO(unsigned long long workerIdP,int serviceTypeP,int serviceIdP,int startTimeP,char *desP);
    //序列化.
    //将数据写入到data中并返回写入的长度.
    virtual int serialization(Byte data[]);
    //反序列化.
    virtual int deserialization(Byte data[], int offset);
private:
    unsigned long long workerId;
    int serviceType;
    int serviceId;
    int startTime;
    char des[256];
};
#endif /* defined(__EPet__NetOrderVO__) */
