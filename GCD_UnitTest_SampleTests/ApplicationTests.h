//
//  ApplicationTests.h
//  ApplicationTests
//
//  Created by wujun zhao on 5/3/13.
//  Copyright (c) 2013 wujun zhao. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "ViewController.h"
#import "MapViewViewController.h"
#import "AppDelegate.h"

@interface ApplicationTests : SenTestCase{
    AppDelegate *appDelegate;
    UINavigationController *navController;
}

@property (nonatomic, weak) ViewController *vcTest;
@property (nonatomic, weak) MapViewViewController *vcMapTest;

@end
