//
//  LocationFortesting.h
//  GCD_UnitTest_Sample
//
//  Created by wujun zhao on 5/7/13.
//  Copyright (c) 2013 wujun zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Location()

@property BOOL geocodePending;

- (float)calculateSpeedInMPH:(float)speedInMetersPerSecond;

@end