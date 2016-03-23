//
//  ViewController.m
//  W3D3InstaKilo
//
//  Created by Karlo Pagtakhan on 03/23/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import "ViewController.h"
#import "ImageCollectionViewCell.h"
#import "CollectionReusableView.h"
#import "MyImage.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>{
  //much better to use properties for setter and getter
}
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *imageArray;
@property (strong, nonatomic) UICollectionViewFlowLayout *layout1;
@property (strong, nonatomic) UISegmentedControl *groupingSegmentedControl;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  [self addUIElements];
  [self prepareTestData];
  
}

//MARK: Preparation
-(void)addUIElements{
  self.groupingSegmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Location",@"Subject"]];
  [self.groupingSegmentedControl addTarget:self action:@selector(changeGrouping:) forControlEvents:UIControlEventValueChanged];
  [self.groupingSegmentedControl setUserInteractionEnabled:YES];
  [self.groupingSegmentedControl setSelectedSegmentIndex:0];
  self.navigationItem.titleView = self.groupingSegmentedControl;
}
-(void)prepareTestData{
  [self dataByGroup];
}
-(void)changeGrouping:(id)sender{
  NSLog(@"Change layout");
  [self rebuildDataSource];
  [self.collectionView reloadData];
  
}
-(void)rebuildDataSource{
  NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
  NSMutableSet *objectsMovingToSecondtSet = [[NSMutableSet alloc] init];
  NSMutableSet *objectsMovingToFirstSet = [[NSMutableSet alloc] init];
  
  switch (self.groupingSegmentedControl.selectedSegmentIndex) {
      
    case 0:{
      [self dataByLocation];
      break;
    }
    case 1: {
      [self dataByGroup];
      break;
      
      
      //      int sectionCtr = 0;
      //      for (NSMutableArray *section in self.imageArray){
      //        int itemCtr = 0;
      //        for (MyImage *item in section){
      //          if (sectionCtr == 0 && [item.group isEqualToString:@"2"]) {
      //            //Add item to the next section
      //            [objectsMovingToSecondtSet addObject:item];
      //
      //            NSMutableArray *indexPair = [[NSMutableArray alloc] init];
      //            [indexPair addObject:[NSIndexPath indexPathForItem:itemCtr
      //                                                     inSection:sectionCtr]];
      //            NSLog(@"%d,%d",itemCtr,sectionCtr);
      //            [indexPair addObject:[NSIndexPath indexPathForItem:0
      //                                                     inSection:1]];
      //            NSLog(@"0,1");
      //            [indexPaths addObject:indexPair];
      //
      //          } else if (sectionCtr == 1 && [item.group isEqualToString:@"1"]) {
      //            //Add item to the next section
      //            [objectsMovingToFirstSet addObject:item];
      //
      //            NSMutableArray *indexPair = [[NSMutableArray alloc] init];
      //            [indexPair addObject:[NSIndexPath indexPathForItem:itemCtr
      //                                                     inSection:sectionCtr]];
      //            NSLog(@"%d,%d",itemCtr,sectionCtr);
      //            [indexPair addObject:[NSIndexPath indexPathForItem:0
      //                                                     inSection:0]];
      //            NSLog(@"0,1");
      //            [indexPaths addObject:indexPair];
      //          }
      //          itemCtr++;
      //        }
      //        sectionCtr++;
      //      }
      //
      //      for(MyImage *object in objectsMovingToSecondtSet){
      //        [self.imageArray[1] addObject:object];
      //        [self.imageArray[0] removeObject:object];
      //
      //        NSLog(@"Move to 1 . Location%@, Group%@",object.location, object.group);
      //      }
      //
      //      for(MyImage *object in objectsMovingToFirstSet){
      //        [self.imageArray[0] addObject:object];
      //        [self.imageArray[1] removeObject:object];
      //
      //        NSLog(@"Move to 2 . Location%@, Group%@",object.location, object.group);
      //      }
      //
      //
      //      for (NSMutableArray *index in indexPaths){
      //        NSIndexPath *atIndexPath = (NSIndexPath *)index[0];
      //        NSIndexPath *toIndexPath = (NSIndexPath *)index[1];
      //
      //        NSLog(@"atIndexPath:%ld-%ld, toIndexPath:%ld-%ld",atIndexPath.section, atIndexPath.item,toIndexPath.section, toIndexPath.item);
      //
      //        [self.collectionView moveItemAtIndexPath:[NSIndexPath indexPathForItem:atIndexPath.item inSection:atIndexPath.section]
      //                                     toIndexPath:[NSIndexPath indexPathForItem:toIndexPath.item inSection:toIndexPath.section]];
      //      }
    }
    default:
      break;
  }
}
-(void)dataByLocation{
  
  self.imageArray = [[NSMutableArray alloc] init];
  
  NSMutableArray *tmp = [[NSMutableArray alloc] init];
  tmp = [@[ [[MyImage alloc] initWithImage:[UIImage imageNamed:@"fin"] withLocation:@"1" withGroup:@"1"],
            [[MyImage alloc] initWithImage:[UIImage imageNamed:@"kyloren"] withLocation:@"1" withGroup:@"1"],
            [[MyImage alloc] initWithImage:[UIImage imageNamed:@"dog1"] withLocation:@"1" withGroup:@"1"],
            [[MyImage alloc] initWithImage:[UIImage imageNamed:@"luke"] withLocation:@"1" withGroup:@"1"],
            [[MyImage alloc] initWithImage:[UIImage imageNamed:@"dog3"] withLocation:@"1" withGroup:@"1"],
            [[MyImage alloc] initWithImage:[UIImage imageNamed:@"dog5"] withLocation:@"1" withGroup:@"1"],
            [[MyImage alloc] initWithImage:[UIImage imageNamed:@"rey"] withLocation:@"1" withGroup:@"1"]] mutableCopy];
  
  
  
  [self.imageArray addObject:tmp];
  
  NSMutableArray *tmp2 = [[NSMutableArray alloc] init];
  
  tmp2 = [@[ [[MyImage alloc] initWithImage:[UIImage imageNamed:@"hansolo"] withLocation:@"1" withGroup:@"2"],
             [[MyImage alloc] initWithImage:[UIImage imageNamed:@"dog2"] withLocation:@"1" withGroup:@"2"],
             [[MyImage alloc] initWithImage:[UIImage imageNamed:@"leia"] withLocation:@"1" withGroup:@"2"],
             [[MyImage alloc] initWithImage:[UIImage imageNamed:@"dog4"] withLocation:@"1" withGroup:@"2"],
             [[MyImage alloc] initWithImage:[UIImage imageNamed:@"poe"] withLocation:@"1" withGroup:@"2"],
             [[MyImage alloc] initWithImage:[UIImage imageNamed:@"dog6"] withLocation:@"1" withGroup:@"2"]] mutableCopy];
  
  [self.imageArray addObject:tmp2];
}
-(void)dataByGroup{
  
  self.imageArray = [[NSMutableArray alloc] init];
  
  NSMutableArray *tmp = [[NSMutableArray alloc] init];
  tmp = [@[ [[MyImage alloc] initWithImage:[UIImage imageNamed:@"fin"] withLocation:@"1" withGroup:@"1"],
            [[MyImage alloc] initWithImage:[UIImage imageNamed:@"hansolo"] withLocation:@"1" withGroup:@"2"],
            [[MyImage alloc] initWithImage:[UIImage imageNamed:@"kyloren"] withLocation:@"1" withGroup:@"1"],
            [[MyImage alloc] initWithImage:[UIImage imageNamed:@"leia"] withLocation:@"1" withGroup:@"2"],
            [[MyImage alloc] initWithImage:[UIImage imageNamed:@"luke"] withLocation:@"1" withGroup:@"1"],
            [[MyImage alloc] initWithImage:[UIImage imageNamed:@"poe"] withLocation:@"1" withGroup:@"2"],
            [[MyImage alloc] initWithImage:[UIImage imageNamed:@"rey"] withLocation:@"1" withGroup:@"1"]] mutableCopy];
  
  [self.imageArray addObject:tmp];
  
  NSMutableArray *tmp2 = [[NSMutableArray alloc] init];
  
  tmp2 = [@[ [[MyImage alloc] initWithImage:[UIImage imageNamed:@"dog1"] withLocation:@"1" withGroup:@"1"],
             [[MyImage alloc] initWithImage:[UIImage imageNamed:@"dog2"] withLocation:@"1" withGroup:@"2"],
             [[MyImage alloc] initWithImage:[UIImage imageNamed:@"dog3"] withLocation:@"1" withGroup:@"1"],
             [[MyImage alloc] initWithImage:[UIImage imageNamed:@"dog4"] withLocation:@"1" withGroup:@"2"],
             [[MyImage alloc] initWithImage:[UIImage imageNamed:@"dog5"] withLocation:@"1" withGroup:@"1"],
             [[MyImage alloc] initWithImage:[UIImage imageNamed:@"dog6"] withLocation:@"1" withGroup:@"2"]] mutableCopy];
  
  [self.imageArray addObject:tmp2];
}

