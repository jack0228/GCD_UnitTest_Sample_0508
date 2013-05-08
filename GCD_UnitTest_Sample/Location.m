//
//  Location.m
//  GCD_UnitTest_Sample
//
//  Created by wujun zhao on 5/5/13.
//  Copyright (c) 2013 wujun zhao. All rights reserved.
//

#import "Location.h"
#import "LocationFortesting.h"

@implementation Location

@synthesize locationManager=locationManager_;
@synthesize speed=speed_;
@synthesize postalCode=postalCode_;
@synthesize geocoder=geocoder_;
@synthesize geocodePending=geocodePending_;
@synthesize speedText=speedText_;

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    postalCode_ = @"Unknown";
    geocodePending_ = NO;
    geocoder_ = [[CLGeocoder alloc]init];
    speedText_ = @"Mph...";
    
    locationManager_ = [[CLLocationManager alloc]init];
    [locationManager_ setDelegate:self];
    [locationManager_ setDesiredAccuracy:kCLLocationAccuracyBestForNavigation];
    [locationManager_ setDistanceFilter:kCLDistanceFilterNone];
    
    return self;
    
}

- (void)startLocationUpdates {
    [self.locationManager startUpdatingLocation];
}

- (void)updatePostalCode:(CLLocation *)newLocation withHandler:(CLGeocodeCompletionHandler)completionHandler {
    //test 1: UpdatePostalCodeDoesNotCallReverseGeocodeWhenPendingYes
    if (geocodePending_ == YES) {
        return;
    }
    
    //test 2: UpdatePostalCodeCallsReverseGeocodeWhenPendingNo
    geocodePending_ = YES;
    
    //test 3: UpdatePostalCodeSetsPending
    [[self geocoder]reverseGeocodeLocation:newLocation
                         completionHandler:completionHandler];
    
}

- (float)calculateSpeedInMPH:(float)speedInMetersPerSecond {
    
    float speedInMetersPerHour = speedInMetersPerSecond * 60 * 60;
    return speedInMetersPerHour / 1609.344;
    
}

#pragma mark - LocationManager Delegate methods

- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    [self updatePostalCode:newLocation
               withHandler:^(NSArray *placemarks, NSError *error){
                   CLPlacemark *placemark = [placemarks objectAtIndex:0];
                   [self setPostalCode:[placemark postalCode]];
                   geocodePending_ = NO;
               }];
    
    float speed = [self calculateSpeedInMPH:[newLocation speed]];
    speed_ = speed;
    
    speedText_ = [NSString stringWithFormat:@"%.0f MPH",speed];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"LocationChange" object:self];
    
}
@end
