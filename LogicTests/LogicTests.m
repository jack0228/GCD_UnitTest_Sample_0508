//
//  LogicTests.m
//  LogicTests
//
//  Created by wujun zhao on 5/6/13.
//  Copyright (c) 2013 wujun zhao. All rights reserved.
//

/*
 With logic tests you can ensure that your code works at the lowest level, usually methods and single classes
 The key rule to follow:
 
 1.Keep test small and independent each other, no test should depend on effects of any other tests
 2.test just one thing in each test
 3.create a separate test case file to test each class in the application, such as the "MapViewControllerTests" in this project
 */

#import "LogicTests.h"
#import "OCMock.h"

//#import <OCMock/OCMock.h>

@implementation LogicTests
@synthesize location=location_;

- (void)setUp
{
    [super setUp];
    
    //create a instance of location class before each test
    self.location = [[Location alloc]init];
}

- (void)tearDown
{
    //remove the instance of location class after each test
    self.location = nil;
    
    [super tearDown];
}

- (void)testOCMockIsWorking {
    id mock = (id)[OCMockObject mockForClass:[NSObject class]];
    STAssertNotNil(mock,@"Mock object not created");
}

- (void)testInit
{
    STAssertNotNil(self.location, @"Test object not created");
}

- (void)testInitSetsPostalCode {
    NSString *pcode = [location_ postalCode];
    STAssertTrue([pcode isEqualToString:@"Unknown"], @"Postal code should be initialized to Unknown but is %@", pcode);
    
}

- (void)testInitSetsGeocodePendingNo {
    STAssertFalse([location_ geocodePending], @"geocodePending should be NO");
    
}

- (void)testInitSetsGeocoder {
    STAssertNotNil([location_ geocoder], @"geocoder not set");
    
}

- (void)testThatInitSetsLocationManager
{ 
    //verify the location class method correctly instantiates an instance of the CLLocationManager class and it's location manager property
    STAssertNotNil([self.location locationManager], @"Location manager property is nil");
    STAssertTrue([[self.location locationManager] isKindOfClass:[CLLocationManager class]], @"locationManager class should be CLLocationManager");
    
}

- (void) testInitSetsLocationManagerDelegate {
    STAssertTrue([[location_ locationManager] delegate] == location_, @"LocationManager's delegate s/b location object");
    
}

- (void)testInitSetsLocationManagerProperties {
    
    STAssertEquals([[location_ locationManager] desiredAccuracy], kCLLocationAccuracyBestForNavigation, @"LocationManager desiredAccuracy property should be %d but is set to %d", kCLLocationAccuracyBestForNavigation, [[location_ locationManager]desiredAccuracy]);
    STAssertEquals([[location_ locationManager] distanceFilter], kCLDistanceFilterNone, @"LocationManager distanceFilter s/b %d but is set to %d", kCLDistanceFilterNone,[[location_ locationManager]distanceFilter]);
    
}

- (void)testStartLocationUpdates {
    id mock = (id)[OCMockObject mockForClass:[CLLocationManager class]];
    //the mock expect a call to startUpdatingLocation method
    [[mock expect] startUpdatingLocation];
    //set location test object reference to location Manager to point the mock instead
    [location_ setLocationManager:mock];
    //execute the call to that code
    [location_ startLocationUpdates];
    //the mock to verify that received the ecpected call
    [mock verify];
    
}

- (void)testUpdatePostalCodeCallsReverseGeocodeWhenPendingNo {
    /*
     1. create a mockup object for the CLGeocoder class
     2. assign the mockup object to the test location object's CLGeocoder property
     3. we need to tell the mockup object to expect a call to reverse GeocodeLocation (when an unexpect method on a mockup object is called meaning we haven't set [mock expect] for that method, OCMock will through an exception causing the test fail)
     4. thwn call the method being tested
     5. ask the mock to verify the method was called
     */
    
    id mock = (id)[OCMockObject mockForClass:[CLGeocoder class]];
    [location_ setGeocoder:(CLGeocoder *)mock];
    [[mock expect] reverseGeocodeLocation:nil completionHandler:nil];
    [location_ updatePostalCode:nil withHandler:nil];
    [mock verify];
}

- (void)testUpdatePostalCodeDoesNotCallReverseGeocodeWhenPendingYes {
    
    //Not expect the method to be called (return at very beginning)
    id mock = (id)[OCMockObject mockForClass:[CLGeocoder class]];
    [location_ setGeocodePending:YES];
    [location_ setGeocoder:(CLGeocoder *)mock];
    [location_ updatePostalCode:nil withHandler:nil];
    [mock verify];
}

- (void)testUpdatePostalCodeSetsPending {
    
    id mock = (id)[OCMockObject mockForClass:[CLGeocoder class]];
    [[mock expect] reverseGeocodeLocation:nil completionHandler:nil];
    [location_ setGeocoder:(CLGeocoder *)mock];
    [location_ updatePostalCode:nil withHandler:nil];
    STAssertTrue([location_ geocodePending], @"geocodePending should have been set");
    
}

/*
 OCMock partial mocks: allows the mockup object to be combined with the real object (create a subclass of the object being tested and overwrite the method being called to set a flag or property indicate that has been called)
 partial mock overwrite some of the method and object //let the original object handle everything else
 
 */

- (void)testLocationManagerDidUpdateUpdatesPostalCode {
    
    id mock = (id)[OCMockObject mockForClass:[CLLocation class]];
    
    double metersPerMile = 1609.344;
    double secondsPerHour = 60 * 60;
    double metersPerSecond = 55.0 * metersPerMile / secondsPerHour;
    //stub are type of feak object used in unit testing 
    [(CLLocation *)[[mock stub] andReturnValue:OCMOCK_VALUE(metersPerSecond)] speed];
    
    //create a partial mock of the test location object
    id mockSelf = [OCMockObject partialMockForObject:location_];
    //tell the partial mockup object to expect a call to updatePostalCode
    [[mockSelf expect] updatePostalCode:[OCMArg any] withHandler:[OCMArg any]];
    [mockSelf locationManager:nil didUpdateToLocation:mock fromLocation:mock];
    
    [mockSelf verify];
    
}

- (void)testCalculateSpeedInMPH
{
    float metersPerMile = 1609.344;
    float secondsPerHour = 60 * 60;
    float mph = [self.location calculateSpeedInMPH:65.0 * metersPerMile / secondsPerHour];
    STAssertTrue(mph == 65.0, @"Calculated speed should be 55 mph but was reported as %f", mph);
}

@end
