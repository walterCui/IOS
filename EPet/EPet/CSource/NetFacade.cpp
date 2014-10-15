//
//  NetFacade.cpp
//  EPet
//
//  Created by walter on 14-9-9.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#include "NetFacade.h"
#include "NetAccountVO.h"

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
        client->send(AccountVO::create(3,NULL,NULL));
        clientThread = std::thread(updateNet);
    }
}
void NetFacade::disconnect()
{
    client->close();
    _isConnected = false;
}

void NetFacade::handleResponse(short code, Byte* data)
{
    if(data == NULL)
        return;
    
    std::map<short, handleDelegate>::iterator iter = handleResponseList.find(code);
    if(iter  == handleResponseList.end())
        return;
    iter->second(code,data);
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
