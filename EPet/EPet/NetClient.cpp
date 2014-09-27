//
//  NetClient.cpp
//  EPet
//
//  Created by walter on 14-9-26.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#include "NetClient.h"

#include <netinet/in.h>
#include <sys/socket.h>
#include <arpa/inet.h>

BOOL NetClient::connect(char *ip, int port)
{
    if(socketFileDescriptor == -1)
    {
        error = (char*)"the socketFileDescriptor is null";
        return  false;
    }
    
    struct sockaddr_in address;
    bzero(&address, sizeof(struct sockaddr_in));
    address.sin_family = AF_INET;
    address.sin_addr.s_addr = inet_addr(ip);
    address.sin_port = htons(port);
    
    if(-1 == ::connect(socketFileDescriptor,(struct sockaddr*)&address,sizeof(struct sockaddr)))
    {
        error = (char*)"not connect.";
        return  false;
    }
    else{
        error = NULL;
    }
    
    return  true;
}