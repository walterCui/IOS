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
        clientThread = std::thread(updateNet);
}
void NetFacade::disconnect()
{
    client->close();
    _isConnected = false;
}
/*=========Method=============*/
