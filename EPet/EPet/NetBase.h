//
//  NetBase.h
//  EPet
//
//  Created by walter on 14-9-26.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#ifndef __EPet__NetBase__
#define __EPet__NetBase__

#include <stdio.h>
#include "IDataWraper.h"
#include <mutex>
#include <queue>

#define BUFFMAXSIZE 2048

class NetBase
{
public:
    
    NetBase();
    NetBase(int sockedHandle);
    ~NetBase();
    
    char* getError();
    BOOL send(IDataWraper *data);
    //BOOL send(int to, IDataWraper data);
    void ddd();
    virtual void update();
    
    void close();
private:
    void init();
protected:
    int socketFileDescriptor;
    char* error;
    
    std::mutex mtx;
    std::queue<IDataWraper*> *writeBuff;
    std::queue<IDataWraper*> *swapeBuff;
    std::queue<IDataWraper*> *readBuff;
private:
    Byte data[BUFFMAXSIZE]; //用于序列化的buff.
    int dataSize;//序列化后的数据长度.
    IDataWraper *dateWraper;//临时数据.
    int wtRdSize;//用与记录读写socket时的数据长度.
    struct timeval timeout;
    fd_set fdset;

};

#endif /* defined(__EPet__NetBase__) */
