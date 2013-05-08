//
//  AwardsCell.m
//  GCD_UnitTest_Sample
//
//  Created by wujun zhao on 5/4/13.
//  Copyright (c) 2013 wujun zhao. All rights reserved.
//

#import "AwardsCell.h"

@implementation AwardsCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        //
        
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 45)];
        self.backgroundView = bg;
        self.backgroundView.backgroundColor = [UIColor lightGrayColor];
        
        UIImageView *bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(3, 0, 68, 45)];
        bgImg.image = [UIImage imageNamed:@"mapViewGrey.png"];
        [self.backgroundView addSubview:bgImg];
        
        UIView *sbg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 45)];
        self.selectedBackgroundView = sbg;
        self.selectedBackgroundView.backgroundColor = [UIColor lightGrayColor];
        
        UIImageView *sbgImg = [[UIImageView alloc] initWithFrame:CGRectMake(3, 0, 68, 45)];
        sbgImg.image = [UIImage imageNamed:@"mapView.png"];
        [self.selectedBackgroundView addSubview:sbgImg];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
