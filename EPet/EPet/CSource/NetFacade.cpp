//
//  NetFacade.cpp
//  EPet
//
//  Created by walter on 14-9-9.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#include "NetFacade.h"

/*=========variables=============*/
NetFacade* NetFacade::instance = new NetFacade();
/*=========variables=============*/

/*=========Method=============*/
NetFacade::NetFacade()
{
    client = new NetClient();
}

NetFacade::~NetFacade()
{
    delete client;
}

void NetFacade::updateNet()
{
    while (true) {
        instance ->client->update();
    }
}

bool NetFacade::isConnected()
{
    return _isConnected;
}

void NetFacade::connect(char *ip, int port)
{
    _isConnected = client->connect(ip, port);
    if(_isConnected)
    {
        client->delegate = this;
        client->send(AccountVO::create(3,NULL,NULL));
        clientThread = std::thread(updateNet);
    }
}
void NetFacade::disconnect()
{
    client->close();
    _isConnected = false;
}

void NetFacade::signup(const char *name,const  char *pwd)
{
    if(_isConnected)
    {
        client->send(AccountVO::create(0,name,pwd));
    }
}
void NetFacade::signin(const char *name,const  char *pwd)
{
    if(_isConnected)
    {
        client->send(AccountVO::create(1,name,pwd));
    }
}

void NetFacade::getBeauticianList()
{
    if(_isConnected)
    {
        client->send(new NetRequestBeauticianVO());
    }

}

void NetFacade::getOrderList()
{
    if(_isConnected)
    {
        client->send(new NetRequestOrderListVO());
    }
}

void NetFacade::createOrder(unsigned long long workerId,int serviceType,int serviceId,int startTime,char *des)
{
    if(_isConnected)
    {
        client->send(new NetCreateOrderVO(workerId,serviceType,serviceId,startTime,des));
    }
}

//code = -1 is all.
void NetFacade::handleResponse(short code, Byte* data)
{
    if(data == NULL)
        return;
    
    if(code == 101)
    {
        //connect.
        AccountVO *vo = new AccountVO();
        vo->deserialization(data, 0);
        return;
    }
    if(handleResponseList[-1] != NULL)
    {
        handleResponseList[-1](code,data);
        return;
    }
    
    std::map<short, handleDelegate>::iterator iter = handleResponseList.find(code);
    if(iter  == handleResponseList.end())
        return;
    iter->second(code,data);
}
void NetFacade::handleEvent(short code, Byte* data)
{
    
}
void NetFacade::subscribeResponsHandle(short code, handleDelegate handle)
{
    //client->subscribeResponsHandle(<#handleDelegate value#>)
    if(handle == NULL)
        return;
    
    if(handleResponseList.find(code)  != handleResponseList.end())
        return;
    
    handleResponseList.insert(std::pair<short, handleDelegate>(code,handle));
}
/*=========Method=============*/
