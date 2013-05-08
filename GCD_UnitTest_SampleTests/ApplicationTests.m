//
//  ApplicationTests.m
//  ApplicationTests
//
//  Created by wujun zhao on 5/3/13.
//  Copyright (c) 2013 wujun zhao. All rights reserved.
//
//With application tests you make sure that your app’s classes work as designed within the app.

#import "ApplicationTests.h"

@implementation ApplicationTests

@synthesize vcTest = vcTest_;
@synthesize vcMapTest = vcMapTest_;

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    
    UIApplication *application = [UIApplication sharedApplication];
    appDelegate = [application delegate];
    
    navController = (UINavigationController*)appDelegate.window.rootViewController;
    
    self.vcTest = (ViewController *)navController.visibleViewController;
    self.vcMapTest = (MapViewViewController *)navController.visibleViewController;
    
}

- (void)tearDown
{
    // Tear-down code here.
    self.vcTest = nil;
    self.vcMapTest = nil;
    [super tearDown];
}

- (void)testApplicationDelegate {
    STAssertTrue([appDelegate isMemberOfClass:[AppDelegate class]], @"bad UIApplication delegate");
    STAssertTrue([navController isMemberOfClass:[UINavigationController class]], @"bad mainViewController");
}

#pragma mark - IBOutlets Testing

- (void)testViewControllerIsnotNil
{
    STAssertNotNil(self.vcTest, @"ViewController wasn't set");
}

- (void)testThatViewControllerIsntNil
{
    STAssertNotNil(self.vcMapTest, @"mapViewController wasn't set");
}

- (void)testButtonOutletConnected
{
    STAssertNotNil([self.vcTest btnChooseNum], @"Button not connected");
}

- (void)testResultLabelOutletConnected
{
    STAssertNotNil([self.vcTest resultDescription], @"Label not connected");
}

- (void)testDescriptionLabelOutletConnected
{
    STAssertNotNil([self.vcTest lalDescription], @"Label not connected");
}

- (void)testNumberOfLinesInDescriptionLabel
{
    STAssertEquals([self.vcTest.lalDescription numberOfLines], 5, @"The Number of lines for lalDescription should be 5 but is set to %d", [self.vcTest.lalDescription numberOfLines]);
}

- (void)testPickerViewOutletConnected
{
    STAssertNotNil([self.vcTest numPicker], @"PickerView not connected");
}



@end
