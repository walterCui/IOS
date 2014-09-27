//
//  NetClient.h
//  EPet
//
//  Created by walter on 14-9-26.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#ifndef __EPet__NetClient__
#define __EPet__NetClient__

#include <stdio.h>
#include "NetBase.h"

class NetClient:public NetBase
{
public:
    BOOL connect(char* ip, int port);
};
#endif /* defined(__EPet__NetClient__) */
