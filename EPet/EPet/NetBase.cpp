//
//  NetBase.cpp
//  EPet
//
//  Created by walter on 14-9-26.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#include "NetBase.h"

#include <netinet/in.h>

NetBase::NetBase()
{
    socketFileDescriptor = socket(AF_INET, SOCK_STREAM, 0);
    if (socketFileDescriptor == -1) {
        error = (char*)"not create socket.";
    }
    else
    {
        init();
        error = NULL;
    }
}

NetBase::NetBase(int socketHandle)
{
    socketFileDescriptor = socketHandle;
    if (socketFileDescriptor == -1) {
        error = (char*)"not create socket.";
    }
    else
    {
        init();
        error = NULL;
    }

}

void NetBase::init()
{
    writeBuff = new std::queue<IDataWraper*>;
    readBuff = new std::queue<IDataWraper*>;
    swapeBuff = new std::queue<IDataWraper*>;
    timeout.tv_sec = 0;
    timeout.tv_usec = 100;
}

NetBase::~NetBase()
{
    delete writeBuff;
    delete readBuff;
    delete swapeBuff;
    
    close();
}

char* NetBase::getError()
{
    return  error;
}

BOOL NetBase::send(IDataWraper *data)
{
    if(socketFileDescriptor == -1)
        return  false;
    if(data == NULL)
        return true;
    mtx.lock();
    writeBuff->push(data);
    mtx.unlock();
    return  true;
}

void NetBase::update()
{
    Byte *ptr;
    std::queue<IDataWraper*> *temp;
    //write.
    mtx.lock();
    if(!writeBuff->empty())
    {
        temp = writeBuff;
        writeBuff = swapeBuff;
        swapeBuff = temp;
    }
    mtx.unlock();
    for(int i = 0, max  = swapeBuff->size(); i < max; i++)
    {
        dateWraper = swapeBuff->front();
        dataSize = dateWraper->serialization(data);
        if(dataSize > 0)
        {
            ptr = data;
            while (true) {
                wtRdSize = write(socketFileDescriptor, ptr, dataSize);
                if(wtRdSize <= 0)
                {
                    //error.
                    break;
                }
                else
                {
                    if(wtRdSize < dataSize)
                    {
                        //not write over.
                        dataSize -= wtRdSize;
                        ptr += wtRdSize;
                    }
                }
            }
            
        }
        swapeBuff->pop();
    }
    
    //read.
    __DARWIN_FD_ZERO(&fdset);
    __DARWIN_FD_SET(socketFileDescriptor,&fdset);
    if(select(socketFileDescriptor+1, &fdset, NULL, NULL, &timeout) > 0)
    {
        if(__DARWIN_FD_ISSET(socketFileDescriptor, &fdset))
        {
            wtRdSize = read(socketFileDescriptor, data, BUFFMAXSIZE);
        }
    }
}

void NetBase::close()
{
    if(socketFileDescriptor != -1)
    {
        if (shutdown(socketFileDescriptor, SHUT_RDWR) == -1) {
            error = (char*)"not shutdow.";
        }
        else
        {
            error = NULL;
        }
    }
}
