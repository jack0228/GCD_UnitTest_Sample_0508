//
//  MapViewViewController.h
//  GCD_UnitTest_Sample
//
//  Created by wujun zhao on 5/5/13.
//  Copyright (c) 2013 wujun zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "Location.h"

@interface MapViewViewController : UIViewController

//need to use strong type because in the Logic test this will be the only reference to the object
@property (strong, nonatomic) IBOutlet MKMapView *AwardsMapView;
@property (strong, nonatomic) IBOutlet UILabel *lalSpeed;

@property (nonatomic, strong) Location *location;
@property (strong, nonatomic) NSString *gotAwards;

- (void)beginLocationUpdates: (Location *)location;
- (void)handleLocationChange:(NSNotification *)notification;
- (void)handleMapTap;
@end
