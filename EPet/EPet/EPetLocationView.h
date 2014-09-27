//
//  EPetLocationView.h
//  EPet
//
//  Created by walter on 14-9-10.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@protocol EPetLocationDelgate;

@interface EPetLocationView : BMKMapView<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

@property id<EPetLocationDelgate> locationDelgate;

-(void)startLocation;
-(void)stopLocation;
@end

@protocol EPetLocationDelgate <NSObject>

-(void)setCurrentAddress:(NSString*)address;

@end
