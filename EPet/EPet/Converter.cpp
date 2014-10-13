//
//  Converter.cpp
//  EPet
//
//  Created by walter on 14-10-13.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#include "Converter.h"

int Converter::toBytes(Byte *bytes, int start, char value)
{
    bytes[start] = value;
    return 1;
}

int Converter::toBytes(Byte *bytes, int start, short value)
{
    bytes += start;
    HTONS(value);
    memcpy(bytes, &value, sizeof(short));
    return  sizeof(short);
}

int Converter::toBytes(Byte *bytes, int start, unsigned short value)
{
    return toBytes(bytes, start, (short)value);
}

int Converter::toBytes(Byte *bytes, int start, int value)
{
    bytes += start;
    HTONL(value);
    memcpy(bytes, &value, sizeof(int));
    return sizeof(int);
}

int Converter::toBytes(Byte *bytes, int start, long long value)
{
    bytes += start;
    HTONLL(value);
    memcpy(bytes, &value, sizeof(long long));
    return  sizeof(long long);
}


int Converter::toBytes(Byte *bytes, int start, unsigned long long value)
{
    return  toBytes(bytes, start, (long long)value);
}


char Converter::getChar(Byte *bytes, int &start)
{
    start++;
    return (char)bytes[start - 1];
}

short Converter::getShort(Byte *bytes, int &start)
{
    short tem = sizeof(short);
    bytes += start;
    start += tem;
    memcpy((void*)&tem,bytes, tem);
    return  ntohs(tem);
    
}

unsigned short Converter::getUShort(Byte *bytes, int &start)
{
    return  (unsigned short)getShort(bytes, start);
    
}


int Converter::getInt(Byte *bytes, int &start)
{
    int temp = 0;
    bytes += start;
    memcpy((void*)&temp, bytes, sizeof(int));
    start += sizeof(int);
    return ntohl(temp);
}


long long Converter::getInt64(Byte *bytes, int &start)
{
    long long tem = 8;
    bytes += start;
    start += tem;
    memcpy((void*)&tem,bytes, 8);
    return  ntohll(tem);
    
}

unsigned long long Converter::getUInt64(Byte *bytes, int &start)
{
    return (unsigned long long)getInt64(bytes, start);
}
