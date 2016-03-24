//
//  PileUICollectionViewFlowLayout.m
//  W3D3InstaKilo
//
//  Created by Karlo Pagtakhan on 03/24/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import "PileCollectionViewFlowLayout.h"

@interface PileCollectionViewFlowLayout()

@property (strong, nonatomic) NSMutableSet *deletedArray;
@property (strong, nonatomic) NSMutableSet *updatedArray;
@end

@implementation PileCollectionViewFlowLayout
-(instancetype)init{
  self = [super init];
  if (self) {
    self.itemSize = CGSizeMake(75, 75);
    self.minimumLineSpacing = 10;
    self.minimumInteritemSpacing = 10;
    self.sectionInset = UIEdgeInsetsMake(3, 3, 3, 3);
    self.headerReferenceSize = CGSizeMake(self.collectionView.contentSize.width, 40);
    
//    [self registerClass:[DecorationCollectionReusableView class] forDecorationViewOfKind:@"decoration"];
  }
  return self;
}

-(void)prepareForCollectionViewUpdates:(NSArray<UICollectionViewUpdateItem *> *)updateItems{
  // Keep track of insert and delete index paths
  [super prepareForCollectionViewUpdates:updateItems];
  
  self.deletedArray = [[NSMutableSet alloc] init];
  self.updatedArray = [[NSMutableSet alloc] init];
  
  //Save the deleted indices
  for (UICollectionViewUpdateItem *item in updateItems){
    if (item.updateAction == UICollectionUpdateActionDelete){
      [self.deletedArray addObject:item.indexPathBeforeUpdate];
    }
  }
  
}

//Change the final position of the cell
-(UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath{
  UICollectionViewLayoutAttributes *attribute = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
  
  if([self.deletedArray containsObject:itemIndexPath]){
    attribute.center = CGPointMake(CGRectGetMidX(self.collectionView.bounds), CGRectGetMaxY(self.collectionView.bounds)+CGRectGetMaxY(attribute.frame));
    NSLog(@"finalLayoutAttributes - Item:%ld, Section:%ld", itemIndexPath.item, itemIndexPath.section);
  }
  
  return attribute;
}

//Implement the two methods below to change the attributes of the cells
//----------------------------------------------------------
//Investigate why header missing after this was implemented
//----------------------------------------------------------
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
  NSMutableArray* attributes = [[NSMutableArray alloc] init];
  //Get all the attributes of the all objects
  for (int section = 0; section < [self.collectionView numberOfSections]; section++) {
    for (int item = 0; item < [self.collectionView numberOfItemsInSection:section]; item++) {
      [attributes addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:section]]];
    }
  }
  return attributes;
}
//Transform the cell
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
  UICollectionViewLayoutAttributes *attribute = [super layoutAttributesForItemAtIndexPath:indexPath];
  CGFloat degrees;
  int randomNum = arc4random_uniform(10);
  
  degrees = (randomNum * M_PI) /180.0;
  attribute.transform = CGAffineTransformMakeRotation(degrees);
  
  return attribute;
}

@end
