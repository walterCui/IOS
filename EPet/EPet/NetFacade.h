//
//  NetFacade.h
//  EPet
//  API:
//     isConnected()
//     connect(ip,port).
//     disconnect().
//     update().
//     subscribeResponse(code, callback).
//     unsubscribeResponse(code, callback).
//     subscribeEvent(code, callback).
//     unsubscribeEvent(code, callback).
//  Created by walter on 14-9-9.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#ifndef EPet_NetFacade_h
#define EPet_NetFacade_h

#include <thread>
#include "NetServer.h"
#include "NetClient.h"

class NetFacade {
    
public:
    static NetFacade* GetInstance()
    {
        if(instance == NULL)
            instance = new NetFacade();
        return instance;

    }
    
    NetFacade();
    ~NetFacade();
    
    bool isConnected();
    
    void connect(char *ip, int prot);
    void disconnect();
    
private:
    static void updateNet();//更新socket的读写操作,用于子线程中.
    
private:
    static NetFacade *instance;
    
    bool _isConnected;
    
    NetClient *client;
    
    std::thread clientThread;
    
};
#endif
