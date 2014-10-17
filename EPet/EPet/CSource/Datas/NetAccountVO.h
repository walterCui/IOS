//
//  NetSignup.h
//  EPet
//
//  Created by walter on 14-10-13.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#ifndef __EPet__NetSignup__
#define __EPet__NetSignup__

#include <stdio.h>
#include "NetDataBase.h"

class AccountVO:public NetDataBase
{
public:
    
    //type : 0 = signup, 1 = signin, 2 = signout, 3 =  connect.
    static AccountVO* create(int type, const char * nameValue, const char *pwdValue);
    
    //序列化.
    //将数据写入到data中并返回写入的长度.
    virtual int serialization(Byte data[]);
    //反序列化.
    virtual int deserialization(Byte data[], int offset);
    
private:
    char name[256];
    char pwd[256];
};
#endif /* defined(__EPet__NetSignup__) */
