//
//  NetSignup.cpp
//  EPet
//
//  Created by walter on 14-10-13.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#include "NetAccountVO.h"
#include "NetConstant.h"

AccountVO* AccountVO::create(int type, const char * nameValue = NULL, const char *pwdValue = NULL)
{
    AccountVO *temp = new AccountVO();
    
    switch (type) {
        case 0:
            temp->destType = 1;
            NetSeesion::reset();
            temp->msgId = requesCode::signup;
            strcpy(temp->name, nameValue);
            strcpy(temp->pwd, pwdValue);
            break;
        case 1:
            NetSeesion::reset();
            temp->destType = 1;
            temp->msgId = requesCode::signin;
            strcpy(temp->name, nameValue);
            strcpy(temp->pwd, pwdValue);
            break;
        case 2:
            temp->destType = 4;
            temp->msgId = requesCode::signout;
//            temp->name = NULL;
//            temp->pwd = NULL;
            break;
        case 3:
            temp->destType = 4;
            temp->msgId = requesCode::connect;
            break;
        default:
            temp = NULL;
            break;
    }
    return temp;
}
int AccountVO::serialization(Byte *data)
{
    int i = NetDataBase::serialization(data);
    if(requesCode::signup == msgId || requesCode::signin == msgId)
    {
        i += Converter::toBytes(data, i, name);
        i += Converter::toBytes(data, i, pwd);
    }
    else
    {
        i += Converter::toBytes(data, i, 1);
    }
    return  i;
}

int AccountVO::deserialization(Byte *data, int offset)
{
    int i = NetDataBase::deserialization(data, offset);
    return  i;
}