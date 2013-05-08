//
//  ViewController.m
//  GCD_UnitTest_Sample
//
//  Created by wujun zhao on 5/3/13.
//  Copyright (c) 2013 wujun zhao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize btnChooseNum;
@synthesize lalDescription;
@synthesize resultDescription;
@synthesize numPicker;

dispatch_queue_t secondQueue;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Awarding funs";
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    numInPickerView = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)createRandomNum:(id)sender
{
    //create a new queue
    secondQueue = dispatch_queue_create("Second queue for creating random num", nil);
    
    //Add clock to the queue
    dispatch_async(secondQueue, ^{
        [self getRandomNum];
    });
}

- (void)getRandomNum
{
    [NSThread sleepForTimeInterval:3];
    
    randomNum = (arc4random()%10) + 0;
    NSLog(@"Check the random number: %d", randomNum);
    
    if (randomNum == selectedNum)
    {
        resultDescription.text = @"Congrats!";
        resultDescription.textColor = [UIColor redColor];
        //NSLog(@"Congrats!");
    }else{
        resultDescription.text = @"Try Again!";
        resultDescription.textColor = [UIColor greenColor];
    }
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [numInPickerView count];
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [numInPickerView objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    selectedNum = [[numInPickerView objectAtIndex:row] integerValue];
    NSLog(@"Check the selected num: %d", [[numInPickerView objectAtIndex:row] integerValue]);
    
}

@end
