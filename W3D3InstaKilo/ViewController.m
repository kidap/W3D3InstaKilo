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
#import "PileCollectionViewFlowLayout.h"
#import "MyImageCollection.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>{
  //much better to use properties for setter and getter
}
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) CustomCollectionViewFlowLayout *layout1;
@property (strong, nonatomic) PileCollectionViewFlowLayout *layout2;
@property (strong, nonatomic) UISegmentedControl *groupingSegmentedControl;
@property (strong, nonatomic) UISegmentedControl *changeLayoutSegmentedControl;
//@property (strong, nonatomic) NSSet *allObjects;
@property (strong, nonatomic) MyImageCollection *imageCollection;
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
  //Selec Grouping of images
  self.groupingSegmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Location",@"Subject"]];
  [self.groupingSegmentedControl addTarget:self action:@selector(changeGrouping:) forControlEvents:UIControlEventValueChanged];
  [self.groupingSegmentedControl setUserInteractionEnabled:YES];
  [self.groupingSegmentedControl setSelectedSegmentIndex:0];
  self.navigationItem.titleView = self.groupingSegmentedControl;
  
  //Change the Collection View Layout
  self.changeLayoutSegmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"1",@"2"]];
  [self.changeLayoutSegmentedControl setUserInteractionEnabled:YES];
  [self.changeLayoutSegmentedControl addTarget:self action:@selector(changeLayout:) forControlEvents:UIControlEventValueChanged];
  
  //[self.view addSubview:self.changeLayoutSegmentedControl];
}
-(void)prepareTestData{
  if (!self.imageCollection){
    self.imageCollection = [[MyImageCollection alloc] init];
  }
}
-(void)changeGrouping:(id)sender{
  NSLog(@"Change layout");
  self.imageCollection.groupingSelected = self.groupingSegmentedControl.selectedSegmentIndex;
  
  [self.collectionView reloadData];
  
}
-(void)prepareCollectionView{
  self.collectionView.delegate = self;
  //Set the layout
  self.layout1 = [[CustomCollectionViewFlowLayout alloc] init];
  self.layout2 = [[PileCollectionViewFlowLayout alloc] init];
  [self.collectionView setCollectionViewLayout:self.layout1 animated:YES completion:nil];
}
-(void)prepareGestures{
  //Delete item
  UITapGestureRecognizer *doubleTapToDelete = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(doubleTapToDelete:)];
  doubleTapToDelete.numberOfTapsRequired = 2;
  [self.collectionView addGestureRecognizer:doubleTapToDelete];
  
  //Change layout
  UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesture:)];
  [self.collectionView addGestureRecognizer:pinchGesture];
  
  //Move item
  UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
  [self.collectionView addGestureRecognizer:longPressGesture];
}

//MARK: Collection View datasouce and delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
  return self.imageCollection.imageArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  return [self.imageCollection.imageArray[section] count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
  MyImage *myOwnImage = (MyImage *)[self.imageCollection.imageArray[indexPath.section] objectAtIndex:indexPath.item];
  cell.imageView.image = myOwnImage.image;
  
  return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
          viewForSupplementaryElementOfKind:(NSString *)kind
                                atIndexPath:(NSIndexPath *)indexPath{
  //Set Header Text
  if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
    HeaderCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                              withReuseIdentifier:@"Header"
                                                                                     forIndexPath:indexPath];
    header.headerLabel = [self.imageCollection.imageArrayHeader[self.groupingSegmentedControl.selectedSegmentIndex] objectAtIndex:self.imageCollection.groupingSelected];
  }
  return nil;
}
//MARK: Gestures
-(void)doubleTapToDelete:(UITapGestureRecognizer *)recognizer{
  CGPoint tapLocation = [recognizer locationInView:self.collectionView];
  NSIndexPath *indexPathSelection;
  
  if (recognizer.state == UIGestureRecognizerStateEnded) {
    indexPathSelection = (NSIndexPath *)[self.collectionView indexPathForItemAtPoint:tapLocation];
    [self deleteObjectFromDataSource:indexPathSelection];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPathSelection] ];
  }
}
-(void)pinchGesture:(UIPinchGestureRecognizer *)recognizer{
  switch (recognizer.state) {
    case UIGestureRecognizerStateBegan:
      break;
    case UIGestureRecognizerStateChanged:
      break;
    case UIGestureRecognizerStateEnded:
      if (self.collectionView.collectionViewLayout == self.layout1){
        [self.collectionView setCollectionViewLayout:self.layout2 animated:YES];
      } else {
        [self.collectionView setCollectionViewLayout:self.layout1 animated:YES];
      }
      break;
      
    default:
      break;
  }
}
-(void)longPressGesture:(UILongPressGestureRecognizer *)recognizer{
  switch (recognizer.state) {
    case UIGestureRecognizerStateBegan:{
      
      //NSIndexPath *indexPathSelection = [self.collectionView indexPathForItemAtPoint:[recognizer locationInView:self.collectionView]];
      //handle gesture
      NSLog(@"Long pressed");
      break;
    }
    case UIGestureRecognizerStateChanged:
      break;
    case UIGestureRecognizerStateEnded:
      break;
      
    default:
      break;
  }
}
//MARK: Actions
-(void)changeLayout:(id)sender{
  switch (self.groupingSegmentedControl.selectedSegmentIndex) {
    case 0:
      [self.collectionView setCollectionViewLayout:self.layout1 animated:YES];
      break;
    case 1:
      [self.collectionView setCollectionViewLayout:self.layout2 animated:YES];
      break;
  }
}
//MARK: Data source methods
-(void)addObjectToDataSource:(UIImage *)newImage{
  [self.imageCollection addImage:newImage];
}
-(void)deleteObjectFromDataSource:(NSIndexPath *)indexPath{
  [self.imageCollection deleteImage:indexPath];
}
@end
