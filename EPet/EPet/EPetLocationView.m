//
//  EPetLocationView.m
//  EPet
//
//  Created by walter on 14-9-10.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#import "EPetLocationView.h"

@interface EPetLocationView()

@property BMKLocationService* _locService;
@property BMKGeoCodeSearch *_search;
@property CLLocationManager *cllm;
@end

@implementation EPetLocationView

-(void)startLocation
{
    if([CLLocationManager  authorizationStatus] ==  kCLAuthorizationStatusNotDetermined )
    {
        self.cllm = [[CLLocationManager alloc]init];
        [self.cllm requestWhenInUseAuthorization];
    }

    self._locService = [[BMKLocationService alloc]init];
    self._search = [[BMKGeoCodeSearch alloc]init];
    
    self._search.delegate = self;
    
    self._locService.delegate = self;
    
    [self._locService startUserLocationService];
    self.showsUserLocation = NO;
    self.userTrackingMode = BMKUserTrackingModeFollow;
    self.showsUserLocation = YES;
}
-(void)stopLocation
{
    [self._locService stopUserLocationService];
    
    self._locService.delegate = nil;
    self._search.delegate = nil;
    self._locService = nil;
    self.cllm = nil;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
            }
    return self;
}
-(void)willStartLocatingUser
{
    NSLog(@"start locate");
}

-(void)didStopLocatingUser
{
    NSLog(@"stop locate");
}
/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [self updateLocationData:userLocation];
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    [self updateLocationData:userLocation];
    BMKCoordinateRegion region;
    region.center.latitude = userLocation.location.coordinate.latitude;
    region.center.longitude = userLocation.location.coordinate.longitude;
    region.span.latitudeDelta = 0.01;
    region.span.longitudeDelta = 0.01;
    
    self.region = region;
    [self._locService stopUserLocationService];
    
    //ReverseGeoCode
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = userLocation.location.coordinate;
    
    [self._search reverseGeoCode:reverseGeocodeSearchOption];
}
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

/**
 *返回反地理编码搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    //NSLog(@"%@",result.address);
    if(self.locationDelgate != NULL)
       [self.locationDelgate setCurrentAddress:result.address];
}
@end
