//
//  ViewController.h
//  GCD_UnitTest_Sample
//
//  Created by wujun zhao on 5/3/13.
//  Copyright (c) 2013 wujun zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>{
    NSArray *numInPickerView;
    int randomNum, selectedNum;
}

@property (strong, nonatomic) IBOutlet UILabel *lalDescription;
@property (strong, nonatomic) IBOutlet UIPickerView *numPicker;
@property (weak, nonatomic) IBOutlet UIButton *btnChooseNum;
@property (weak, nonatomic) IBOutlet UILabel *resultDescription;
@property (strong, nonatomic) IBOutlet UIButton *btnAwards;

- (IBAction)createRandomNum:(id)sender;
- (void)getRandomNum;

@end