//Collection View datasouce and delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
  return self.imageArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  return [self.imageArray[section] count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
  ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
  
  MyImage *myOwnImage = (MyImage *)[self.imageArray[indexPath.section] objectAtIndex:indexPath.item];
  cell.imageView.image = myOwnImage.image;
  
  return cell;
  
}

//MARK: Collection View Flow Layout
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
          viewForSupplementaryElementOfKind:(NSString *)kind
                                atIndexPath:(NSIndexPath *)indexPath{
  
  if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
    CollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                        withReuseIdentifier:@"Header"
                                                                               forIndexPath:indexPath];
    switch (indexPath.section) {
      case 0: {
        switch (self.groupingSegmentedControl.selectedSegmentIndex) {
            
          case 0:header.headerLabel.text = @"Earth";
            break;
            
          case 1:header.headerLabel.text = @"Star Wars";
            break;
        }
        
        
        break;
      }
      case 1:
        switch (self.groupingSegmentedControl.selectedSegmentIndex) {
            
          case 0:header.headerLabel.text = @"Mars";
            break;
            
          case 1:header.headerLabel.text = @"Dogs";
            break;
        }
        
        break;
        
      default:
        break;
    }
    
    return header;
    
    //  } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
    //    UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind
    //                                                                          withReuseIdentifier:@"Footer"
    //                                                                                 forIndexPath:indexPath];
    //    return footer;
  }
  
  return nil;
}

@end
