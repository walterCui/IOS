//
//  NetSession.cpp
//  EPet
//
//  Created by walter on 14-10-13.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#include "NetSession.h"

int NetSeesion::playerId = -1;
int NetSeesion::dialogId = -1;
unsigned long long NetSeesion::uId = 99999999;
int NetSeesion::GetDialogId()
{
    return dialogId;
}

unsigned long long NetSeesion::GetUID()
{
    return uId;
}