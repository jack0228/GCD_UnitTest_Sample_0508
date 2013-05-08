//
//  MapViewControllerTests.m
//  GCD_UnitTest_Sample
//
//  Created by wujun zhao on 5/7/13.
//  Copyright (c) 2013 wujun zhao. All rights reserved.
//
//create a test case file, and usng a setup and tearDown to create a fresh instance of the viewcontroller for testing
 

#import "MapViewControllerTests.h"
#import "OCMock.h"

@implementation MapViewControllerTests
@synthesize mapViewViewController = mapViewViewController_;

- (void)setUp {
    self.mapViewViewController = [[MapViewViewController alloc]init];
}

- (void)tearDown {
    self.mapViewViewController = nil;
}

- (void)testViewControllerCreated
{
    STAssertNotNil(self.mapViewViewController, @"mapViewController is not created");
}

//1
-(void) testViewDidLoadSetsLocation
{
    [self.mapViewViewController setGotAwards:@"YES"];
    [self.mapViewViewController viewDidLoad];
    STAssertNotNil([self.mapViewViewController location], @"location was not set");
}

//2
- (void)testViewDidLoadCallsBeginLocationUpdates {
    //create the mapviewcontroller partial mock
    id mockVC = [OCMockObject partialMockForObject:self.mapViewViewController];
    [[mockVC expect] beginLocationUpdates:[OCMArg any]];// don't care what's the argument for here
    [self.mapViewViewController setGotAwards:@"YES"];
    [mockVC viewDidLoad];
    [mockVC verify];
    
}

//3
- (void)testViewDidLoadSetsUserTrackingMode {
    //create a mock, nicemock ignores unexpected calls, this allows to verify that the expected call happens and not worry about whether other calls are made
    id mock = [OCMockObject niceMockForClass:[MKMapView class]];
    //tell the mock waht to expect
    [[mock expect] setUserTrackingMode:MKUserTrackingModeFollow];
    //set the Awards condition
    [self.mapViewViewController setGotAwards:@"YES"];
    //set the mapview property on the view controller
    [self.mapViewViewController setAwardsMapView:(MKMapView *)mock];
    //execute the code by calling viewdidload
    [self.mapViewViewController viewDidLoad];
    [mock verify];
    
}

//4
- (void)testBeginLocationUpdates {
    id mock = [OCMockObject mockForClass:[Location class]];
    [[mock expect] startLocationUpdates];
    [self.mapViewViewController setGotAwards:@"YES"];
    [self.mapViewViewController beginLocationUpdates:mock];
    [mock verify];
    
}

- (void)testLocationChangeNotificationUpdatesSpeed {
    id locationMock = [OCMockObject mockForClass:[Location class]];
    [(Location *)[[locationMock stub] andReturn:@"65 MPH"] speedText];
    
    //create a notification mock 
    id notificationMock = [OCMockObject mockForClass:[NSNotification class]];
    //stub the object method and return the lcoation object
    [[[notificationMock stub] andReturn:(Location *)locationMock] object];
    
    //create a mock for the label
    id labelMock = [OCMockObject mockForClass:[UILabel class]];
    [[labelMock expect] setText:@"65 MPH"];
    
    [self.mapViewViewController setLalSpeed:labelMock];
    
    [self.mapViewViewController handleLocationChange:(NSNotification *)notificationMock];
    
    [labelMock verify];
    
}

- (void)testThatNotificationHandlerCalled {
    
    id mockVC = [OCMockObject partialMockForObject:self.mapViewViewController];
    [[mockVC expect] handleLocationChange:[OCMArg any]];
    
    [self.mapViewViewController setGotAwards:@"YES"];
    
    [mockVC viewDidLoad];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LocationChange" object:nil];
    
    [mockVC verify];
    
}

- (void)testThatNotificationHandlerNotCalledAfterUnload {
    
    id mockVC = [OCMockObject partialMockForObject:self.mapViewViewController];
    //the unexpect call to the notification handler would be passed to the object handler, so we need to tell the mock to reject and that's fail if a call is made to notifiction handler
    [[mockVC reject] handleLocationChange:[OCMArg any]];
    //set the awards condition
    [self.mapViewViewController setGotAwards:@"YES"];
    
    [mockVC viewDidLoad];
    [mockVC viewDidUnload];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LocationChange" object:nil];
    
    [mockVC verify];
    
}

- (void)testTapGestureHandlerSetsUserTrackingModeFollow {
    
    id mock = [OCMockObject mockForClass:[MKMapView class]];
    [[mock expect] setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    [self.mapViewViewController setAwardsMapView:(MKMapView *)mock];
    [self.mapViewViewController handleMapTap];
    
    [mock verify];
    
}


- (void)testViewDidLoadSetsMapViewGestureRecognizer {
    //nicemock ignores unexpected calls, this allows to verify that the expected call happens and not worry about whether other calls are made
    id mock = [OCMockObject niceMockForClass:[MKMapView class]];
    [[mock expect] addGestureRecognizer:[OCMArg any]];
    //set the awards condition
    [self.mapViewViewController setGotAwards:@"YES"];
    [self.mapViewViewController setAwardsMapView:(MKMapView *)mock];
    
    [self.mapViewViewController viewDidLoad];
    
    [mock verify];
    
}

@end
