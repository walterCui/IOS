//
//  NetSession.cpp
//  EPet
//
//  Created by walter on 14-10-13.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#include "NetSession.h"

int NetSeesion::dialogId = 0;
unsigned long long NetSeesion::uId = 0;
int NetSeesion::GetDialogId()
{
    return dialogId;
}

unsigned long long NetSeesion::GetUID()
{
    return uId;
}