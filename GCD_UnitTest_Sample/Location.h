//
//  Location.h
//  GCD_UnitTest_Sample
//
//  Created by wujun zhao on 5/5/13.
//  Copyright (c) 2013 wujun zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Location : NSObject <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property float speed;
@property (nonatomic, strong) NSString *postalCode;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong) NSString *speedText;

-(void)startLocationUpdates;
-(float)calculateSpeedInMPH:(float)speedInMetersPerSecond;
- (void)updatePostalCode:(CLLocation *)newLocation withHandler:(CLGeocodeCompletionHandler)completionHandler;

@end
