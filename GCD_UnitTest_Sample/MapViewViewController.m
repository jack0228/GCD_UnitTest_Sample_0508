//
//  MapViewViewController.m
//  GCD_UnitTest_Sample
//
//  Created by wujun zhao on 5/5/13.
//  Copyright (c) 2013 wujun zhao. All rights reserved.
//

#import "MapViewViewController.h"

@interface MapViewViewController ()

@end

@implementation MapViewViewController
@synthesize AwardsMapView, lalSpeed, gotAwards;
@synthesize location=location_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)beginLocationUpdates: (Location *)location
{
    [location startLocationUpdates];//4
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if (![gotAwards isEqualToString:@"YES"]) {
        AwardsMapView.hidden = YES;
        lalSpeed.hidden = YES;
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Please go back to the main screen, play and get more awards!"
                              message: nil
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        self.location = [[Location alloc]init];//1
        //[self.location startLocationUpdates]; //test code like this by refactor(Extract) this code to enable testing: moving this line to its own method "beginLocationUpdates", and then passing the location object into it, so should an opportunity there to pass a mock instead of location object doing the testing
        [self beginLocationUpdates: self.location];//2
        [[self AwardsMapView]setUserTrackingMode:MKUserTrackingModeFollow];//3
        
        //register for the location change notification
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleLocationChange:) name:@"LocationChange" object:nil];
        
        UITapGestureRecognizer *mapTapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleMapTap)];
        [self.AwardsMapView addGestureRecognizer:mapTapRecognizer];
    }
}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    self.location = nil;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//notification allow broadcast in an event to multiple listeners generater notification whenever location updates, liste notification, update the speed view when the notification is received 
#pragma mark - Notification Handler

- (void)handleLocationChange:(NSNotification *)notification{
    
    Location *location = [notification object];
    NSString *speed = [location speedText];
    [self.lalSpeed setText:speed];
    
}

#pragma mark - Tap Handler

- (void)handleMapTap {
    [self.AwardsMapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    
}

@end
