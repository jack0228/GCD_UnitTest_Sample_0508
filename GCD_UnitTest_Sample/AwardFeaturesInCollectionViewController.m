//
//  AwardFeaturesInCollectionViewController.m
//  GCD_UnitTest_Sample
//
//  Created by wujun zhao on 5/3/13.
//  Copyright (c) 2013 wujun zhao. All rights reserved.
//

#import "AwardFeaturesInCollectionViewController.h"
#import "CollectionHeader.h"

@interface AwardFeaturesInCollectionViewController ()

@end

@implementation AwardFeaturesInCollectionViewController
@synthesize AwardsCollectionView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"Awards";
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        //cell.cellBg.image = [UIImage imageNamed:@"mapView.png"];
        //cell.cellBg.image = [UIImage imageNamed:@"mapViewGrey.png"];
    }
    if (indexPath.section == 1) {
        cell.cellBg.image = [UIImage imageNamed:@"whatAwards.png"];
    }
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return CGSizeMake(76.f, 46.f);
    }else
    {
        return CGSizeMake(70.f, 45.f);
    }
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CollectionHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    
    header.headerTitle.textColor = [UIColor whiteColor];
    
    if (indexPath.section == 0) {
        header.headerTitle.text = @"The free Mapview Awards";
    }
    if (indexPath.section == 1) {
        header.headerTitle.text = @"Try and get more Awards";
    }
    
    return header;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 10;
    }
    return 0;
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowAwards"])
    {
        showMap = [segue destinationViewController];
        NSIndexPath *thePath = [[self.AwardsCollectionView indexPathsForSelectedItems] lastObject];
        
        NSLog(@"That should be right! %@", thePath);
        
        if (thePath.row == 0 && thePath.section == 0) {
            showMap.gotAwards = @"YES";
            //NSLog(@"That should be right!");
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
