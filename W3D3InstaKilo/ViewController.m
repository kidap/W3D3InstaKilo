//
//  ViewController.m
//  W3D3InstaKilo
//
//  Created by Karlo Pagtakhan on 03/23/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import "ViewController.h"
#import "ImageCollectionViewCell.h"
#import "HeaderCollectionReusableView.h"
#import "MyImage.h"
#import "CustomCollectionViewFlowLayout.h"
#import "DecorationCollectionReusableView.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>{
  //much better to use properties for setter and getter
}
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *imageArray;
@property (strong, nonatomic) CustomCollectionViewFlowLayout *layout1;
@property (strong, nonatomic) UISegmentedControl *groupingSegmentedControl;
@property (strong, nonatomic) NSSet *allObjects;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  [self addUIElements];
  [self prepareTestData];
  [self prepareCollectionView];
  [self prepareGestures];
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
  [self addAllObjectsToSet];
  [self dataByLocation
   ];
}
-(void)changeGrouping:(id)sender{
  NSLog(@"Change layout");
  [self rebuildDataSource];
  [self.collectionView reloadData];
  
}
-(void)prepareCollectionView{
  self.collectionView.delegate = self;
  //Set the layout
  self.layout1 = [[CustomCollectionViewFlowLayout alloc] init];
  [self.collectionView setCollectionViewLayout:self.layout1 animated:YES completion:nil];
//  [self.collectionView reloadData];
}
-(void)prepareGestures{
  UITapGestureRecognizer *doubleTapToDelete = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(doubleTapToDelete:)];
  doubleTapToDelete.numberOfTapsRequired = 2;
  [self.collectionView addGestureRecognizer:doubleTapToDelete];
}
-(void)rebuildDataSource{
  
  switch (self.groupingSegmentedControl.selectedSegmentIndex) {
      
    case 0:{
      [self dataByLocation];
      break;
    }
    case 1: {
      [self dataByGroup];
      break;
    }
    default:
      break;
  }
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

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
          viewForSupplementaryElementOfKind:(NSString *)kind
                                atIndexPath:(NSIndexPath *)indexPath{
  
  if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
    HeaderCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                              withReuseIdentifier:@"Header"
                                                                                     forIndexPath:indexPath];
        switch (indexPath.section) {
          case 0: {
            switch (self.groupingSegmentedControl.selectedSegmentIndex) {
              case 0:
                header.headerLabel.text = @"Earth";
                break;
              case 1:
                header.headerLabel.text = @"Star Wars";
                break;
            }
            break;
          }
          case 1:
            switch (self.groupingSegmentedControl.selectedSegmentIndex) {
              case 0:
                header.headerLabel.text = @"Mars";
                break;
              case 1:
                header.headerLabel.text = @"Dogs";
                break;
            }
            break;
          default:
            break;
        }
    return header;
  }
  return nil;
}
//MARK: Collection View Flow Layout

//MARK: Gestures
-(void)doubleTapToDelete:(UITapGestureRecognizer *)recognizer{
  CGPoint tapLocation = [recognizer locationInView:self.collectionView];
  NSIndexPath *indexPathSelection;
  
  if (recognizer.state == UIGestureRecognizerStateEnded) {
    indexPathSelection = (NSIndexPath *)[self.collectionView indexPathForItemAtPoint:tapLocation];
    [self deleteObjectFromDataSource:indexPathSelection];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPathSelection] ];
  }
  
//  NSLog(@"Item:%d, Section:%d", indexPathSelection.item, indexPathSelection.section);
}

//MARK: Helper methods
-(void)addAllObjectsToSet{
  self.allObjects = [[NSSet alloc] initWithArray:@[ [[MyImage alloc] initWithImage:[UIImage imageNamed:@"fin"] withLocation:@"1" withGroup:@"1"],
                                                    [[MyImage alloc] initWithImage:[UIImage imageNamed:@"hansolo"] withLocation:@"2" withGroup:@"1"],
                                                    [[MyImage alloc] initWithImage:[UIImage imageNamed:@"kyloren"] withLocation:@"1" withGroup:@"1"],
                                                    [[MyImage alloc] initWithImage:[UIImage imageNamed:@"leia"] withLocation:@"1" withGroup:@"1"],
                                                    [[MyImage alloc] initWithImage:[UIImage imageNamed:@"luke"] withLocation:@"2" withGroup:@"1"],
                                                    [[MyImage alloc] initWithImage:[UIImage imageNamed:@"poe"] withLocation:@"1" withGroup:@"1"],
                                                    [[MyImage alloc] initWithImage:[UIImage imageNamed:@"rey"] withLocation:@"2" withGroup:@"1"],
                                                    [[MyImage alloc] initWithImage:[UIImage imageNamed:@"dog1"] withLocation:@"1" withGroup:@"2"],
                                                    [[MyImage alloc] initWithImage:[UIImage imageNamed:@"dog2"] withLocation:@"2" withGroup:@"2"],
                                                    [[MyImage alloc] initWithImage:[UIImage imageNamed:@"dog3"] withLocation:@"1" withGroup:@"2"],
                                                    [[MyImage alloc] initWithImage:[UIImage imageNamed:@"dog4"] withLocation:@"2" withGroup:@"2"],
                                                    [[MyImage alloc] initWithImage:[UIImage imageNamed:@"dog5"] withLocation:@"1" withGroup:@"2"],
                                                    [[MyImage alloc] initWithImage:[UIImage imageNamed:@"dog6"] withLocation:@"1" withGroup:@"2"] ]];
}
-(void)deleteObjectFromDataSource:(NSIndexPath *)indexPath{
  NSMutableArray *section = (NSMutableArray *)self.imageArray[indexPath.section];
  [section removeObjectAtIndex:indexPath.item];
  
  NSLog(@"Deleting Item:%ld, Section:%ld", indexPath.item, indexPath.section);
}
-(void)dataByLocation{
  
  self.imageArray = [[NSMutableArray alloc] init];
  
  NSMutableArray *tmp = [[NSMutableArray alloc] init];
  NSMutableArray *tmp2 = [[NSMutableArray alloc] init];
  
  for (MyImage *object in self.allObjects){
    if ([object.location isEqualToString:@"1"]) {
      [tmp addObject:object];
    } else{
      [tmp2 addObject:object];
    }
  }
  
  [self.imageArray addObject:tmp];
  [self.imageArray addObject:tmp2];
}
-(void)dataByGroup{
  self.imageArray = [[NSMutableArray alloc] init];
  
  NSMutableArray *tmp = [[NSMutableArray alloc] init];
  NSMutableArray *tmp2 = [[NSMutableArray alloc] init];
  
  for (MyImage *object in self.allObjects){
    if ([object.group isEqualToString:@"1"]) {
      [tmp addObject:object];
    } else{
      [tmp2 addObject:object];
    }
  }
  
  [self.imageArray addObject:tmp];
  [self.imageArray addObject:tmp2];
}
@end
