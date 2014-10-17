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
#include "NetConstant.h"

#include "NetAccountVO.h"
#include "NetBeauticianVO.h"
#include "NetOrderVO.h"

#include <map>

class NetFacade :public NetClientInterface{
    typedef void (NetFacade::* vv) ();
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
    
    //operatons;
    void signup(const char *name,const  char *pwd);
    void signin(const char *name,const  char *pwd);
    
    void getBeauticianList();
    void getOrderList();
    void createOrder(unsigned long long workerId,int serviceType,int serviceId,int startTime,char *des);
    //
    
    void subscribeResponsHandle(short code, handleDelegate handle);
    
    virtual void handleResponse (short code, Byte *data);
    virtual void handleEvent (short code, Byte *data);
private:
    static void updateNet();//更新socket的读写操作,用于子线程中.    
private:
    static NetFacade *instance;
    
    bool _isConnected;
    
    NetClient *client;
    
    std::thread clientThread;
    
    std::map<short, handleDelegate> handleResponseList;
    
};
#endif
