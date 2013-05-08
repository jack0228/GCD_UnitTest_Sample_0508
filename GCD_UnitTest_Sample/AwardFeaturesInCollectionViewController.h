//
//  AwardFeaturesInCollectionViewController.h
//  GCD_UnitTest_Sample
//
//  Created by wujun zhao on 5/3/13.
//  Copyright (c) 2013 wujun zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AwardsCell.h"
#import "MapViewViewController.h"

@interface AwardFeaturesInCollectionViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>{
    AwardsCell *cell;
    MapViewViewController *showMap;
}

@property (strong, nonatomic) IBOutlet UICollectionView *AwardsCollectionView;
@end
