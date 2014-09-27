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
        printf("1111\n");
        instance ->client->update();
    }
}

bool NetFacade::isConnected()
{
    return _isConnected;
}

void NetFacade::connect(char *ip, int port)
{
    client->connect(ip, port);
    _isConnected = true;
    clientThread = std::thread(updateNet);
}
void NetFacade::disconnect()
{
    _isConnected = false;
}
/*=========Method=============*/
